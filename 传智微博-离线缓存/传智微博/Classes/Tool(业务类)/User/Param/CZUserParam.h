//
//  CZUserParam.h
//  传智微博
//
//  Created by apple on 15-3-10.
//  Copyright (c) 2015年 apple. All rights reserved.
//  用户未读书请求的参数模型


#import <Foundation/Foundation.h>
#import "CZBaseParam.h"
@interface CZUserParam : CZBaseParam

/**
 *  当前登录用户唯一标识符
 */
@property (nonatomic, copy) NSString *uid;

@end
