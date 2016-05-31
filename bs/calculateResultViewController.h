//
//  calculateResultViewController.h
//  bs
//
//  Created by Jackie on 13-10-6.
//  Copyright (c) 2013年 Jackie. All rights reserved.
//

#import <UIKit/UIKit.h>
//文件名
#define fileName @"data.plist"

@interface calculateResultViewController : UIViewController
{
    //上一个视图传递过来的图片
    UIImage *selectedImage;
    //上一个视图传递过来的图片描述信息
    NSString *ImagePrescriptionText;
    //
    NSString *stringArea;
    NSString *stringLength;
    NSString *stringHeight;
    NSString *stringWidth;
    NSString *stringHW;
    
    NSMutableArray *array;
}

@property (copy) UIImage *selectedImage;
@property (copy) NSString *ImagePrescriptionText;

@property (copy) NSString *stringArea;
@property (copy) NSString *stringLength;
@property (copy) NSString *stringHeight;
@property (copy) NSString *stringWidth;
@property (copy) NSString *stringHW;

//
@property (nonatomic,retain) NSMutableArray *array;


//处理后的叶参数的输出显示
@property (nonatomic,retain) IBOutlet UILabel *ResultLabel;
@property (nonatomic,retain) IBOutlet UILabel *leafLength;
@property (nonatomic,retain) IBOutlet UILabel *leafHeight;
@property (nonatomic,retain) IBOutlet UILabel *leafWidth;
@property (nonatomic,retain) IBOutlet UILabel *leafHW;

//显示处理后的图像
@property (nonatomic,retain) IBOutlet UIImageView *dealedImage;
//文件的完整路径
+(NSString *)dataFilePath;
//将计算结果数据保存到文件中
-(IBAction)saveDataToFile:(id)sender;

#ifdef __cplusplus
//从UIImage转换到cvMat
-(cv::Mat) cvMatFromUIImage:(UIImage *)image;
//从cvMat转换到UIImage
-(UIImage *) UIImageFromCVMat:(cv::Mat)cvMat;
#endif

@end
