//
//  ODAuthUserInfoCell.h
//  ODShareSDKSample
//
//  Created by nathan on 2020/5/14.
//  Copyright © 2020 odin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ODAuthCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *platFormIcon;
@property (weak, nonatomic) IBOutlet UILabel *paltFormTitle;
@property(nonatomic,assign) BOOL hasAuth;
@property(nonatomic,assign) NSInteger platformType;
@property(nonatomic,copy) void (^authActionBlock)(BOOL hasAuth,NSInteger platformType);
@end

NS_ASSUME_NONNULL_END
