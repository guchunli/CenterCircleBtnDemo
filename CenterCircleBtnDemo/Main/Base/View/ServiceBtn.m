//
//  ServiceBtn.m
//  Yitingbao
//
//  Created by cheyifu on 2017/4/18.
//  Copyright © 2017年 cheyifu. All rights reserved.
//

#import "ServiceBtn.h"
#define kImageRatio 0.65
#define BtnTitleColor   COLOR_WITH_HEX(0x414141)

@implementation ServiceBtn

-(instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title withBeforeImg:(NSString *)beforeImg withActiveImg:(NSString *)activeImg{

    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = RatioFont(12);
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:beforeImg] forState:UIControlStateNormal];
        if ([FuncTools notNullString:activeImg]) {
            [self setImage:[UIImage imageNamed:activeImg] forState:UIControlStateSelected];
        }
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

#pragma mark 返回按钮内部titlelabel的边框
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, contentRect.size.height*kImageRatio-8*RatioHeight, contentRect.size.width, contentRect.size.height-contentRect.size.height*kImageRatio);
}

#pragma mark 返回按钮内部UIImage的边框
-(CGRect) imageRectForContentRect:(CGRect)contentRect{
    CGFloat imgW = contentRect.size.width;
    CGFloat imgH = contentRect.size.height*kImageRatio;
    return CGRectMake(0, 0, imgW, imgH);
}

@end
