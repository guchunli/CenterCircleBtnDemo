//
//  PlusAnimate.m
//  icar
//
//  Created by cheyifu on 2017/6/27.
//  Copyright © 2017年 cheyifu. All rights reserved.
//

#import "PlusAnimate.h"
#import "XXXRoundMenuButton.h"
#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.height
#define CenterPoint CGPointMake(W/2 ,H-38.347785)
#define bl [[UIScreen mainScreen]bounds].size.width/375
#define Color(r, g, b , a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

@interface PlusAnimate ()<CenterSelectedProtocal>

@property (nonatomic,strong) XXXRoundMenuButton *roundMenu;

//center button
@property (strong , nonatomic) UIButton* CenterBtn;

/** rect */
@property (nonatomic,assign) CGRect rect;

@end

@implementation PlusAnimate

/**
 *  show view
 */
+ (PlusAnimate *)standardPublishAnimateWithView:(UIView *)view{
    PlusAnimate * animateView = [[PlusAnimate alloc]init];
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:animateView];
    
    return animateView;
}

- (instancetype)init{
    self = [super init];
    if (self)
    {
        self.frame = [[UIScreen mainScreen]bounds];
        self.backgroundColor =[[UIColor blackColor]colorWithAlphaComponent:0.1];
        
        UIBlurEffect *blurEffect=[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *visualEffectView=[[UIVisualEffectView alloc]initWithEffect:blurEffect];
        [visualEffectView setFrame:self.bounds];
        [self addSubview:visualEffectView];
        
        [self addSubview:self.roundMenu];

//        [self CrentCenterBtnImageName:@"addicon" tag:199];

        [self AnimateBegin];
        
    }
    return self;
}

- (XXXRoundMenuButton *)roundMenu{
    
    if (!_roundMenu) {
        
        CGFloat btnH = 49;
        CGFloat menuH = KScreenWidth*0.6;
        _roundMenu = [[XXXRoundMenuButton alloc]initWithFrame:CGRectMake(0, 0, menuH, menuH)];
        _roundMenu.layer.cornerRadius = 100;
        _roundMenu.layer.masksToBounds = YES;
        _roundMenu.backgroundColor = [UIColor clearColor];
        _roundMenu.mainColor = RGB(58, 199, 158);
        _roundMenu.center = CGPointMake(KScreenWidth/2.0, self.bounds.size.height-(btnH/2.0));
        _roundMenu.centerButtonSize = CGSizeMake(btnH, btnH);
        _roundMenu.centerIconType = XXXIconTypePlus;
        _roundMenu.tintColor = [UIColor whiteColor];
        _roundMenu.jumpOutButtonOnebyOne = NO;
        _roundMenu.delegate = self;
        
        [_roundMenu setDrawCenterButtonIconBlock:^(CGRect rect, UIControlState state) {
            
            if (state == UIControlStateNormal)
            {
                UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake((rect.size.width - 15)/2, rect.size.height/2 - 5, 15, 1)];
                [UIColor.whiteColor setFill];
                [rectanglePath fill];
                
                
                UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRect: CGRectMake((rect.size.width - 15)/2, rect.size.height/2, 15, 1)];
                [UIColor.whiteColor setFill];
                [rectangle2Path fill];
                
                UIBezierPath* rectangle3Path = [UIBezierPath bezierPathWithRect: CGRectMake((rect.size.width - 15)/2, rect.size.height/2 + 5, 15, 1)];
                [UIColor.whiteColor setFill];
                [rectangle3Path fill];
            }
        }];
        
//        NSArray *icons = @[
//                           [UIImage imageNamed:@"icon_can"],
//                           [UIImage imageNamed:@"icon_pos"],
//                           [UIImage imageNamed:@"icon_img"],
//                           [UIImage imageNamed:@"icon_can"],
//                           [UIImage imageNamed:@"icon_pos"],
//                           [UIImage imageNamed:@"icon_img"],
//                           [UIImage imageNamed:@"icon_can"],
//                           [UIImage imageNamed:@"icon_pos"],
//                           
//                           ];
        NSArray *icons = @[@"icon_can",@"icon_pos",@"icon_img",@"icon_can",@"icon_pos",@"icon_img",@"icon_can",@"icon_pos"];
        NSArray *selIcons = @[@"icon_can",@"icon_pos",@"icon_img",@"icon_can",@"icon_pos",@"icon_img",@"icon_can",@"icon_pos"];
        NSArray *titles = @[@"0",@"1",@"个人设置",@"项目管理"
                            ,@"需求发布",@"工程承接",@"售后服务",@"7"];
        [_roundMenu loadButtonWithIcons:icons withSelIcons:selIcons withTitles:titles startDegree:0 layoutDegree:M_PI*2*7/8];
        
        __weak typeof(self) weakSelf = self;
        [_roundMenu setButtonClickBlock:^(NSInteger idx) {
            
            [weakSelf removeFromSuperview];
            [weakSelf.delegate didSelectBtnWithBtnTag:idx];
        }];
    }
    
    return _roundMenu;
}

-(void)btnSelected:(BOOL)selected{

    if (!selected) {
        [self removeFromSuperview];
    }
}

/**
 *  creat center button
 */
- (void)CrentCenterBtnImageName:(NSString *)ImageName tag:(int)tag{
    
    CGFloat btnH = 49;
    CGFloat btnW = btnH;
    CGFloat btnX = (KScreenWidth-btnW)/2.0;
    CGFloat btnY = (self.bounds.size.height-btnH);
    _CenterBtn = [[UIButton alloc]initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
    [_CenterBtn setImage:[UIImage imageNamed:ImageName] forState:UIControlStateNormal];
    [_CenterBtn addTarget:self action:@selector(cancelAnimation) forControlEvents:UIControlEventTouchUpInside];
    _CenterBtn.tag = tag;
    [self addSubview:_CenterBtn];
}

/**
 *  click other space to cancle
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self cancelAnimation];
}

/**
 *  Do animation
 */
- (void)AnimateBegin{
    //centet button rotation
    [UIView animateWithDuration:0.2 animations:^{
        _CenterBtn.transform = CGAffineTransformMakeRotation(-M_PI_4-M_LOG10E);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            _CenterBtn.transform = CGAffineTransformMakeRotation(-M_PI_4+M_LOG10E);
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 animations:^{
                _CenterBtn.transform = CGAffineTransformMakeRotation(-M_PI_4);
            }];
        }];
    }];
}

/**
 *  Cancle animation
 */
- (void)cancelAnimation{
    //rotation
    [UIView animateWithDuration:0.1 animations:^{
        _CenterBtn.transform = CGAffineTransformIdentity;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

@end
