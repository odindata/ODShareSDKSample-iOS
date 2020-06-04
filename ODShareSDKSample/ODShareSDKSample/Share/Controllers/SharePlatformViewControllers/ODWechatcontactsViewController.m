//
//  OdinWechatcontactsViewController.m
//  OdinShareDemo
//
//  Created by nathan on 2019/3/27.
//  Copyright © 2019 Odin. All rights reserved.
//

#import "ODWechatcontactsViewController.h"

@interface ODWechatcontactsViewController ()

@end

@implementation ODWechatcontactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    platformType = OdinSocialPlatformSubTypeWechatSession;
    self.title = @"微信好友";
    shareIconArray = @[
        @"textIcon",
        @"imageIcon",
        @"imageIcon",
        @"webURLIcon",
        @"audioURLIcon",
        @"videoIcon",
        @"emoIcon",
        @"videoIcon",
        @"miniIcon"
    ];
    shareTypeArray = @[
        @"文字",
        @"图片",
        @"网络图片",
        @"链接",
        @"音乐链接",
        @"视频链接",
        @"表情",
        @"文件（本地视频）",
        @"小程序"
    ];
    selectorNameArray = @[
        @"shareText",
        @"shareImage",
        @"shareHttpImg",
        @"shareLink",
        @"shareAudio",
        @"shareVideo",
        @"shareEmoticon",
        @"shareFile",
        @"shareMiniProgram"
    ];
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
    OdinShareImageObject *imgObj=[[OdinShareImageObject alloc]init];
    
    imgObj.shareImage = shareImg;
    obj.shareObject=imgObj;
    [self shareWithObj:obj];
}

- (void)shareHttpImg{
    OdinSocialMessageObject *obj = [[OdinSocialMessageObject alloc]init];
    OdinShareImageObject *imgObj = [[OdinShareImageObject alloc]init];
    imgObj.shareImage = shareHttpImg;
    obj.shareObject = imgObj;
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

- (void)shareAudio
{
    OdinSocialMessageObject *obj=[[OdinSocialMessageObject alloc]init];
    OdinShareMusicObject *musicObj=[[OdinShareMusicObject alloc]init];
    musicObj.thumbImage = shareThumImg;
    musicObj.title = shareTitle;
    musicObj.descr = shareDescr;
    musicObj.musicUrl =shareAudioUrl;
    obj.shareObject=musicObj;
    [self shareWithObj:obj];
}

- (void)shareVideo
{
    OdinSocialMessageObject *obj = [[OdinSocialMessageObject alloc]init];
    OdinShareVideoObject *videoObj = [[OdinShareVideoObject alloc]init];
    videoObj.title = shareTitle;
    videoObj.descr = shareDescr;
    videoObj.videoUrl = shareVideoUrl;

    obj.shareObject=videoObj;
    [self shareWithObj:obj];
}

- (void)shareEmoticon
{
    OdinSocialMessageObject *obj = [[OdinSocialMessageObject alloc]init];
    OdinShareEmotionObject *emotionObj = [[OdinShareEmotionObject alloc]init];
    emotionObj.thumbImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"COD13" ofType:@"jpg"]];
    emotionObj.emotionData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"res6" ofType:@"gif"]]];

    obj.shareObject = emotionObj;
    [self shareWithObj:obj];
}

- (void)shareFile
{
    static NSString *kFileExtension = @"pdf";
    static NSString *kFileName = @"iphone4";
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:kFileName
                                                         ofType:kFileExtension];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];

    OdinSocialMessageObject *obj = [[OdinSocialMessageObject alloc]init];
    OdinShareFileObject *fileObj = [[OdinShareFileObject alloc]init];
    fileObj.thumbImage = shareThumImg;
    fileObj.title = shareTitle;
    fileObj.descr = shareDescr;
    fileObj.fileData = fileData;
    fileObj.fileExtension = kFileExtension;
    obj.shareObject = fileObj;
    [self shareWithObj:obj];
}

- (void)shareMiniProgram
{
    OdinSocialMessageObject *obj = [[OdinSocialMessageObject alloc]init];
    OdinShareMiniProgramObject *miniObj = [[OdinShareMiniProgramObject alloc]init];
    miniObj.thumbImage = shareThumImg;
    miniObj.userName = @"gh_afb25ac019c9";
    miniObj.miniProgramType = 0;
    miniObj.path = @"pages/index/index";
    miniObj.webpageUrl = shareWebUrl;
    miniObj.withShareTicket = YES;
    obj.shareObject = miniObj;
    [self shareWithObj:obj];
}
@end
