//
//  SWMultipleDelegateProxy.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/7/2.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "SWMultipleDelegateProxy.h"
#import <objc/runtime.h>

@interface SWMultipleDelegateProxy ()

@property (nonatomic,strong) NSHashTable *weakDelegates;

@end

@implementation SWMultipleDelegateProxy

- (instancetype)init {
    NSAssert([self superclass] == [NSObject class], @"SWMultipleDelegateProxy can't be inherited!");
    return [super init];
}

- (void)setAllDelegate:(NSArray *)allDelegate {
    [self.weakDelegates removeAllObjects];
    allDelegate = [allDelegate copy];
    allDelegate = [self unpackDelegateWithArray:allDelegate];
    [allDelegate enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.weakDelegates addObject:obj];
    }];
}

//unpack the delegate in array or set or dictionary
- (NSArray *)unpackDelegateWithArray:(NSArray *)array {
    NSMutableArray *mutableArray = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj isKindOfClass:[SWMultipleDelegateProxy class]]){
            NSArray *array = [self unpackDelegateWithArray:[(SWMultipleDelegateProxy *)obj allEffectiveDelegate]];
            [mutableArray addObjectsFromArray:array];
        }else if ([obj isKindOfClass:[NSArray class]]){
            [mutableArray addObjectsFromArray:[self unpackDelegateWithArray:(NSArray *)obj]];
        }else if ([obj isKindOfClass:[NSSet class]]){
            NSMutableArray *toArray = [NSMutableArray arrayWithCapacity:((NSSet *)obj).count];
            [(NSSet *)obj enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
                [toArray addObject:obj];
            }];
            [mutableArray addObjectsFromArray:[self unpackDelegateWithArray:toArray]];
        }else if ([obj isKindOfClass:[NSDictionary class]]){
            [mutableArray addObjectsFromArray:[self unpackDelegateWithArray:((NSDictionary *)obj).allValues]];
        }
        else{
            [mutableArray addObject:obj];
        }
    }];

    return [mutableArray copy];
}

- (NSArray *)allEffectiveDelegate {
    return self.weakDelegates.allObjects;
}

- (NSHashTable *)weakDelegates {
    if(!_weakDelegates){
        _weakDelegates = [NSHashTable weakObjectsHashTable];
    }
    return _weakDelegates;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if(signature == nil){
        for (id obj in self.weakDelegates.allObjects) {
            if(obj != self){
                signature = [obj methodSignatureForSelector:aSelector];
            }
            if(signature){
                break;
            }
        }
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    for (id obj in self.weakDelegates.allObjects) {
        if(obj != self && [obj respondsToSelector:anInvocation.selector]){
            [anInvocation invokeWithTarget:obj];
        }
    }
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    if([super respondsToSelector:aSelector]) return YES;
    for (id obj in self.weakDelegates.allObjects) {
        if(obj == self && [super respondsToSelector:aSelector]) return YES;
        if(obj != self && [obj respondsToSelector:aSelector]){
            return YES;
        }
    }
    return NO;
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end