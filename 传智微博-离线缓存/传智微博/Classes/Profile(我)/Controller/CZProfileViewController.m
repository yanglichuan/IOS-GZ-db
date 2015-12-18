//
//  CZProfileViewController.m
//  传智微博
//
//  Created by apple on 15-3-5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CZProfileViewController.h"

#import "UIImageView+WebCache.h"

@interface CZProfileViewController ()

@end

@implementation CZProfileViewController
static NSString *ID = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *settting = [[UIBarButtonItem alloc] initWithTitle:@"设置"  style:UIBarButtonItemStyleBordered target:self action:@selector(settting)];
    self.navigationItem.rightBarButtonItem = settting;
    
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
  
}

#pragma mark - 点击设置的时候调用
- (void)settting
{
    
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
   cell.textLabel.text = @"清空图片缓存";
    
    // 获取sdwebImage的缓存
    // 50119318 bite
    // b -> 50119318 / 1024.0
    NSString *title = nil;
    NSUInteger size = [SDImageCache sharedImageCache].getSize;
    if (size > 1024 * 1024) {
        CGFloat floatSize = size / 1024.0 / 1024.0;
        title = [NSString stringWithFormat:@"%.fM",floatSize];
    }else if (size > 1024){
        CGFloat floatSize = size / 1024.0;
        title = [NSString stringWithFormat:@"%.fKB",floatSize];
    }else if(size > 0)
    {
       title = [NSString stringWithFormat:@"%ldKB",size];
    }
    

    cell.detailTextLabel.text = title;
    // 17K
    // 17K
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[SDImageCache sharedImageCache] clearDisk];
    
    [self.tableView reloadData];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
