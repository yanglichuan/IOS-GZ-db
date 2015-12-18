//
//  ViewController.m
//  01-数据库的简单使用
//
//  Created by apple on 15-3-15.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import <sqlite3.h>
#import "SqliteTool.h"
#import "Student.h"

@interface ViewController ()
@property (nonatomic, assign) sqlite3 *db;
@end

@implementation ViewController
- (IBAction)select:(id)sender {
    
    // 准备查询
    NSString *sql = @"select * from t_student;";
    
   NSArray *arr = [SqliteTool selectWithSql:sql];
    
    for (Student *s in arr) {
        NSLog(@"%@--%d",s.name,s.age);
    }
    
    
    
}
- (IBAction)update:(id)sender {
    NSString *sql = @"update t_student set name = 'aaa' where id = 1;";
    [SqliteTool execWithSql:sql];
}
// 插入数据
- (IBAction)insert:(id)sender {
    
    NSString *sql = @"insert into t_student (name,age) values ('yz',18);";
    [SqliteTool execWithSql:sql];

    
}
- (IBAction)delete:(id)sender {
    NSString *sql = @"delete from t_student;";
    [SqliteTool execWithSql:sql];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    // 创建表
    // 第一个参数：数据库实例
    // 第二个参数：执行的数据库语句
    // char **errmsg :提示错误
    NSString *sql = @"create table if not exists t_student (id integer primary key autoincrement,name text,age integer);";
    [SqliteTool execWithSql:sql];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
