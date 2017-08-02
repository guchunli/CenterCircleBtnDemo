//
//  YTBViewController.h
//  Yitingbao
//
//  Created by cheyifu on 2017/4/18.
//  Copyright © 2017年 cheyifu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTBViewController : UIViewController<UIGestureRecognizerDelegate>
{
    MBProgressHUD *_hud;
}

@property(nonatomic,assign)int clearType;

- (void)backAction;

//显示加载视图
- (void)showHudWithTitle:(NSString *)title;
//隐藏加载视图
- (void)hideHud;

@end
