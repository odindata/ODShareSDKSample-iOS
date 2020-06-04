//
//  ODSharePlatformCell.m
//  ODShareSDKSample
//
//  Created by nathan on 2020/5/13.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODSharePlatformCell.h"

@interface ODSharePlatformCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation ODSharePlatformCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.bgView.layer.cornerRadius = 5;
    self.bgView.layer.borderWidth = .5f;
    self.bgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
