//
//  FRPFullSizePhotoViewController.h
//  AppDemo
//
//  Created by eastzhou on 2018/10/10.
//  Copyright © 2018 周正东. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class FRPFullSizePhotoViewController, FRPPhotoModel;

@protocol FRPFullSizePhotoViewControllerDelegate <NSObject>
- (void)userDidScroll:(FRPFullSizePhotoViewController *)viewController toPhotoAtIndex:(NSInteger)index;

@end
@interface FRPFullSizePhotoViewController : UIViewController
- (instancetype)initWithPhotoModels:(NSArray *)photoModelArray currentPhotoIndex:(NSInteger)photoIndex;

@property (nonatomic , readonly) NSArray<FRPPhotoModel *> *photoModelArray;
@property (nonatomic, weak) id<FRPFullSizePhotoViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
