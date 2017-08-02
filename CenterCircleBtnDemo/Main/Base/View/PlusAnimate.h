//
//  PlusAnimate.h
//  icar
//
//  Created by cheyifu on 2017/6/27.
//  Copyright © 2017年 cheyifu. All rights reserved.
//

#import <UIKit/UIKit.h>

//通知点击按钮协议
@protocol PublishAnimateDelegate <NSObject>
- (void)didSelectBtnWithBtnTag:(NSInteger)tag;
@end

@interface PlusAnimate : UIView

//通知点击按钮代理人
@property(weak,nonatomic) id<PublishAnimateDelegate> delegate;
//弹出动画view
+(PlusAnimate *)standardPublishAnimateWithView:(UIView *)view;

@end
