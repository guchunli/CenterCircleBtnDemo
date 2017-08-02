//
//  YTBNavigationController.m
//  Yitingbao
//
//  Created by cheyifu on 2017/4/18.
//  Copyright © 2017年 cheyifu. All rights reserved.
//

#import "YTBNavigationController.h"
//#define ScanTitleColor  [UIColor colorWithWhite:0.9 alpha:0.8]

@interface YTBNavigationController ()<UINavigationControllerDelegate>
// 记录push标志
@property (nonatomic, getter=isPushing) BOOL pushing;

@end

@implementation YTBNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //status bar
    [self.view addSubview:self.statusView];
    
    //导航栏设为不透明
    self.navigationBar.translucent = NO;
    
    [self.navigationBar setBackgroundImage:[FuncTools ImageWithColor:ThemeBlankColor] forBarMetrics:UIBarMetricsDefault];
    //清楚导航栏下的黑线
    self.navigationBar.shadowImage=[UIImage new];
    //    self.navigationController.toolbarHidden = YES;//如果你的根视图有底部工具栏，这行代码可以隐藏底部的工具栏
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.delegate = self;
}

-(UIView *)statusView{

    if (!_statusView) {
        self.statusView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, kStatusHeight)];
        self.statusView.backgroundColor = ThemeBlankColor;
    }
    return _statusView;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    //隐藏tabbar
    if (self.childViewControllers.count==1) {
        viewController.hidesBottomBarWhenPushed = YES; //viewController是将要被push的控制器
    }
    //防止多次push
    if (self.pushing == YES) {
        return;
    } else {
        self.pushing = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark - UINavigationControllerDelegate
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.pushing = NO;
}

#pragma mark - 解决自定义TabBar使用popToRootViewControllerAnimated重叠问题
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 删除系统自带的tabBarButton
    for (UIView *tabBar in self.tabBarController.tabBar.subviews) {
        if ([tabBar isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBar removeFromSuperview];
        }
    }
}

-(UIStatusBarStyle)preferredStatusBarStyle{

    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
