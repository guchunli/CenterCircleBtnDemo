//
//  FuncTools.m
//  Yitingbao
//
//  Created by cheyifu on 2017/4/18.
//  Copyright © 2017年 cheyifu. All rights reserved.
//

#import "FuncTools.h"

@implementation FuncTools

//color->image
+ (UIImage *)ImageWithColor:(UIColor *)backgroundColor {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

// 相机(摄像头)获取到的图片自动旋转90度解决办法
+ (UIImage *)fixOrientation:(UIImage *)aImage {
    
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

+ (NSString *)setDefaultValue:(NSString *)str{
    
    if (![FuncTools notNullString:str]) {
        return @"未知";
    }
    return str;
}

+ (int)compareOneStr:(NSString *)dateStr1 withAnotherStr:(NSString *)dateStr2{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date1 = [formatter dateFromString:dateStr1];
    NSDate *date2 = [formatter dateFromString:dateStr2];
    
    if ([date1 compare:date2] == NSOrderedDescending) {
        return 1;
    }else{
        return 0;
    }
}

+ (BOOL)notNullString:(NSString *)str{
    
    if (str == nil || str == NULL || [str isKindOfClass:[NSNull class]] || [[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return NO;
    }
    return YES;
}

+ (BOOL)notNullArray:(NSArray *)array{
    
    if(array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0){
        return NO;
    }
    return YES;
}

+ (UIButton *)createThemeBtnWithTitle:(NSString *)title withMinY:(CGFloat)minY{
    
    CGFloat btnMargin = 25*RatioWidth;
    CGFloat btnW = (KScreenWidth-2*btnMargin);
    UIButton *blueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    blueBtn.frame = CGRectMake(btnMargin, minY, btnW, 44*RatioHeight);
    blueBtn.layer.cornerRadius = 5;
    blueBtn.layer.masksToBounds = YES;
    [blueBtn setTitleColor:COLOR_WITH_HEX(0x45444a) forState:UIControlStateNormal];
    [blueBtn setTitle:title forState:UIControlStateNormal];
    blueBtn.backgroundColor = ThemeYellowColor;
    return blueBtn;
}

+ (UIButton *)createGrayBtnWithTitle:(NSString *)title withMinY:(CGFloat)minY{
    
    UIButton *btn = [FuncTools createThemeBtnWithTitle:title withMinY:minY];
    btn.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return btn;
}

+ (void)showTextHudWithTitle:(NSString *)title{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = NSLocalizedString(title, @"");
//        hud.label.numberOfLines = 0;
        hud.labelFont = RatioFont(16);
        hud.margin = 10.f;
        hud.yOffset = 0.f;
//        hud.color = [UIColor colorWithWhite:0.9 alpha:0.8];
//        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
//        hud. = [UIColor colorWithWhite:0.1 alpha:0.9];
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:2.f];
    });
}

+ (void)showTextHudWithNetworkFail{
    
    [FuncTools showTextHudWithTitle:@"网络请求失败"];
}

+ (void)showSuccessHudWithTitle:(NSString *)title{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        hud.mode = MBProgressHUDModeCustomView;
        UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        hud.customView = [[UIImageView alloc] initWithImage:image];
        //        hud.square = YES;
        hud.labelText = NSLocalizedString(title, @"HUD done title");
        hud.labelFont = RatioFont(16);
        [hud hide:YES afterDelay:2.f];
    });
}

@end
