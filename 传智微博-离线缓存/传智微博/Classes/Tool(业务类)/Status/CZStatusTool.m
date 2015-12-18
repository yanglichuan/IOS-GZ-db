//
//  CZStatusTool.m
//  传智微博
//
//  Created by apple on 15-3-10.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CZStatusTool.h"

#import "CZHttpTool.h"
#import "CZStatus.h"
#import "CZAccountTool.h"
#import "CZAccount.h"

#import "CZStatusParam.h"
#import "CZStatusResult.h"

#import "MJExtension.h"
#import "CZStatusCacheTool.h"

@implementation CZStatusTool
+ (void)newStatusWithSinceId:(NSString *)sinceId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    // 创建参数模型
    CZStatusParam *param = [[CZStatusParam alloc] init];
    param.access_token = [CZAccountTool account].access_token;
    if (sinceId) { // 有微博数据，才需要下拉刷新
        param.since_id = sinceId;

    }
    
    // 先从数据库里面取数据
    NSArray *statuses = [CZStatusCacheTool statusesWithParam:param];
    
    if (statuses.count) {
        if (success) {
            success(statuses);
        }
        return;
    }
    
    // 如果从数据库里面没有请求到数据，就向服务器请求
    [CZHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.keyValues success:^(id responseObject) { // HttpTool请求成功的回调
        
       
        
        // 请求成功代码先保存
       
        CZStatusResult *result = [CZStatusResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result.statuses);
        }
        
        // 一定要保存服务器最原始的数据
         // 有新的数据，保存到数据库
        [CZStatusCacheTool saveWithStatuses:responseObject[@"statuses"]];
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

+ (void)moreStatusWithMaxId:(NSString *)maxId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    // 创建参数模型
    CZStatusParam *param = [[CZStatusParam alloc] init];
    param.access_token = [CZAccountTool account].access_token;
    if (maxId) { // 有微博数据，才需要下拉刷新
        param.max_id = maxId;
        
    }
    
    // 先从数据库里面取数据
    NSArray *statuses = [CZStatusCacheTool statusesWithParam:param];
    
    if (statuses.count) {
        if (success) {
            success(statuses);
        }
        return;
    }
    
    [CZHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.keyValues success:^(id responseObject) { // HttpTool请求成功的回调
        // 请求成功代码先保存
        
        // 把结果字典转换结果模型
        CZStatusResult *result = [CZStatusResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result.statuses);
        }
        
        // 有新的数据，保存到数据库
        [CZStatusCacheTool saveWithStatuses:responseObject[@"statuses"]];
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
