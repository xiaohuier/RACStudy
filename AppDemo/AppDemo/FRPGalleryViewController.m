//
//  FRPGalleryViewController.m
//  AppDemo
//
//  Created by 周正东 on 2018/9/25.
//  Copyright © 2018年 周正东. All rights reserved.
//

#import "FRPGalleryViewController.h"
#import "FRPCell.h"
#import "FRPPhotoImporter.h"

@interface FRPGalleryFlowLayout : UICollectionViewFlowLayout
@end
@implementation FRPGalleryFlowLayout
- (instancetype)init
{
    if (!(self = [super init])) return nil;
    self.itemSize = CGSizeMake(145,145);
    self.minimumInteritemSpacing = 10;
    self.minimumLineSpacing = 10;
    self.sectionInset = UIEdgeInsetsMake(10,10,10,10);
    return self;
}
@end

@interface FRPGalleryViewController ()
@property (nonatomic , strong) NSArray *photoArray;
@end

@implementation FRPGalleryViewController

static NSString * const reuseIdentifier = @"Cell";


- (instancetype)init
{
    FRPGalleryFlowLayout *flowLayout = [[FRPGalleryFlowLayout alloc] init];
    self = [super initWithCollectionViewLayout:flowLayout];
    if(!self) return nil;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Popular on 500px";
    
    //Configure View
    [self.collectionView registerClass:[FRPCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //Reactive Stuff
    @weakify(self);
    [[[RACObserve(self, photoArray) deliverOnMainThread] filter:^BOOL(id  _Nullable value) {
        return value != nil;
    }] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.collectionView reloadData];
    }];
    
    [self loadPopularPhotos];
}

- (void)loadPopularPhotos
{
    [[FRPPhotoImporter importPhotos] subscribeNext:^(id x){
        self.photoArray = [NSArray safeCase:x];
    } error:^(NSError * error){
        NSLog(@"Couldn't fetch photofrom 500px: %@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photoArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FRPCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell setPhotoModel:self.photoArray[indexPath.row]];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
