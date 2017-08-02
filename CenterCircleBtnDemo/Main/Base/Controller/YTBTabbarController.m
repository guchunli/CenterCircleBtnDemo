//
//  YTBTabbarController.m
//  Yitingbao
//
//  Created by cheyifu on 2017/4/18.
//  Copyright © 2017年 cheyifu. All rights reserved.
//

#import "YTBTabbarController.h"
#import "HomeViewController.h"
#import "MallViewController.h"
#import "MovieViewController.h"
#import "InfoViewController.h"
#import "CenterViewController.h"
#import "YTBTabbarButton.h"
#import "PlusAnimate.h"

@interface YTBTabbarController ()<PublishAnimateDelegate>

@property (nonatomic,strong)UIButton *selectedBtn;

@end

@implementation YTBTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建三级控制器
    [self _createViewctrls];
    
    [self _initTabBar];
}

-(void)_createViewctrls{
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    MovieViewController *movieVC = [[MovieViewController alloc] init];
    CenterViewController *centerVC = [[CenterViewController alloc]init];
    MallViewController *mallVC = [[MallViewController alloc] init];
    InfoViewController *infoVC = [[InfoViewController alloc] init];
    NSArray *contrls = @[homeVC,movieVC,centerVC,mallVC,infoVC];
    NSMutableArray *navCtrls = [[NSMutableArray alloc]initWithCapacity:4];
    for (int i = 0; i < contrls.count; i ++) {
        YTBNavigationController *navCtrl = [[YTBNavigationController alloc]initWithRootViewController:contrls[i]];
        [navCtrls addObject:navCtrl];
    }
    
    self.viewControllers = navCtrls;
}

-(void)_initTabBar{
    
    //1.删除系统定义的TabBarItem
    UITabBar *tabBar = self.tabBar;
    NSArray *subViews = tabBar.subviews;
    for (UIView *view in subViews) {
        Class cls = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:cls]) {
            [view removeFromSuperview];
        }
    }
    //标签栏设置背景图片(盖住了状态栏)
    tabBar.translucent = NO;
    tabBar.backgroundImage = [FuncTools ImageWithColor:ThemeBlankColor];
    
    //2.选择按钮
    NSArray *titles = @[@"首页",@"课堂",@"",@"商城",@"信息"];
    NSArray *befores = @[@"home_befor",
                         @"yue_befor",
                         @"addicon",
                         @"jilu_before",
                         @"mine_befor",
                         ];
    NSArray *actives = @[@"home_active",
                         @"yue_active",
                         @"addicon",
                         @"jilu_active",
                         @"mine_active",
                         ];
    CGFloat btnH = tabBar.frame.size.height;
    CGFloat btnW = (tabBar.frame.size.width-btnH-20*RatioHeight)/4;
    for (int i = 0 ; i<titles.count; i++) {
        
        if (i == 2) {
            continue;
        }
        
        CGFloat btnW = tabBar.frame.size.width/titles.count;
        CGFloat btnH = tabBar.frame.size.height;
        YTBTabbarButton *btn = [[YTBTabbarButton alloc]initWithFrame:CGRectMake(i * btnW, 0, btnW, btnH) withTitle:titles[i] withBeforeImg:befores[i] withActiveImg:actives[i]];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        btn.tag = 900+i;
        [self.tabBar addSubview:btn];
        if(i == 0){
            YTBTabbarButton *btn = [self.tabBar viewWithTag:900];
            self.selectedBtn = btn;
            [self btnClick:btn];
        }
    }
    
    UIView *cameraView = [[UIView alloc]init];
    cameraView.backgroundColor = RGB(205, 206, 207);
    //            cameraView.userInteractionEnabled = YES;
    //            CGFloat margin = 17*RatioWidth;
    CGFloat centerH = tabBar.frame.size.height;
    CGFloat centerW = btnH;
    cameraView.frame = CGRectMake(2 * btnW, -10*RatioHeight, centerW+20*RatioHeight, centerH+20*RatioHeight);
    cameraView.layer.cornerRadius = (btnH+20)/2.0;
    cameraView.layer.masksToBounds = YES;
    [self.tabBar addSubview:cameraView];
    [self.tabBar bringSubviewToFront:cameraView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(centerClick:)];
     [cameraView addGestureRecognizer:tap];
    
    //添加加号按钮
    UIButton *cameraBtn = [[UIButton alloc]init];
    cameraBtn.userInteractionEnabled = NO;
    [cameraBtn setBackgroundImage:[UIImage imageNamed:befores[2]] forState:UIControlStateNormal];
    [cameraBtn setBackgroundImage:[UIImage imageNamed:actives[2]] forState:UIControlStateHighlighted];
    cameraBtn.tag = 100+2;
    //            CGFloat cameraW = 36*RatioWidth;
    CGFloat x = 10*RatioHeight;
    cameraBtn.frame = CGRectMake(x, x, centerW, centerH);
//    [cameraBtn addTarget:self action:@selector(centerClick:) forControlEvents:UIControlEventTouchUpInside];
    [cameraView addSubview:cameraBtn];
}

- (void)btnClick:(YTBTabbarButton *)button{
    
    //1.先将之前选中的按钮设置为未选中
    self.selectedBtn.selected = NO;
    //2.再将当前按钮设置为选中
    button.selected = YES;
    //3.最后把当前按钮赋值为之前选中的按钮
    self.selectedBtn = button;
    //4.跳转到相应的视图控制器. (通过selectIndex参数来设置选中了那个控制器)
    self.selectedIndex = button.tag-900;
}

-(void)centerClick:(UITapGestureRecognizer *)tap{
    
    PlusAnimate *animateView = [[PlusAnimate alloc]init];
    animateView.delegate = self;
//    [PlusAnimate standardPublishAnimateWithView:tap.view];
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:animateView];
}

- (void)didSelectBtnWithBtnTag:(NSInteger)tag{

    NSLog(@"service:%ld",tag);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
