//
//  FRPPhotoViewController.h
//  AppDemo
//
//  Created by eastzhou on 2018/10/10.
//  Copyright © 2018 周正东. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FRPPhotoModel;

NS_ASSUME_NONNULL_BEGIN

@interface FRPPhotoViewController : UIViewController
- (instancetype)initWithPhotoModel:(FRPPhotoModel *)photoModel index:(NSInteger)photoIndex;

@property (nonatomic, readonly) NSInteger photoIndex;
@property (nonatomic, readonly) FRPPhotoModel * photoModel;
@end

NS_ASSUME_NONNULL_END
