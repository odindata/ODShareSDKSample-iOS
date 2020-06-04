//
//  OdinSinaWeiboViewController.m
//  OdinShareDemo
//
//  Created by nathan on 2019/4/2.
//  Copyright © 2019 Odin. All rights reserved.
//

#import "ODSinaWeiboViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
@interface ODSinaWeiboViewController ()

@end

@implementation ODSinaWeiboViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    platformType = OdinSocialPlatformTypeSinaWeibo;
    self.title = @"新浪微博";
    shareIconArray = @[@"textIcon",@"textAndImageIcon",@"webURLIcon",@"videoIcon"];
    shareTypeArray = @[@"文字 SDK",@"文字+图片 SDK",@"链接 SDK",@"视频 SDK"];
    selectorNameArray = @[@"shareText",@"shareImages",@"shareLink",@"shareVideos"];
}


- (void)shareText
{
    OdinSocialMessageObject *obj = [[OdinSocialMessageObject alloc]init];
    obj.text = shareText;
    [self shareWithObj:obj];
}

- (void)shareImages
{

    OdinSocialMessageObject *obj = [[OdinSocialMessageObject alloc]init];
    obj.text = shareText;
    OdinShareImageObject *imgObj=[[OdinShareImageObject alloc]init];
    imgObj.shareImageArray = @[shareImg,shareImg];
    obj.shareObject=imgObj;
    [[OdinSocialManager defaultManager] shareToPlatform:platformType messageObject:obj currentViewController:self completion:^(id result, NSError *error) {
        [self alertWithError:error];
    }];
}

- (void)shareLink
{
    OdinSocialMessageObject *obj=[[OdinSocialMessageObject alloc]init];
    OdinShareWebpageObject *webObj=[[OdinShareWebpageObject alloc]init];
    webObj.descr = shareDescr;
    webObj.webpageUrl = shareWebUrl;
    webObj.title = shareTitle;
    
    obj.shareObject=webObj;
    [self shareWithObj:obj];
}


- (void)shareVideos
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cat" ofType:@"mp4"];
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"COD13" ofType:@"jpg"];
    NSURL *url = [NSURL URLWithString:path];
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    __weak __typeof__ (self) weakSelf = self;
    [assetsLibrary writeVideoAtPathToSavedPhotosAlbum:url completionBlock:^(NSURL *assetURL, NSError *error) {
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        OdinSocialMessageObject *obj=[[OdinSocialMessageObject alloc]init];
        OdinShareVideoObject *videoObj=[[OdinShareVideoObject alloc]init];
        
        videoObj.title = shareTitle;
        videoObj.descr = shareDescr;
        videoObj.videoUrl = [assetURL absoluteString];;
        
        obj.shareObject=videoObj;
        [self shareWithObj:obj];
        
    }];
}
@end
