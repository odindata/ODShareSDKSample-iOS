//
//  OdinPlatformViewController.h
//  OdinShareDemo
//
//  Created by nathan on 2019/3/27.
//  Copyright © 2019 Odin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OdinShareSDK/OdinShareSDK.h>
NS_ASSUME_NONNULL_BEGIN

@interface ODPlatformViewController : UIViewController
{
    IBOutlet UITableView *shareTypeTableView;
    NSArray *shareTypeArray;
    NSArray *shareIconArray;
    NSArray *selectorNameArray;
    OdinSocialPlatformType platformType;
    
    NSString *shareTitle;
    NSString *shareDescr;
    NSString *shareText;
    UIImage *shareImg;
    UIImage *shareThumImg;
    NSString *shareWebUrl;
    NSString *shareAudioUrl;
    NSString *shareVideoUrl;
    NSString *shareHttpImg;
}
- (void)alertWithError:(NSError *)error;
- (void)shareWithObj:(OdinSocialMessageObject *)obj;
@end

NS_ASSUME_NONNULL_END
