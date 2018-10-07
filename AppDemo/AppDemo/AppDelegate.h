//
//  AppDelegate.h
//  AppDemo
//
//  Created by 周正东 on 2017/12/25.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong, readonly) PXAPIHelper * apiHelper;

@end

