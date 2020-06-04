//
//  OdinDingTalkViewController.m
//  OdinShareDemo
//
//  Created by nathan on 2019/8/6.
//  Copyright © 2019 Odin. All rights reserved.
//

#import "ODDingTalkViewController.h"

@interface ODDingTalkViewController ()

@end

@implementation ODDingTalkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    platformType = OdinSocialPlatformTypeDingTalk;
    self.title = @"钉钉";
    shareIconArray = @[@"textIcon",@"imageIcon",@"webURLIcon"];
    shareTypeArray = @[@"文字",@"图片",@"链接"];
    selectorNameArray = @[@"shareText",@"shareImage",@"shareWebPage"];
}

/**
 分享文字
 */
-(void)shareText
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


/**
 分享网址
 */
- (void)shareWebPage
{
    OdinSocialMessageObject *obj = [[OdinSocialMessageObject alloc]init];
    OdinShareWebpageObject *webObj = [[OdinShareWebpageObject alloc]init];
    webObj.descr = shareDescr;
    webObj.webpageUrl = shareWebUrl;
    webObj.title = shareTitle;

    obj.shareObject = webObj;
    [self shareWithObj:obj];
}

@end
