//
//  FRPCell.h
//  AppDemo
//
//  Created by eastzhou on 2018/10/8.
//  Copyright © 2018 周正东. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class FRPPhotoModel;
@interface FRPCell : UICollectionViewCell
- (void)setPhotoModel:(FRPPhotoModel *)photoModel;
@end

NS_ASSUME_NONNULL_END
