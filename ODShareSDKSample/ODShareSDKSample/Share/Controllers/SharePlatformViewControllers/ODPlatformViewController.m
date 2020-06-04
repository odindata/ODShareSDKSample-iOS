//
//  OdinPlatformViewController.m
//  OdinShareDemo
//
//  Created by nathan on 2019/3/27.
//  Copyright © 2019 Odin. All rights reserved.
//

#import "ODPlatformViewController.h"
#import "ODShareTypeCell.h"
#import "AppDelegate.h"

#define isTest NO

@interface ODPlatformViewController (){
    NSIndexPath *selectIndexPath;
    BOOL _isShare;
}

@property(nonatomic,strong) UIWindow *carriarWindow;
@end

@implementation ODPlatformViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [shareTypeTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ODShareTypeCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ODShareTypeCell class])];
    shareTypeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (instancetype)init
{
    self = [self initWithNibName:@"ODPlatformViewController" bundle:nil];
    if (self) {
        shareTypeArray = @[];
        shareIconArray = @[];
        selectorNameArray = @[];
        
        shareTitle = @"分享标题";
        shareDescr = @"分享描述";
        shareText = @"分享内容";
        shareImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"dog" ofType:@"jpeg"]];
        shareThumImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"COD13" ofType:@"jpg"]];
        shareWebUrl = @"http://www.odinanalysis.com/";
        shareAudioUrl = @"http://i.y.qq.com/v8/playsong.html?hostuin=0&songid=&songmid=002x5Jje3eUkXT&_wv=1&source=qq&appshare=iphone&media_mid=002x5Jje3eUkXT";
        shareVideoUrl = @"http://v.youku.com/v_show/id_XNTUxNDY1NDY4.html";
        shareHttpImg = @"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1906469856,4113625838&fm=26&gp=0.jpg";
    }
    return self;
}

- (void)alertWithError:(NSError *)error
{
    NSString *result = nil;
    if (!error) {
        result = [NSString stringWithFormat:@"Share complete"];
    }
    else{
        NSMutableString *str = [NSMutableString string];
        if (error.userInfo) {
            for (NSString *key in error.userInfo) {
                [str appendFormat:@"%@ = %@\n", key, error.userInfo[key]];
            }
        }
        if (error) {
            result = [NSString stringWithFormat:@"Share fail with error code: %d\n%@",(int)error.code, str];
        }
        else{
            result = [NSString stringWithFormat:@"Share fail"];
        }
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"share"
                                                    message:result
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"sure", @"确定")
                                          otherButtonTitles:nil];
    [alert show];
}


- (void)shareWithObj:(OdinSocialMessageObject *)obj{
    [[OdinSocialManager defaultManager] shareToPlatform:platformType messageObject:obj currentViewController:self completion:^(id result, NSError *error) {
        [self alertWithError:error];
    }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return shareTypeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ODShareTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ODShareTypeCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.shareTypeLbl.text = shareTypeArray[indexPath.row];
    NSString *imageName = shareIconArray[indexPath.row];
    cell.shareTypeIconImgView.image= [UIImage imageNamed:imageName];
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row < selectorNameArray.count)
    {
        selectIndexPath = indexPath;
        NSString *selectorName = selectorNameArray[indexPath.row];
        [self funcWithSelectorName:selectorName];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 1000 && buttonIndex == 1)
    {
       /* [ShareSDK cancelAuthorize:platformType result:nil];*/
        if(isTest)
        {
            [shareTypeTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        }
    }
}


- (void)funcWithSelectorName:(NSString *)selectorName
{
    SEL sel = NSSelectorFromString(selectorName);
    if([self respondsToSelector:sel])
    {
        IMP imp = [self methodForSelector:sel];
        void (*func)(id, SEL) = (void *)imp;
        func(self, sel);
    }
}


@end
