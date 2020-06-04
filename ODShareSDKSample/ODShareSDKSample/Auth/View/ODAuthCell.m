//
//  ODAuthUserInfoCell.m
//  ODShareSDKSample
//
//  Created by nathan on 2020/5/14.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODAuthCell.h"

@interface ODAuthCell()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *authBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *authBtnWithConstraint;

@end

@implementation ODAuthCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.cornerRadius = 5;
    self.bgView.layer.borderWidth = .5f;
    self.bgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.authBtn.layer.cornerRadius = 5;
    self.authBtn.layer.borderWidth = .5f;
    self.authBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
}

- (void)setHasAuth:(BOOL)hasAuth{
    _hasAuth = hasAuth;
    if (hasAuth) {
        [self.authBtn setTitle:@"取消授权" forState:0];
        self.authBtnWithConstraint.constant = 75.5f;
    }else{
        [self.authBtn setTitle:@"授权" forState:0];
        self.authBtnWithConstraint.constant = 55.5f;
    }
}

- (IBAction)authAction:(UIButton *)sender {
    if (self.authActionBlock) {
        self.authActionBlock(self.hasAuth,self.platformType);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
