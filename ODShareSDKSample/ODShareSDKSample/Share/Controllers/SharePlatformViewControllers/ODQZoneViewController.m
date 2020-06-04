//
//  OdinQZoneViewController.m
//  OdinShareDemo
//
//  Created by nathan on 2019/4/1.
//  Copyright © 2019 Odin. All rights reserved.
//

#import "ODQZoneViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
@interface ODQZoneViewController ()

@end

@implementation ODQZoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    platformType = OdinSocialPlatformTypeQQ;
    self.title = @"QZone";
    shareIconArray = @[@"textIcon",@"imageIcon",@"webURLIcon",@"videoIcon"];
    shareTypeArray = @[@"文字",@"图片",@"链接",@"相册视频"];
    selectorNameArray = @[@"shareText",@"shareImage",@"shareLink",@"shareAssetVideo"];
}

/**
 分享文字
 */
-(void)shareText
{
    OdinSocialMessageObject *obj=[[OdinSocialMessageObject alloc]init];
    obj.text = shareText;
    [self shareWithObj:obj];
}

/**
 分享图片
 */
- (void)shareImage
{

    OdinSocialMessageObject *obj=[[OdinSocialMessageObject alloc]init];
    obj.text = shareText;
    OdinShareImageObject *imgObj=[[OdinShareImageObject alloc]init];

    imgObj.shareImage = shareImg;
    obj.shareObject = imgObj;
    [self shareWithObj:obj];
}

- (void)shareLink
{
   
    OdinSocialMessageObject *obj = [[OdinSocialMessageObject alloc]init];
    OdinShareWebpageObject *webObj = [[OdinShareWebpageObject alloc]init];
    webObj.thumbImage = shareThumImg;

    webObj.descr = shareDescr;
    webObj.webpageUrl = shareWebUrl;
    webObj.title = shareTitle;
    
    obj.shareObject=webObj;
    [self shareWithObj:obj];
}

- (void)shareAssetVideo
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
