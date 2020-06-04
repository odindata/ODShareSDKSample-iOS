//
//  OdinInstagramViewController.m
//  OdinShareDemo
//
//  Created by nathan on 2019/4/16.
//  Copyright © 2019 Odin. All rights reserved.
//

#import "ODInstagramViewController.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface ODInstagramViewController ()

@end

@implementation ODInstagramViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    platformType = OdinSocialPlatformTypeInstagram;
    self.title = @"Instagram";
    shareIconArray = @[@"imageIcon",@"videoIcon"];
    shareTypeArray = @[@"图片",@"视频"];
    selectorNameArray = @[@"shareImage",@"shareVideo"];
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

- (void)shareVideo{
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
