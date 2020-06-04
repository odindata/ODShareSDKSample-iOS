//
//  ODShowUserInfoViewController.m
//  ODShareSDKSample
//
//  Created by nathan on 2020/5/14.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODShowUserInfoViewController.h"
#import "MJExtension.h"
@interface ODShowUserInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextView *userInfoTextView;
@property (weak, nonatomic) IBOutlet UIButton *pasteBtn;

@end

@implementation ODShowUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pasteBtn.layer.cornerRadius = 5;
    self.pasteBtn.layer.borderWidth = .5f;
    self.pasteBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.userInfoTextView.editable = NO;
    self.userInfoTextView.text = [self.userResp mj_keyValues].description;
}

- (IBAction)copyAction:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.userInfoTextView.text;
}

@end
