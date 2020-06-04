//
//  OdinFacebookViewController.m
//  OdinShareDemo
//
//  Created by nathan on 2019/4/16.
//  Copyright © 2019 Odin. All rights reserved.
//

#import "ODFacebookViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
@interface ODFacebookViewController ()<UIAlertViewDelegate>

@end

@implementation ODFacebookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    platformType = OdinSocialPlatformTypeFacebook;
    self.title = @"Facebook";
    shareIconArray = @[@"textAndImageIcon",@"mutImageIcon",@"webURLIcon",@"videoIcon"];
    shareTypeArray = @[@"单图",@"多图",@"链接 APP",@"相册视频"];
    selectorNameArray = @[@"shareImage",@"shareImages",@"shareLink",@"shareAssetVideo"];
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
