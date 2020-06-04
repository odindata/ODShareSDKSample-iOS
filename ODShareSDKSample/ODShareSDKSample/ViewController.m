//
//  ViewController.m
//  ODShareSDKSample
//
//  Created by nathan on 2020/5/12.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ViewController.h"
#import "ODShareViewController.h"
#import "ODAuthViewController.h"
#import "ODUserInfoViewController.h"
#import "ODTopView.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>{
    IBOutlet UICollectionView *myCollectionView;
    ODTopView *shareTopView;
    
    ODShareViewController *shareViewController;
    ODAuthViewController *authViewController;
    ODUserInfoViewController *userInfoViewController;
    NSArray *viewControllerArray;
    
    BOOL isFirst;
}

@end

static NSString * const cellReuseIdentifier = @"cellReuseIdentifier";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //topView
    __weak typeof(self) weakSelf = self;
    shareTopView = [[ODTopView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    shareTopView.topViewActionBlock = ^(UIButton * _Nonnull sender) {
        [weakSelf buttonAct:sender];
    };
    [self.navigationController.navigationBar addSubview:shareTopView];
    
    //content
    [myCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellReuseIdentifier];
    shareViewController = [[ODShareViewController alloc] initWithNibName:@"ODShareViewController" bundle:nil];
    authViewController = [[ODAuthViewController alloc] initWithNibName:@"ODAuthViewController" bundle:nil];
    userInfoViewController = [[ODUserInfoViewController alloc] initWithNibName:@"ODUserInfoViewController" bundle:nil];
    viewControllerArray = @[shareViewController,authViewController,userInfoViewController];
    isFirst = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(isFirst)
    {
        isFirst = NO;
        shareViewController.view.frame = myCollectionView.bounds;
        authViewController.view.frame = myCollectionView.bounds;
        userInfoViewController.view.frame = myCollectionView.bounds;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    shareTopView.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    shareTopView.hidden = YES;
}

#pragma mark - Event
- (void)buttonAct:(UIButton *)sender
{
    if(sender.tag - ODTopViewBaseTag == 1)
    {
        [authViewController reload];
    }
    else if(sender.tag - ODTopViewBaseTag == 2)
    {
        [userInfoViewController reload];
    }
    [UIView animateWithDuration:0.25 animations:^{
        [self->myCollectionView setContentOffset:CGPointMake(CGRectGetWidth(self->myCollectionView.bounds) * (sender.tag - ODTopViewBaseTag), 0) animated:YES];
    }];
}

#pragma mark UICollectionViewDelegate UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return collectionView.frame.size;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIdentifier forIndexPath:indexPath];
    UIViewController *viewController = viewControllerArray[indexPath.row];
    [cell addSubview:viewController.view];
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page=scrollView.contentOffset.x/CGRectGetWidth(scrollView.frame);
    [shareTopView relaod:page];
}

@end
