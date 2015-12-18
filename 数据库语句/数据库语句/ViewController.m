//
//  ViewController.m
//  数据库语句
//
//  Created by apple on 15-3-15.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableString *sqlM = [NSMutableString string];
    for (int i = 0 ; i < 100; i++) {
        NSString *name = [NSString stringWithFormat:@"abc%d",arc4random_uniform(100)];
        NSString *sql = [NSString stringWithFormat:@"insert into t_student (name,age) values ('%@',%d);\n",name,arc4random_uniform(100)];
        [sqlM appendString:sql];
    }
    
    NSLog(@"%@",sqlM);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
