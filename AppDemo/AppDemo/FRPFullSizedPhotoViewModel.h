//
//  FRPFullSizedPhotoViewModel.h
//  AppDemo
//
//  Created by 周正东 on 2018/10/16.
//  Copyright © 2018年 周正东. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FRPPhotoModel;

@interface FRPFullSizedPhotoViewModel : NSObject
- (instancetype)initWithPhotoArray:(NSArray<FRPPhotoModel *> *)photoArray initialPhotoIndex:(NSInteger)initialPhotoIndex;
- (FRPPhotoModel *)photoModelAtIndex:(NSInteger)index;

@property (nonatomic, readonly, copy) NSArray<FRPPhotoModel *> *model;
@property (nonatomic, readonly) NSInteger initialPhotoIndex;
@property (nonatomic, readonly) NSString *initialPhotoName;
@end
