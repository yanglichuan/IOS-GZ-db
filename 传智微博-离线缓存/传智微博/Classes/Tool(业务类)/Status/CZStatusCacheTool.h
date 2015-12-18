//
//  CZStatusCacheTool.h
//  传智微博
//
//  Created by apple on 15-3-16.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CZStatusParam;
@interface CZStatusCacheTool : NSObject

// statuses:模型数组（CZStatus）
+ (void)saveWithStatuses:(NSArray *)statuses;

+ (NSArray *)statusesWithParam:(CZStatusParam *)param;

@end
