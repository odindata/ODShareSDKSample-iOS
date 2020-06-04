//
//  ODTopView.m
//  ODShareSDKSample
//
//  Created by nathan on 2020/5/18.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODTopView.h"
#import "UIColor+ODExtension.h"

@interface ODTopView ()
@property(nonatomic,strong) CALayer *lineLayer;
@property(nonatomic,assign) NSInteger selectedIndex;
@end

@implementation ODTopView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView{
    CGFloat totalW = 0;
    NSArray *titles = @[@"分享",@"授权",@"用户信息"];
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = i + 10086;
        [btn setTitle:titles[i] forState:0];
        [btn setTitleColor:[UIColor colorWithRed:49 withGreen:51 withBlue:62] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor colorWithRed:156 withGreen:156 withBlue:156] forState:0];
        btn.selected = (i == 0);
        [btn  addTarget:self action:@selector(topAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn sizeToFit];
        totalW += btn.frame.size.width;
        [self addSubview:btn];
        
    }
    CGFloat padding = ([UIScreen mainScreen].bounds.size.width - totalW)/4.0;
    CGFloat lastBtnMaxX = 0;
    for (NSInteger i = 0; i < 3; i++) {
        UIButton *btn = [self viewWithTag:i + ODTopViewBaseTag];
        CGFloat btnX  = padding + lastBtnMaxX;
        btn.frame = CGRectMake(btnX, 0, btn.frame.size.width, self.frame.size.height);
        lastBtnMaxX = CGRectGetMaxX(btn.frame);
    }
    [self showLineWithButton:[self viewWithTag:ODTopViewBaseTag]];
}

- (void)relaod:(NSInteger)page{
    [self showLineWithButton:[self viewWithTag:ODTopViewBaseTag + page]];
}

- (void)topAction:(UIButton *)sender{
    [self showLineWithButton:sender];
    if (self.topViewActionBlock) {
        self.topViewActionBlock(sender);
    }
}

- (void)showLineWithButton:(UIButton *)button
{
    self.selectedIndex = button.tag;
    for (NSInteger i = 0; i < 3; i++) {
        UIButton *btn = [self viewWithTag:i + ODTopViewBaseTag];
        btn.selected = ((button.tag - ODTopViewBaseTag) == i);
    }
    if(self.lineLayer == nil)
    {
        self.lineLayer = [[CALayer alloc] init];
        self.lineLayer.backgroundColor =  [UIColor colorWithHexString:@"#06c489"].CGColor;
        [self.layer addSublayer:self.lineLayer];
    }
    CGFloat width = button.frame.size.width;
    CGFloat y = CGRectGetHeight(self.frame)-2;
    CGFloat x = CGRectGetMinX(button.frame)-4;
    self.lineLayer.frame = CGRectMake(x, y, width + 8, 2);
}
@end
