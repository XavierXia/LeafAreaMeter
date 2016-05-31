//
//  ViewController.h
//  bs
//
//  Created by Jackie on 13-10-5.
//  Copyright (c) 2013年 Jackie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputWordsViewController.h"

@interface ViewController : UIViewController
<UIImagePickerControllerDelegate, UINavigationControllerDelegate, InputWordsViewControllerDelegate>
{
    UIImageView *imageView;
    UILabel *wordsLabel;
    UIImage *getImage;
}

//当中的照片
@property (nonatomic,retain) IBOutlet UIImageView *imageView;
//照片下面的描述信息
@property (nonatomic,retain) IBOutlet UILabel *wordsLabel;
@property (nonatomic,retain) UIImage *getImage;
//按下“从相册中选择照片”按钮后调用
-(IBAction)showImagePicker:(id)sender;
//按下“输入照片描述文字”后调用
-(IBAction)inputWords:(id)sender;

//得到计算结果
-(IBAction)getCalculateResult:(id)sender;
@end
