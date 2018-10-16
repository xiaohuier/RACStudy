//
//  FRPFullSizedPhotoViewModel.m
//  AppDemo
//
//  Created by 周正东 on 2018/10/16.
//  Copyright © 2018年 周正东. All rights reserved.
//

#import "FRPFullSizedPhotoViewModel.h"
#import "FRPPhotoModel.h"

@interface FRPFullSizedPhotoViewModel()
@property (nonatomic) NSInteger initialPhotoIndex;
@property (nonatomic, copy) NSArray<FRPPhotoModel *> *model;
@end

@implementation FRPFullSizedPhotoViewModel

- (instancetype)initWithPhotoArray:(NSArray *)photoArray
                 initialPhotoIndex:(NSInteger)initialPhotoIndex
{
    self = [super init];
    if(!self) return nil;
    self.model = photoArray;
    self.initialPhotoIndex = initialPhotoIndex;
    return self;
}

- (NSString *)initialPhotoName
{
    return [[self photoModelAtIndex:self.initialPhotoIndex] photoName];
}

- (FRPPhotoModel *)photoModelAtIndex:(NSInteger)index {
    if(index < 0 || index > self.model.count - 1) {
        //Index was out of bounds, return nil
        return nil;
    }
    else {
        return self.model[ index ];
    }
}
@end
