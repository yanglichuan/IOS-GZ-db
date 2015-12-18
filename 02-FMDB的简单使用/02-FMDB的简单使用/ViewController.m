//
//  ViewController.m
//  02-FMDB的简单使用
//
//  Created by apple on 15-3-16.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import "FMDB.h"

@interface ViewController ()
@property (nonatomic, strong) FMDatabase *db;
@end

@implementation ViewController
- (IBAction)select:(id)sender {
    
  FMResultSet *result =  [_db executeQuery:@"select * from t_contact"];
    
    // 从结果集里面往下找
    while ([result next]) {
     NSString *name = [result stringForColumn:@"name"];
        NSString *phone = [result stringForColumn:@"phone"];
        NSLog(@"%@--%@",name,phone);
    }
    
}
- (IBAction)update:(id)sender {
    // FMDB？，只能是对象，不能是基本数据类型，如果是int类型，就包装成NSNumber
    BOOL flag = [_db executeUpdate:@"update t_contact set name = ?",@"abc"];
    if (flag) {
        NSLog(@"success");
    }else{
        NSLog(@"failure");
    }
}
- (IBAction)insert:(id)sender {
    // ?:表示数据库里面的占位符
   BOOL flag = [_db executeUpdate:@"insert into t_contact (name,phone) values (?,?)",@"oooo",@"21321321"];
    if (flag) {
        NSLog(@"success");
    }else{
         NSLog(@"failure");
    }
    
}
- (IBAction)delete:(id)sender {
    BOOL flag = [_db executeUpdate:@"delete from t_contact;"];
    if (flag) {
        NSLog(@"success");
    }else{
        NSLog(@"failure");
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    // 拼接文件名
    NSString *filePath = [cachePath stringByAppendingPathComponent:@"contact.sqlite"];
    // 创建一个数据库的实例,仅仅在创建一个实例，并会打开数据库
    FMDatabase *db = [FMDatabase databaseWithPath:filePath];
    _db = db;
    // 打开数据库
    BOOL flag = [db open];
    if (flag) {
        NSLog(@"打开成功");
    }else{
        NSLog(@"打开失败");
    }
    
    // 创建数据库表
    // 数据库操作：插入，更新，删除都属于update
    // 参数：sqlite语句
   BOOL flag1 = [db executeUpdate:@"create table if not exists t_contact (id integer primary key autoincrement,name text,phone text);"];
    if (flag1) {
        NSLog(@"创建成功");
    }else{
        NSLog(@"创建失败");

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
