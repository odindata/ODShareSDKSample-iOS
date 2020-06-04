//
//  OdinAliSocialViewController.m
//  OdinShareDemo
//
//  Created by nathan on 2019/4/8.
//  Copyright © 2019 Odin. All rights reserved.
//

#import "ODAliSocialViewController.h"

@implementation ODAliSocialViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    platformType = OdinSocialPlatformTypeAliSocial;
    self.title = @"支付宝好友";
    shareIconArray = @[@"textIcon",@"imageIcon",@"webURLIcon"];
    shareTypeArray = @[@"文字",@"图片",@"链接"];
    selectorNameArray = @[@"shareText",@"shareImage",@"shareWebPage"];
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

- (void)shareWebPage
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

@end
