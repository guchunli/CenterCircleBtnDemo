//
//  FuncTools.h
//  Yitingbao
//
//  Created by cheyifu on 2017/4/18.
//  Copyright © 2017年 cheyifu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FuncTools : NSObject

//color->image
+ (UIImage *)ImageWithColor:(UIColor *)backgroundColor;

// 相机(摄像头)获取到的图片自动旋转90度解决办法
+ (UIImage *)fixOrientation:(UIImage *)aImage;

//给空字符串设置默认值
+ (NSString *)setDefaultValue:(NSString *)str;

//比较两个日期
+ (int)compareOneStr:(NSString *)dateStr1 withAnotherStr:(NSString *)dateStr2;

//判断是否是空字符串
+ (BOOL)notNullString:(NSString *)str;
//判断是否是空数组
+ (BOOL)notNullArray:(NSArray *)array;

//创建视图
+ (UIButton *)createThemeBtnWithTitle:(NSString *)title withMinY:(CGFloat)minY;
+ (UIButton *)createGrayBtnWithTitle:(NSString *)title withMinY:(CGFloat)minY;

+ (void)showTextHudWithTitle:(NSString *)title;
+ (void)showTextHudWithNetworkFail;
+ (void)showSuccessHudWithTitle:(NSString *)title;

@end
