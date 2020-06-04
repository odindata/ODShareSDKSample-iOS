//
//  OdinAliSocialmomentsViewController.m
//  OdinShareDemo
//
//  Created by nathan on 2019/4/8.
//  Copyright © 2019 Odin. All rights reserved.
//

#import "ODAliSocialmomentsViewController.h"

@implementation ODAliSocialmomentsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    platformType = OdinSocialPlatformTypeAliSocialTimeline;
    self.title = @"支付宝朋友圈";
    shareIconArray = @[@"imageIcon",@"webURLIcon"];
    shareTypeArray = @[@"图片",@"链接"];
    selectorNameArray = @[@"shareImage",@"shareWebPage"];
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
