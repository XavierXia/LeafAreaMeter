//
//  ViewController.m
//  bs
//
//  Created by Jackie on 13-10-5.
//  Copyright (c) 2013年 Jackie. All rights reserved.
//

#import "ViewController.h"
#import "calculateResultViewController.h"

@implementation ViewController
@synthesize imageView;
@synthesize wordsLabel;
@synthesize getImage;

//当按下“从相册中选择照片”按钮后调用
-(IBAction)showImagePicker:(id)sender
{
    //初始化图像选择控制器
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //设置委托类为自己
    imagePickerController.delegate = self;
    //弹出照片选择的页面
    [self presentModalViewController:imagePickerController animated:YES];
    [imagePickerController release];
}

//回调方法：当选择一个照片后调用
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    //将获取到的图片保存起来，后传给下一个视图，进行图像处理
    if (image) {
        getImage = image;
    }

    //获取所选择的照片，并显示
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    imageView.image = image;

#if 0
    UIImageView *imageCodeView = [[UIImageView alloc] initWithFrame:CGRectMake(7, 55, 306, 306*image.size.height/image.size.width)];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    imageCodeView.image = image;
#endif
    //关闭照片选择页面
    [self dismissModalViewControllerAnimated:YES];
}

//回调方法：当取消选择照片后调用
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:YES];
}

//当按下“输入照片描述文字”按钮后调用
-(IBAction)inputWords:(id)sender
{
    InputWordsViewController *inputWordsViewController = [[InputWordsViewController alloc] init];
    inputWordsViewController.delegate = self;
    //弹出文本输入的页面
    [self presentModalViewController:inputWordsViewController animated:YES];
    [inputWordsViewController release];
}

//回调方法：当用户在输入文本后调用
-(void)inputWordsViewController:(InputWordsViewController *)controller didInputWords:(NSString *)text
{
    //显示输入的文本
    wordsLabel.text = text;
    //关闭文本的输入视图
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction)getCalculateResult:(id)sender
{
    calculateResultViewController *calculateResultView = [[calculateResultViewController alloc] init];
    calculateResultView.title = @"结果显示与存储";
    
    //将参数传给下一个视图
    calculateResultView.selectedImage = getImage;
    calculateResultView.ImagePrescriptionText = wordsLabel.text;
    
    [self.navigationController pushViewController:calculateResultView animated:YES];
    [calculateResultView release];
}

- (void)viewDidLoad
{
    //增加标签栏
    UITabBarItem *item = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostViewed tag:0];
    self.tabBarItem = item;
    [item release];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [imageView release];
    [wordsLabel release];
    [super dealloc];
}

@end
