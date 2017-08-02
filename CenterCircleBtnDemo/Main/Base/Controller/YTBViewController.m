//
//  YTBViewController.m
//  Yitingbao
//
//  Created by cheyifu on 2017/4/18.
//  Copyright © 2017年 cheyifu. All rights reserved.
//

#import "YTBViewController.h"

@interface YTBViewController ()

@end

@implementation YTBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //0,0
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.extendedLayoutIncludesOpaqueBars = YES;
    
    self.view.backgroundColor = ViewBgColor;
    
    if (self.navigationController.viewControllers.count>1 || self.clearType == 2) {
        
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(0, 0, 60, 44);
        [backBtn setImage:[UIImage imageNamed:@"left_back"] forState:UIControlStateNormal];
        backBtn.imageEdgeInsets = UIEdgeInsetsMake(12*RatioHeight, 5*RatioWidth, 12*RatioHeight, 25*RatioWidth);
        [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = leftItem;
        
        //自定义导航栏按钮会不能用手势,设置返回手势
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}

- (void)backAction{
    
    if (self.clearType == 1) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else if (self.clearType == 2) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
//    else if (self.clearType == 3) {
//        [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
//    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//显示加载视图
- (void)showHudWithTitle:(NSString *)title {
    
//    if (_hud == nil) {
        if (_hud) {
            [_hud removeFromSuperview];
        }
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        _hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
        _hud.mode = MBProgressHUDModeIndeterminate;
        _hud.removeFromSuperViewOnHide = YES;
//    }else{
//    
//        [_hud showAnimated:YES];
//    }
    
    //设置显示的标题
    _hud.labelText = NSLocalizedString(title, @"");
//    hud.label.textColor = [UIColor whiteColor];
//    //设置灰色视图覆盖屏幕
//    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
//    hud.bezelView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.9];
}

//隐藏加载视图
- (void)hideHud {
    
    if (_hud) {
        [_hud hide:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
