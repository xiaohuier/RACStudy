//
//  FRPFullSizePhotoViewController.m
//  AppDemo
//
//  Created by eastzhou on 2018/10/10.
//  Copyright © 2018 周正东. All rights reserved.
//

#import "FRPFullSizePhotoViewController.h"
#import "FRPPhotoViewController.h"
#import "FRPPhotoModel.h"

@interface FRPFullSizePhotoViewController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate>
@property (nonatomic, strong) NSArray<FRPPhotoModel *> *photoModelArray;
@property (nonatomic, strong) UIPageViewController *pageViewController;
@end

@implementation FRPFullSizePhotoViewController

- (instancetype)initWithPhotoModels:(NSArray *)photoModelArray currentPhotoIndex:(NSInteger)photoIndex{
    self = [self init];
    if (!self) return nil;
    
    //Initialized, read-only properties
    self.photoModelArray = photoModelArray;
    
    //Configure self
    self.title = [self.photoModelArray[photoIndex] photoName];

    //ViewControllers
    self.pageViewController = [[UIPageViewController alloc]
                               initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                               navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                               options:@{ UIPageViewControllerOptionInterPageSpacingKey: @(30)}];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    [self addChildViewController:self.pageViewController];
    
    [self.pageViewController setViewControllers:@[[self photoViewControllerForIndex:photoIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.pageViewController.view.frame = self.view.bounds;
    
    [self.view addSubview:self.pageViewController.view];
}

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating: (BOOL)finished
   previousViewControllers:(NSArray *)previousViewControllers
       transitionCompleted:(BOOL)completed{
    self.title = [[self.pageViewController.viewControllers.firstObject photoModel] photoName];
    [self.delegate userDidScroll:self toPhotoAtIndex:[self.pageViewController.viewControllers.firstObject photoIndex]];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(FRPPhotoViewController *)viewController{
    return [self photoViewControllerForIndex:viewController.photoIndex - 1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(FRPPhotoViewController *)viewController {
    return [self photoViewControllerForIndex:viewController.photoIndex + 1];
}

- (FRPPhotoViewController *)photoViewControllerForIndex:(NSInteger)index{
    if (index >= 0 && index < self.photoModelArray.count){
        FRPPhotoModel *photoModel = self.photoModelArray[index];
        
        FRPPhotoViewController *photoViewController = [[FRPPhotoViewController alloc] initWithPhotoModel:photoModel index:index];
        
        return photoViewController;
    }
    
    //Index was out of bounds, return nil
    return nil;
}

@end
