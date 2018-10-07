//
//  FRPPhotoModel.h
//  AppDemo
//
//  Created by 周正东 on 2018/9/26.
//  Copyright © 2018年 周正东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FRPPhotoModel : NSObject
@property (nonatomic, strong) NSString *photoName;
@property (nonatomic, strong) NSNumber *identifier;
@property (nonatomic, strong) NSString *photographerName;
@property (nonatomic, strong) NSNumber *rating;
@property (nonatomic, strong) NSString *thumbnailURL;
@property (nonatomic, strong) NSData *thumbnailData;
@property (nonatomic, strong) NSString *fullsizedURL;
@property (nonatomic, strong) NSData * fullsizedData;
@end
