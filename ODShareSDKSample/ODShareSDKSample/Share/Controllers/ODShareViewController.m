//
//  OdinShareViewController.m
//  ODShareSDKSample
//
//  Created by nathan on 2020/5/12.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODShareViewController.h"
#import "ODSharePlatformCell.h"
#import "AppDelegate.h"
#import "UIColor+ODExtension.h"

#import <OdinShareSDK/OdinShareSDK.h>
#import <OdinShareSDKUI/OdinShareSDKUI.h>

@interface ODShareViewController ()

@property (weak, nonatomic) IBOutlet UIView *shareMenuView;
@property (weak, nonatomic) IBOutlet UIView *snipView;

@property (strong, nonatomic) IBOutlet UITableViewCell *topCell;
@property (weak, nonatomic) IBOutlet UITableView *shareTableView;
@property (nonatomic,strong) UIImageView *showSnipView;

@property (nonatomic,strong)NSArray *platforemArray;
@property (nonatomic,strong)NSArray *overseasPlatforemArray;
@property (nonatomic,strong)NSArray *systemPlatforemArray;
@property (nonatomic,strong)NSArray *titleArray;
@property (nonatomic,strong)NSBundle *uiBundle;
@property (nonatomic,strong)NSBundle *enBundle;
@end


static const NSInteger otherInfo = 1;

@implementation ODShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.shareMenuView.layer.cornerRadius = 5;
    self.shareMenuView.layer.masksToBounds = YES;
    self.snipView.layer.borderColor = [UIColor colorWithHexString:@"#06c489"].CGColor;
    self.snipView.layer.borderWidth = 1;
    self.snipView.layer.cornerRadius = 5;
    self.snipView.layer.masksToBounds = YES;
    
    self.showSnipView = [[UIImageView alloc] init];
    self.showSnipView.frame = CGRectMake(CGRectGetWidth(self.view.frame) - 100 -30,100, 100, 200);
    [self.view addSubview:self.showSnipView];
    self.showSnipView.userInteractionEnabled = YES;
    self.showSnipView.hidden = YES;
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shareSnip:)];
    [self.showSnipView addGestureRecognizer:tap];
    
    _platforemArray = @[
        @(OdinSocialPlatformSubTypeQQFriend),
        @(OdinSocialPlatformSubTypeQZone),
        @(OdinSocialPlatformSubTypeWechatSession),
        @(OdinSocialPlatformSubTypeWechatTimeline),
        @(OdinSocialPlatformSubTypeWechatFav),
        @(OdinSocialPlatformTypeSinaWeibo),
        @(OdinSocialPlatformTypeAliSocial),
        @(OdinSocialPlatformTypeAliSocialTimeline),
        @(OdinSocialPlatformTypeDingTalk),
    ];
    _overseasPlatforemArray = @[
        @(OdinSocialPlatformTypeFacebook),
        @(OdinSocialPlatformTypeTwitter),
        @(OdinSocialPlatformTypeInstagram),
    ];
    _systemPlatforemArray = @[
        
    ];
      _titleArray = @[@"  分享演示",@"  国内平台",@"  海外平台"];
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"ShareSDKUI" ofType:@"bundle"];
    _uiBundle = [NSBundle bundleWithPath:bundlePath];
    
    NSString *path = [_uiBundle pathForResource:@"en" ofType:@"lproj"];
    _enBundle = [NSBundle bundleWithPath:path];
    
    
    [self.shareTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ODSharePlatformCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ODSharePlatformCell class])];
    self.shareTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - Private Method
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

- (UIImage *)snapshot
{
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, [[UIScreen mainScreen] scale]);;
    
    if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [self.view drawViewHierarchyInRect:self.view.bounds afterScreenUpdates:NO];
    } else {
        CGContextRef context = UIGraphicsGetCurrentContext();
        [self.view.layer renderInContext:context];
    }
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return viewImage;
}
 
#pragma mark - Event
- (void)shareSnip:(UITapGestureRecognizer *)sender{
    NSArray *platforms =@[
        @(OdinSocialPlatformSubTypeQQFriend),
        @(OdinSocialPlatformSubTypeQZone),
        @(OdinSocialPlatformSubTypeWechatSession),
        @(OdinSocialPlatformSubTypeWechatTimeline),
        @(OdinSocialPlatformSubTypeWechatFav),
        @(OdinSocialPlatformTypeSinaWeibo),
        @(OdinSocialPlatformTypeAliSocial),
        @(OdinSocialPlatformTypeAliSocialTimeline),
        @(OdinSocialPlatformTypeFacebook),
        @(OdinSocialPlatformTypeTwitter),
        @(OdinSocialPlatformTypeInstagram)
    ];

    OdinSocialMessageObject *obj = [[OdinSocialMessageObject alloc]init];
    OdinShareImageObject *imgObj = [[OdinShareImageObject alloc]init];

    imgObj.shareImage = self.showSnipView.image;
    obj.shareObject = imgObj;
    OdinUIShareSheetConfiguration *config=[OdinUIShareSheetConfiguration new];
    [[OdinSocialUIManager shareInstance] showShareActionSheet:platforms shareObject:obj sheetConfiguration:config currentViewController:self CompletionHandler:^(id shareResponse, NSError *error) {
        [self alertWithError:error];
    }];
}

/// 分享菜单
/// @param sender sender
- (IBAction)shareMenuAction:(id)sender {
    NSArray *platforms =@[
        @(OdinSocialPlatformSubTypeQQFriend),
        @(OdinSocialPlatformSubTypeQZone),
        @(OdinSocialPlatformSubTypeWechatSession),
        @(OdinSocialPlatformSubTypeWechatTimeline),
        @(OdinSocialPlatformSubTypeWechatFav),
        @(OdinSocialPlatformTypeSinaWeibo),
        @(OdinSocialPlatformTypeAliSocial),
        @(OdinSocialPlatformTypeAliSocialTimeline),
        @(OdinSocialPlatformTypeFacebook),
        @(OdinSocialPlatformTypeTwitter),
        @(OdinSocialPlatformTypeInstagram)
    ];

    OdinSocialMessageObject *obj = [[OdinSocialMessageObject alloc]init];
    OdinShareWebpageObject *webObj = [[OdinShareWebpageObject alloc]init];

    webObj.descr = @"分享描述";
    webObj.webpageUrl = @"http://www.odinanalysis.com/";
    webObj.title = @"分享标题";
    
    obj.shareObject = webObj;
    OdinUIShareSheetConfiguration *config=[OdinUIShareSheetConfiguration new];
    config.cancelButtonHidden = YES;
    config.style = OdinUIActionSheetStyleSimple;
    config.columnLandscapeCount = 1;
    [[OdinSocialUIManager shareInstance] showShareActionSheet:platforms shareObject:obj sheetConfiguration:config currentViewController:self CompletionHandler:^(id shareResponse, NSError *error) {
        [self alertWithError:error];
    }];
}

/// 截图分享
/// @param sender sender
- (IBAction)snipAction:(id)sender {
    UIImage *snipImage = [self snapshot];
    self.showSnipView.image = snipImage;
    self.showSnipView.hidden = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1 animations:^{
             self.showSnipView.hidden = YES;
        }];
    });
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
        case 1:
            return _platforemArray.count;
        case 2:
            return _overseasPlatforemArray.count;
        case 3:
            return _systemPlatforemArray.count;
        case 4:
            return otherInfo;
        default:
            return  0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        return _topCell;
    }
    ODSharePlatformCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ODSharePlatformCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    id obj = nil;
    switch (indexPath.section) {
        case 1:
            obj = _platforemArray[indexPath.row];
            break;
        case 2:
            obj = _overseasPlatforemArray[indexPath.row];
            break;
        case 3:
            obj = _systemPlatforemArray[indexPath.row];
            break;
    }
    
    //title
    NSInteger platformType = [obj integerValue];
    NSString *platformTypeName = [NSString stringWithFormat:@"ShareType_%zi",platformType];
    cell.paltFormTitle.text = NSLocalizedStringWithDefaultValue(platformTypeName, @"ShareSDKUI_Localizable", _uiBundle, platformTypeName, nil);
    
    //icon
    NSString *iconImageName = [NSString stringWithFormat:@"Icon_simple/sns_icon_%ld.png",(long)platformType];
    UIImage *icon = [UIImage imageWithContentsOfFile:[_uiBundle pathForResource:(iconImageName) ofType:nil]];
    cell.platFormIcon.image = icon;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 0;
    }
    return 60;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section < _titleArray.count)
    {
        return _titleArray[section];
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section

{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.textColor = [UIColor colorWithRed:156 withGreen:156 withBlue:156];
    header.contentView.backgroundColor = [UIColor whiteColor];
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        return 100;
    }
    return 76;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section == 0)
    {
        return;
    }
    id obj = nil;
    switch (indexPath.section) {
        case 1:
            obj = _platforemArray[indexPath.row];
            break;
        case 2:
            obj = _overseasPlatforemArray[indexPath.row];
            break;
        case 3:
            obj = _systemPlatforemArray[indexPath.row];
            break;
    }
    NSInteger platformType = [obj integerValue];
    NSString *platformTypeName = [NSString stringWithFormat:@"ShareType_%zi",platformType];
    NSString *platformName = NSLocalizedStringWithDefaultValue(platformTypeName, @"ShareSDKUI_Localizable", _enBundle, platformTypeName, nil);
    platformName = [platformName stringByReplacingOccurrencesOfString:@" " withString:@""];
    platformName = [platformName stringByReplacingOccurrencesOfString:@"+" withString:@""];
    NSString *viewControllerName = [NSString stringWithFormat:@"OD%@ViewController",platformName];
    NSLog(@"move to %@",viewControllerName);
    Class viewControllerClass = NSClassFromString(viewControllerName);
    if (viewControllerClass)
    {
        UIViewController *viewController = [[viewControllerClass alloc] init];
        UINavigationController *rootVc = (UINavigationController *)[AppDelegate getRootViewController];
        [rootVc pushViewController:viewController animated:YES];
    }
}
@end
