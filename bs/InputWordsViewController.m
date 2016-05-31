//
//  InputWordsViewController.m
//  bs
//
//  Created by Jackie on 13-10-5.
//  Copyright (c) 2013年 Jackie. All rights reserved.
//

#import "InputWordsViewController.h"

//@interface InputWordsViewController ()
@implementation InputWordsViewController
@synthesize textField;
@synthesize delegate;

//按下“输入完毕”按钮后所调用的方法
-(IBAction) doneInput:(id)sender
{
    //调用回调方法
    if ([self.delegate respondsToSelector:@selector(inputWordsViewController:didInputWords:)]) {
        [self.delegate inputWordsViewController:self didInputWords:textField.text];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
