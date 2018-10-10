//
//  NSObject+SafeCast.h
//  AppDemo
//
//  Created by eastzhou on 2018/10/8.
//  Copyright © 2018 周正东. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (SafeCast)
+ (instancetype)safeCase:(id)anyObject;
@end

NS_ASSUME_NONNULL_END
