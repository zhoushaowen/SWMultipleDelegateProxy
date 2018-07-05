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
 each delegate in the allDelegate array must be strong referenced.
 it will automatically remove duplicate object,if your set two or more same object.
 even if the object in allDelegate is a array or set or dictionary,it also can work.
 your should invoke this method before set delegate.
 */
- (void)setAllDelegate:(NSArray *_Nullable)allDelegate;

@end
