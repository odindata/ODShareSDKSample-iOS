//
//  AppDelegate.m
//  ODShareSDKSample
//
//  Created by nathan on 2020/5/12.
//  Copyright © 2020 odin. All rights reserved.
//

#import "AppDelegate.h"
#import <OdinShareSDK/OdinShareSDK.h>

//QQ
#define ODSQQAppKey @"101701152"
//AppSecret
#define ODSQQAppSecret @"8136694454a74181d159ddb6be91fd1c"

//微信
#define ODSWXAppKey @"wx617c77c82218ea2c"
//AppSecret
#define ODSWXAppSecret @"c7253e5289986cf4c4c74d1ccc185fb1"

//支付宝
#define ODSAPAppKey @"2019070965791120"
//AppSecret
#define ODSAPAppSecret @""

//钉钉
#define ODSDDAppKey @"dingoazapw8gvddfylvos2"
//AppSecret
#define ODSDDAppSecret @"IaDEFbZFjxh2o1Y1jTq_oLjvmWquF3apDdsA4GM41M06FjQllR8bHND9JOObGwSZ"

//新浪微博
//AppKey
#define ODSSinaWeiboAppKey @"4021958662"
//AppSecret
#define ODSSinaWeiboAppSecret @"cea3598c1c0a89b3d55245c32956c683"
//RedirectUri
#define ODSSinaWeiboRedirectUri @"http://www.baidu.com"

//Twitter
//ConsumerKey
#define ODSSDKTwitterConsumerKey @"viOnkeLpHBKs6KXV7MPpeGyzE"
//ConsumerSecret
#define ODSSDKTwitterConsumerSecret @"NJEglQUy2rqZ9Io9FcAU9p17omFqbORknUpRrCDOK46aAbIiey"
//RedirectUri
#define ODSSDKTwitterRedirectUri @"http://www.odinanalysis.com/"

//Facebook
//钉钉
#define ODSFBAppKey @"2440246459557993"
//AppSecret
#define ODSFBAppSecret @"46caa091221f656f9fe79aeec4a04075"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[OdinSocialManager  defaultManager] setPlaform:OdinSocialPlatformSubTypeWechatSession appKey:ODSWXAppKey appSecret:ODSWXAppSecret  redirectURL:nil];
    
    
    [[OdinSocialManager  defaultManager] setPlaform:OdinSocialPlatformSubTypeQQFriend appKey:ODSQQAppKey appSecret:ODSQQAppSecret redirectURL:nil];
    
    [[OdinSocialManager  defaultManager] setPlaform:OdinSocialPlatformTypeSinaWeibo appKey:ODSSinaWeiboAppKey appSecret:ODSSinaWeiboAppSecret redirectURL:ODSSinaWeiboRedirectUri];
    
    [[OdinSocialManager  defaultManager] setPlaform:OdinSocialPlatformTypeAliSocial appKey:ODSAPAppKey appSecret:ODSAPAppSecret redirectURL:nil];
    
    [[OdinSocialManager defaultManager] setPlaform:OdinSocialPlatformTypeFacebook appKey:ODSFBAppKey  appSecret:ODSFBAppSecret redirectURL:nil];
    
    
    [[OdinSocialManager defaultManager] setPlaform:OdinSocialPlatformTypeTwitter appKey:ODSSDKTwitterConsumerKey  appSecret:ODSSDKTwitterConsumerSecret redirectURL:ODSSDKTwitterRedirectUri];
    
    
    [[OdinSocialManager defaultManager] setPlaform:OdinSocialPlatformTypeDingTalk appKey:ODSDDAppKey appSecret:ODSDDAppSecret redirectURL:nil];
    
    
    return YES;
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [[OdinSocialManager  defaultManager] handleOpenURL:url];
}


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    return [[OdinSocialManager  defaultManager] handleOpenURL:url options:options];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return  [[OdinSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
}



+ (UIViewController *)getRootViewController{
    return [UIApplication sharedApplication].keyWindow.rootViewController;
}
@end
