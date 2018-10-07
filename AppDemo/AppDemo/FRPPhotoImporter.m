//
//  FRPPhotoImporter.m
//  AppDemo
//
//  Created by 周正东 on 2018/9/26.
//  Copyright © 2018年 周正东. All rights reserved.
//

#import "FRPPhotoImporter.h"

@implementation FRPPhotoImporter
+ (RACSignal *)importPhotos
{
    RACReplaySubject *subject = [RACReplaySubject subject];
    NSURLRequest *request = [self popularURLRequest];
    NSURLSession *session = [[NSURLSession alloc] init];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            [subject sendError:error];
        }
        if (data) {
            [subject sendNext:data];
        }
        [subject sendCompleted];
    }];
    [task resume];
    return subject;
}

+ (NSURLRequest *)popularURLRequest {
    return [appDelegate.apiHelper urlRequestForPhotoFeature:PXAPIHelperPhotoFeaturePopular];
    
//    return [appDelegate.apiHelper urlRequestForPhotoFeature:PXAPIHelperPhotoFeaturePopular
//                                             resultsPerPage:100 page:0
//                                                  photoSize:PXPhotoModelSizeThumbnail
//                                                  sortOrder:PXAPIHelperSortOrderRating
//                                                     except:PXPhotoModelCategoryNude];
}
@end
