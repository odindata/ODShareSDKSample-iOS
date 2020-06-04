//
//  OdinTwitterViewController.m
//  OdinShareDemo
//
//  Created by nathan on 2019/4/16.
//  Copyright © 2019 Odin. All rights reserved.
//

#import "ODTwitterViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ODTwitterViewController ()

@end

@implementation ODTwitterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    platformType = OdinSocialPlatformTypeTwitter;
    self.title = @"Twitter";
    shareIconArray = @[@"textIcon",@"textAndImageIcon",@"webURLIcon",@"videoIcon",@"videoIcon"];
    shareTypeArray = @[@"文字",@"文字+图片",@"链接",@"文字+视频"];
    selectorNameArray = @[@"shareText",@"shareImage",@"shareLink",@"shareVideo",@"shareVideoProgress"];
}


/**
 分享文字
 */
-(void)shareText
{
    OdinSocialMessageObject *obj=[[OdinSocialMessageObject alloc]init];
    obj.text = shareText;
    [self shareWithObj:obj];;
}

/**
 分享图片
 */
- (void)shareImage
{
    OdinSocialMessageObject *obj=[[OdinSocialMessageObject alloc]init];
    OdinShareImageObject *imgObj=[[OdinShareImageObject alloc]init];
    
    imgObj.shareImage = shareImg;
    obj.shareObject=imgObj;
    [self shareWithObj:obj];
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

- (void)shareVideo
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
