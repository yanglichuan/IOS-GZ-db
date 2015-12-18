//
//  CZStatusCacheTool.m
//  传智微博
//
//  Created by apple on 15-3-16.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CZStatusCacheTool.h"
#import "FMDB.h"
#import "CZStatus.h"
#import "CZAccountTool.h"
#import "CZAccount.h"
#import "CZStatusParam.h"
@implementation CZStatusCacheTool
static FMDatabase *_db;
+ (void)initialize
{
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    // 拼接文件名
    NSString *filePath = [cachePath stringByAppendingPathComponent:@"status.sqlite"];
    // 创建了一个数据库实例
    _db = [FMDatabase databaseWithPath:filePath];
    
    // 打开数据库
    if ([_db open]) {
        NSLog(@"打开成功");
    }else{
        NSLog(@"打开失败");
    }
    
    // 创建表格
    BOOL flag = [_db executeUpdate:@"create table if not exists t_status (id integer primary key autoincrement,idstr text,access_token text,dict blob);"];
    if (flag) {
        NSLog(@"创建成功");
    }else{
        NSLog(@"创建失败");
    }
}

+ (void)saveWithStatuses:(NSArray *)statuses
{
    // 遍历模型数组
    for (NSDictionary *statusDict in statuses) {
        
        
        NSString *idstr = statusDict[@"idstr"];
        NSString *accessToken = [CZAccountTool account].access_token;
        // 纯洁的字典
//        NSDictionary *statusDict = status.keyValues;
//        NSLog(@"%@",statusDict);
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:statusDict];
        
       BOOL flag = [_db executeUpdate:@"insert into t_status (idstr,access_token,dict) values(?,?,?)",idstr,accessToken,data];
        if (flag) {
            NSLog(@"插入成功");
        }else{
            NSLog(@"插入失败");
        }
        
    }
}

+ (NSArray *)statusesWithParam:(CZStatusParam *)param
{
    // 进入程序第一次获取的查询语句
    NSString *sql = [NSString stringWithFormat:@"select * from t_status where access_token = '%@' order by idstr desc limit 20;",param.access_token];
    if (param.since_id) { // 获取最新微博的查询语句
        sql = [NSString stringWithFormat:@"select * from t_status where access_token = '%@' and idstr > '%@' order by idstr desc limit 20;",param.access_token,param.since_id];
    }else if (param.max_id){  // 获取更多微博的查询语句
        sql = [NSString stringWithFormat:@"select * from t_status where access_token = '%@' and idstr <= '%@' order by idstr desc limit 20;",param.access_token,param.max_id];
    }
    
    FMResultSet *set = [_db executeQuery:sql];
    NSMutableArray *arrM = [NSMutableArray array];
    while ([set next]) {
        NSData *data = [set dataForColumn:@"dict"];
        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        CZStatus *s = [CZStatus objectWithKeyValues:dict];
        [arrM addObject:s];
    }
    
    return arrM;
}

@end
