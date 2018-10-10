//
//  FRPPhotoImporter.h
//  AppDemo
//
//  Created by 周正东 on 2018/9/26.
//  Copyright © 2018年 周正东. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FRPPhotoModel;
@interface FRPPhotoImporter : NSObject
+ (RACSignal *)importPhotos;
+ (RACReplaySubject *)fetchPhotoDetails:(FRPPhotoModel *)photoModel;
@end
