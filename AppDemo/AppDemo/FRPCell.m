//
//  FRPCell.m
//  AppDemo
//
//  Created by eastzhou on 2018/10/8.
//  Copyright © 2018 周正东. All rights reserved.
//

#import "FRPCell.h"
#import "FRPPhotoModel.h"

@interface FRPCell ()
@property (nonatomic , weak ) UIImageView * imageView;
@property (nonatomic , strong ) RACDisposable *subscription;
@end

@implementation FRPCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self) return nil;
    
    //Configure self
    self.backgroundColor = [UIColor darkGrayColor];
    
    //Configure subviews
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.contentView addSubview:imageView];
    self.imageView = imageView;
    
    return self;
}

- (void)setPhotoModel:(FRPPhotoModel *)photoModel
{
    self.subscription = [[[RACObserve(photoModel, thumbnailData) filter:^BOOL(id  _Nullable value) {
        return value != nil;
    }] map:^id _Nullable(id  _Nullable value) {
        return [UIImage imageWithData:[NSData safeCase:value]];
    }] setKeyPath:@keypath(self.imageView, image) onObject:self.imageView];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    [self.subscription dispose];
    self.subscription = nil;
}
@end
