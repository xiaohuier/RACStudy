//
//  NSObject+SafeCast.m
//  AppDemo
//
//  Created by eastzhou on 2018/10/8.
//  Copyright © 2018 周正东. All rights reserved.
//

#import "NSObject+SafeCast.h"

@implementation NSObject (SafeCast)
+ (instancetype)safeCase:(id)anyObject
{
    if ([anyObject isKindOfClass:[self class]]) {
        return anyObject;
    }
    if (anyObject == nil) {
        return nil;
    }    NSAssert(NO, @"not my object");
    return nil;
}
@end
