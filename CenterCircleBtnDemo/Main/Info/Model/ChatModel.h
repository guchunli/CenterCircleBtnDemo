//
//  ChatModel.h
//  CYFService
//
//  Created by cheyifu on 2017/7/18.
//  Copyright © 2017年 cheyifu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatModel : NSObject
    
@property (nonatomic,copy) NSString *strError;
@property (nonatomic,copy) NSString *result;
@property (nonatomic,copy) NSString *myImusername;
@property (nonatomic,copy) NSString *imusername;
@property (nonatomic,copy) NSString *myImuserPwd;

@end
