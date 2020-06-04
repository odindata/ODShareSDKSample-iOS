//
//  OdinQQViewController.m
//  OdinShareDemo
//
//  Created by nathan on 2019/4/1.
//  Copyright © 2019 Odin. All rights reserved.
//

#import "ODQQViewController.h"

@interface ODQQViewController ()<UIAlertViewDelegate>

@end

@implementation ODQQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    platformType = OdinSocialPlatformSubTypeQQFriend;
    self.title = @"QQ好友";
    shareIconArray = @[@"textIcon",@"imageIcon",@"webURLIcon",@"audioURLIcon",@"videoIcon"];
    shareTypeArray = @[@"文字",@"图片",@"链接",@"音乐链接",@"视频链接"];
    selectorNameArray = @[@"shareText",@"shareImage",@"shareLink",@"shareAudio",@"shareVideo"];
}

/**
 分享文字
 */
- (void)shareText
{
    OdinSocialMessageObject *obj = [[OdinSocialMessageObject alloc]init];
    obj.text = shareText;
    [self shareWithObj:obj];
}

/**
 分享图片
 */
- (void)shareImage
{
    OdinSocialMessageObject *obj = [[OdinSocialMessageObject alloc]init];
    OdinShareImageObject *imgObj = [[OdinShareImageObject alloc]init];
    
    imgObj.shareImage = shareImg;
    obj.shareObject = imgObj;
    [self shareWithObj:obj];
}

- (void)shareLink
{
    OdinSocialMessageObject *obj = [[OdinSocialMessageObject alloc]init];
    OdinShareWebpageObject *webObj = [[OdinShareWebpageObject alloc]init];
    webObj.descr = shareDescr;
    webObj.webpageUrl = shareWebUrl;
    webObj.title = shareTitle;

    obj.shareObject = webObj;
    [self shareWithObj:obj];
}

- (void)shareAudio
{
    OdinSocialMessageObject *obj = [[OdinSocialMessageObject alloc]init];
    OdinShareMusicObject *musicObj = [[OdinShareMusicObject alloc]init];
    musicObj.thumbImage = shareThumImg;
    musicObj.title = shareTitle;
    musicObj.descr = shareDescr;
    musicObj.musicUrl =shareAudioUrl;
    obj.shareObject = musicObj;
    [self shareWithObj:obj];
}

- (void)shareVideo
{
    
    OdinSocialMessageObject *obj = [[OdinSocialMessageObject alloc]init];
    OdinShareVideoObject *videoObj = [[OdinShareVideoObject alloc]init];
    videoObj.title = shareTitle;
    videoObj.descr = shareDescr;
    videoObj.videoUrl = shareVideoUrl;

    obj.shareObject = videoObj;
    [self shareWithObj:obj];
}

@end
