//
//  DisplayViewController.h
//  bs
//
//  Created by Jackie on 13-10-25.
//  Copyright (c) 2013年 Jackie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisplayViewController : UITableViewController
<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *listData;
}

@property (nonatomic, retain) NSMutableArray *listData;
//得到数据文件路径
-(NSString *)getDataFilePath;
//切换编辑模式的操作方法
-(IBAction)toggleEdit:(id)sender;
@end