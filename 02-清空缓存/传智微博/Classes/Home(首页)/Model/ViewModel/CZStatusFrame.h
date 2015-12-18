//
//  CZStatusFrame.h
//  传智微博
//
//  Created by apple on 15-3-11.
//  Copyright (c) 2015年 apple. All rights reserved.
//  模型 + 对应控件的frame

#import <Foundation/Foundation.h>

@class CZStatus;
@interface CZStatusFrame : NSObject

/**
 *  微博数据
 */
@property (nonatomic, strong) CZStatus *status;

// 原创微博frame
@property (nonatomic, assign) CGRect originalViewFrame;

/**   ******原创微博子控件frame**** */
// 头像Frame
@property (nonatomic, assign) CGRect originalIconFrame;

// 昵称Frame
@property (nonatomic, assign) CGRect originalNameFrame;

// vipFrame
@property (nonatomic, assign) CGRect originalVipFrame;

// 时间Frame
@property (nonatomic, assign) CGRect originalTimeFrame;

// 来源Frame
@property (nonatomic, assign) CGRect originalSourceFrame;

// 正文Frame
@property (nonatomic, assign) CGRect originalTextFrame;

// 配图Frame
@property (nonatomic, assign) CGRect originalPhotosFrame;



// 转发微博frame
@property (nonatomic, assign) CGRect retweetViewFrame;

/**   ******转发微博子控件frame**** */
// 昵称Frame
@property (nonatomic, assign) CGRect retweetNameFrame;

// 正文Frame
@property (nonatomic, assign) CGRect retweetTextFrame;

// 配图Frame
@property (nonatomic, assign) CGRect retweetPhotosFrame;

// 工具条frame
@property (nonatomic, assign) CGRect toolBarFrame;



// cell的高度
@property (nonatomic, assign) CGFloat cellHeight;

@end
