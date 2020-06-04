//
//  ODUserInfoViewController.m
//  ODShareSDKSample
//
//  Created by nathan on 2020/5/14.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODUserInfoViewController.h"
#import "AppDelegate.h"
#import "ODUserInfoCell.h"
#import "ODShowUserInfoViewController.h"
#import <OdinShareSDK/OdinShareSDK.h>

@interface ODUserInfoViewController ()
@property (weak, nonatomic) IBOutlet UITableView *userInfoTableView;

@property (nonatomic,strong)NSArray *platforemArray;
@property (nonatomic,strong)NSArray *overseasPlatforemArray;
@property (nonatomic,strong)NSArray *systemPlatforemArray;
@property (nonatomic,strong)NSArray *titleArray;
@property (nonatomic,strong)NSBundle *uiBundle;
@property (nonatomic,strong)NSBundle *enBundle;

@end

@implementation ODUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    _platforemArray = @[
        @(OdinSocialPlatformSubTypeQQFriend),
//        @(OdinSocialPlatformSubTypeWechatSession),
//        @(OdinSocialPlatformTypeSinaWeibo),
    ];
    _overseasPlatforemArray = @[
        @(OdinSocialPlatformTypeFacebook),
        @(OdinSocialPlatformTypeTwitter)
    ];
    _titleArray = @[@"  国内平台",@"  海外平台"];
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"ShareSDKUI" ofType:@"bundle"];
    _uiBundle = [NSBundle bundleWithPath:bundlePath];
    
    NSString *path = [_uiBundle pathForResource:@"en" ofType:@"lproj"];
    _enBundle = [NSBundle bundleWithPath:path];
    
    [self.userInfoTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ODUserInfoCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ODUserInfoCell class])];
    self.userInfoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)reload{
    [self.userInfoTableView reloadData];
}

#pragma mark - 获取用户信息
- (void)getUserInfo:(NSInteger )platformType{
    [[OdinSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
        if (error == nil) {
            [self.userInfoTableView reloadData];
            [self showUserInfo: result];
        }
    }];
}


/// 显示用户信息
/// @param userResp 用户信息
- (void)showUserInfo:(id)userResp{
    ODShowUserInfoViewController *userInfoVc = [[ODShowUserInfoViewController alloc]init];
    UINavigationController *rootVc = (UINavigationController *)[AppDelegate getRootViewController];
    [rootVc pushViewController:userInfoVc animated:YES];
    [userInfoVc setUserResp:userResp];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return _platforemArray.count;
        case 1:
            return _overseasPlatforemArray.count;
        case 2:
            return _systemPlatforemArray.count;
        default:
            return  0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ODUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ODUserInfoCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    id obj = nil;
    switch (indexPath.section) {
        case 0:
            obj = _platforemArray[indexPath.row];
            break;
        case 1:
            obj = _overseasPlatforemArray[indexPath.row];
            break;
        case 2:
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
    
    BOOL hasAuthed = [[OdinSocialManager defaultManager] isAuth:platformType];
    cell.hasAuth = hasAuthed;
    cell.platformType = platformType;
    cell.userInfoActionBlock = ^(BOOL hasAuth,NSInteger platformType) {
        if (hasAuthed) {
            //查看用户信息
            [self showUserInfo: [[OdinSocialManager defaultManager] getUserInfo:platformType]];
        }else{
            //获取用户信息
            [self getUserInfo:platformType];
        }
        
    };
    return cell;
}


- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
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
    
    header.textLabel.textColor = [UIColor lightGrayColor];
    
    header.contentView.backgroundColor = [UIColor whiteColor];
    
}


#pragma mark - Table view delegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 76;
}
@end
