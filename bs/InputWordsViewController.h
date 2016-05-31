//
//  InputWordsViewController.h
//  bs
//
//  Created by Jackie on 13-10-5.
//  Copyright (c) 2013年 Jackie. All rights reserved.
//

#import <UIKit/UIKit.h>

//协议
@protocol InputWordsViewControllerDelegate;
@interface InputWordsViewController : UIViewController{
    //委托程序
    id<InputWordsViewControllerDelegate> delegate;
}

@property (strong,nonatomic) IBOutlet UITextField *textField;
@property (assign) id<InputWordsViewControllerDelegate> delegate;
//按下“输入完毕”按钮后调用该方法
-(IBAction)doneInput:(id)sender;
@end

//协议定义
@protocol InputWordsViewControllerDelegate <NSObject>
@optional
//协议所定义的方法，在输入完毕后回调
-(void) inputWordsViewController:(InputWordsViewController *) controller
                       didInputWords:(NSString *)text;

@end
