//
//  FRPPhotoImporter.m
//  AppDemo
//
//  Created by 周正东 on 2018/9/26.
//  Copyright © 2018年 周正东. All rights reserved.
//

#import "FRPPhotoImporter.h"
#import "FRPPhotoModel.h"

@implementation FRPPhotoImporter
+ (RACSignal *)importPhotos
{
    RACReplaySubject *subject = [RACReplaySubject subject];
    NSURLRequest *request = [self popularURLRequest];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data && !error) {
            id results = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            results = @{@"photos" : @[@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{}]};
            NSArray *array = [[[results[@"photos"] rac_sequence] map:^id _Nullable(id  _Nullable value) {
                NSDictionary *dic = [NSDictionary safeCase:value];
                FRPPhotoModel *model = [[FRPPhotoModel alloc] init];
                [self configurePhotoModel:model withDictionary:dic];
                [self downloadThumbnailForPhotoModel:model];
                return model;
            }] array];
            
            [subject sendNext:array];
        }
        if (error) {
            [subject sendError:error];
        }
        [subject sendCompleted];
    }];
    [task resume];
    return subject;
}

+ (NSURLRequest *)popularURLRequest
{
    return [appDelegate.apiHelper urlRequestForPhotoFeature:PXAPIHelperPhotoFeaturePopular];
    
//    return [appDelegate.apiHelper urlRequestForPhotoFeature:PXAPIHelperPhotoFeaturePopular
//                                             resultsPerPage:100 page:0
//                                                  photoSize:PXPhotoModelSizeThumbnail
//                                                  sortOrder:PXAPIHelperSortOrderRating
//                                                     except:PXPhotoModelCategoryNude];
}

+ (void)configurePhotoModel:(FRPPhotoModel *)photomodel withDictionary:(NSDictionary *)dictionary
{
    //Basic details fetched with the first, basic request
    photomodel.photoName = dictionary[@"name"];
    photomodel.identifier = dictionary[@"id"];
    photomodel.photographerName = dictionary[@"user"][@"username"];
    photomodel.rating = dictionary[@"rating"];
    
    photomodel.thumbnailURL = [self urlForImageSize:3 inArray:dictionary[@"images"]];
    photomodel.thumbnailURL = @"http://git.pptv.com/mobile/documents/wikis/images/suning_env_jenkins.png";
    //Extended attributes fetched with subsequent request
    if (dictionary[@"comments_count"]){
        photomodel.fullsizedURL = [self urlForImageSize:4 inArray:dictionary[@"images"]];
    }
}

+ (NSString *)urlForImageSize:(NSInteger)size inArray:(NSArray *)array
{
    return [[[[[array rac_sequence] filter:^ BOOL (NSDictionary * value){
        return [value[@"size"] integerValue] == size;
    }] map:^id (id value){
        return value[@"url"];
    }] array] firstObject];
}

//+ (void)downloadThumbnailForPhotoModel:(FRPPhotoModel *)photoModel
//{
//    NSAssert(photoModel.thumbnailURL, @"Thumbnail URL must not be nil");
//
//    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:photoModel.thumbnailURL]];
//    [NSURLConnection sendAsynchronousRequest:request
//                                       queue:[NSOperationQueue mainQueue]
//                           completionHandler:^(NSURLResponse *response, NSData *data, NSError * connectionError){
//                               photoModel.thumbnailData = data;
//                           }];
//}

+ (RACReplaySubject *)fetchPhotoDetails:(FRPPhotoModel *)photoModel
{
    RACReplaySubject * subject = [RACReplaySubject subject];
    NSURLRequest *request = [self photoURLRequest:photoModel];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^ (NSURLResponse *response, NSData * data, NSError *connectionError){
                               if(data){
                                   id results = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil][ @"photo" ];
                                   
                                   [self configurePhotoModel:photoModel withDictionary:results];
                                   [self downloadFullsizedImageForPhotoModel:photoModel];
                                   
                                   [subject sendNext:photoModel];
                                   [subject sendCompleted];
                               }
                               else{
                                   [subject sendError:connectionError];
                               }
                           }];
    
    return subject;
}

+ (void)downloadThumbnailForPhotoModel:(FRPPhotoModel *)photoModel {
    [self download:photoModel.thumbnailURL withCompletion:^(NSData *data){
        photoModel.thumbnailData = data;
    }];
}

+ (void)downloadFullsizedImageForPhotoModel:(FRPPhotoModel *)photoModel {
    [self download:photoModel.fullsizedURL withCompletion:^(NSData * data){
        photoModel.fullsizedData = data;
    }];
}


+ (void)download:(NSString *)urlString withCompletion:(void(^)(NSData * data))completion
{
    NSAssert(urlString, @"URL must not be nil" );
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        if (completion){
            completion(data);
        }
    }];
}

+ (NSURLRequest *)photoURLRequest:(FRPPhotoModel *)photoModel
{
    return [appDelegate.apiHelper urlRequestForPhotoID:photoModel.identifier.integerValue];
}
@end
