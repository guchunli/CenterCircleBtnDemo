//
//  LoginTextField.m
//  icar
//
//  Created by cheyifu on 2017/4/15.
//  Copyright © 2017年 cheyifu. All rights reserved.
//

#import "LoginTextField.h"

@implementation LoginTextField

-(id)initWithText:(NSString *)text withIcon:(NSString *)imgName
{
    self = [super init];
    if (self) {
        self.placeholder = text;
        self.font = RatioFont(16);
        self.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        self.returnKeyType = UIReturnKeyDone;
        self.userInteractionEnabled = YES;
        //left icon
        UIImageView *phoneView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20*RatioWidth, 20*RatioHeight)];
        phoneView.image = [UIImage imageNamed:imgName];
        phoneView.contentMode = UIViewContentModeScaleAspectFit;
        self.leftView = phoneView;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

-(CGRect) leftViewRectForBounds:(CGRect)bounds {
    CGRect iconRect = [super leftViewRectForBounds:bounds];
//    iconRect.origin.x += 12*RatioWidth;// 右偏10
    iconRect.size.width = 35*RatioWidth;
    return iconRect;
}

//下划线
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextFillRect(context, CGRectMake(0, CGRectGetHeight(self.frame) - 0.5, CGRectGetWidth(self.frame), 0.5));
}

@end
