//
//  ODUserInfoCell.m
//  ODShareSDKSample
//
//  Created by nathan on 2020/5/14.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODUserInfoCell.h"

@interface ODUserInfoCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *userInfoBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userInfoBtnWithConstaint;

@end

@implementation ODUserInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.cornerRadius = 5;
    self.bgView.layer.borderWidth = .5f;
    self.bgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.userInfoBtn.layer.cornerRadius = 5;
    self.userInfoBtn.layer.borderWidth = .5f;
    self.userInfoBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

- (void)setHasAuth:(BOOL)hasAuth{
    _hasAuth = hasAuth;
    if (hasAuth) {
        [self.userInfoBtn setTitle:@"查看" forState:0];
        self.userInfoBtnWithConstaint.constant = 55.5f;
    }else{
        [self.userInfoBtn setTitle:@"用户信息" forState:0];
        self.userInfoBtnWithConstaint.constant = 75.5f;
    }
}

- (IBAction)userInfoAction:(UIButton *)sender {
    if (self.userInfoActionBlock) {
        self.userInfoActionBlock(self.hasAuth, self.platformType);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
