//
//  ODTopView.h
//  ODShareSDKSample
//
//  Created by nathan on 2020/5/18.
//  Copyright © 2020 odin. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ODTopViewBaseTag  10086
NS_ASSUME_NONNULL_BEGIN

@interface ODTopView : UIView
- (void)relaod:(NSInteger)page;
@property(nonatomic,strong) void (^topViewActionBlock)(UIButton *sender);
@end

NS_ASSUME_NONNULL_END
