//
//  DisplayViewController.m
//  bs
//
//  Created by Jackie on 13-10-25.
//  Copyright (c) 2013年 Jackie. All rights reserved.
//

#import "DisplayViewController.h"
#import "calculateResultViewController.h"

@interface DisplayViewController ()

@end

@implementation DisplayViewController
@synthesize listData;

-(IBAction)toggleEdit:(id)sender
{
    [self.tableView setEditing:self.tableView.editing animated:YES];
    
    if (self.tableView.editing)
    {
        [self.navigationItem.rightBarButtonItem setTitle:@"完成"];
    }
    else
    {
        [self.navigationItem.rightBarButtonItem setTitle:@"取消"];
    }
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        //获取数据文件
        NSString *filePath = [self getDataFilePath];
        NSLog(@"%@",filePath);
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
        {
            self.listData = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
            NSLog(@"listData:%@",self.listData);
        }
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    //增加标题栏
    UITabBarItem *item = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:0];
    self.tabBarItem = item;
    [item release];
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"取消"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(toggleEdit:)];
    
    self.navigationItem.rightBarButtonItem = editButton;
    [editButton release];
    
    [super viewDidLoad]; 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%d",[self.listData count]);
    return [self.listData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellForRowIndexPath");
    static NSString *ResultTableIdentifier = @"ResultTableIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ResultTableIdentifier];
    //若没有可重用的表单元
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ResultTableIdentifier] autorelease];
    }
    
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [listData objectAtIndex:row];
    //
    if (0 == row%6)
    {
        cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
    }
    return cell;
}

-(NSString *)getDataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}

#if 1
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
#endif
/*
 // Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{    
    NSUInteger row = [indexPath row];
    [self.listData removeObjectAtIndex:row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                     withRowAnimation:UITableViewRowAnimationFade];
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
