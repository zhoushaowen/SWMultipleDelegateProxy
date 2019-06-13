//
//  SWMultipleDelegateProxy.h
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/7/2.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import <Foundation/Foundation.h>

//this class can't be inherited
@interface SWMultipleDelegateProxy : NSObject

/**
 each delegate in the allDelegate array must be strong referenced;
 if all delegate implement the same method,the last one's return value will work;
 your should invoke this method before set delegate;
 */
- (void)setAllDelegate:(NSArray *_Nullable)allDelegate;

@end
