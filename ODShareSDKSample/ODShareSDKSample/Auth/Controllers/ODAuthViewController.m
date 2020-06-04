//
//  ODAuthViewController.m
//  ODShareSDKSample
//
//  Created by nathan on 2020/5/14.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODAuthViewController.h"
#import "ODAuthCell.h"
#import <OdinShareSDK/OdinShareSDK.h>

@interface ODAuthViewController ()
@property (weak, nonatomic) IBOutlet UITableView *authTableView;
@property (nonatomic,strong)NSArray *platforemArray;
@property (nonatomic,strong)NSArray *overseasPlatforemArray;
@property (nonatomic,strong)NSArray *systemPlatforemArray;
@property (nonatomic,strong)NSArray *titleArray;
@property (nonatomic,strong)NSBundle *uiBundle;
@property (nonatomic,strong)NSBundle *enBundle;
@end

@implementation ODAuthViewController

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
    
    [self.authTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ODAuthCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ODAuthCell class])];
    self.authTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)reload{
    [self.authTableView reloadData];
}

#pragma mark - 授权
- (void)authAction:(NSInteger )platformType{

    [[OdinSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
        [self reload];
    }];
}


- (void)cancelAuthAction:(NSInteger )platformType{
    //取消授权
    [[OdinSocialManager defaultManager] cancelAuthWithPlatform:platformType completion:^(id result, NSError *error) {
       [self reload];
    }];
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
    ODAuthCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ODAuthCell class])];
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
    
    //检查平台是否授权
    BOOL hasAuthed = [[OdinSocialManager defaultManager] isAuth:platformType];
    cell.hasAuth = hasAuthed;
    cell.platformType = platformType;
    cell.authActionBlock = ^(BOOL hasAuth,NSInteger platformType) {
        if (hasAuthed) {
            //取消授权
            [self cancelAuthAction:platformType];
        }else{
            //授权
            [self authAction:platformType];
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
