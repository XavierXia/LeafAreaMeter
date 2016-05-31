//
//  calculateResultViewController.m
//  bs
//
//  Created by Jackie on 13-10-6.
//  Copyright (c) 2013年 Jackie. All rights reserved.
//

#import "calculateResultViewController.h"
#import "opencv2/opencv.hpp"
//5角硬币的实际面积
#define COIN_AREA 3.300636 //cm2
//5角硬币的实际周长
#define COIN_LENGTH 6.44026 //cm



@implementation calculateResultViewController
@synthesize selectedImage;
@synthesize ImagePrescriptionText;
@synthesize stringArea;
@synthesize stringHeight;
@synthesize stringLength;
@synthesize stringWidth;
@synthesize array;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        array = [[NSMutableArray alloc] init];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    ///>得到图像数据
    cv::Mat CVMat = [self cvMatFromUIImage:(UIImage *)selectedImage];
    //若没有选取图片或获取图片失败，则进行相应处理
    if (!CVMat.data)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误！没有选取图片" message:@"请到相片库中选取要处理的图片" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }
    
    //灰度化
    cv::Mat CVGrayMat;
    cv::cvtColor(CVMat, CVGrayMat, CV_BGR2GRAY);
//    [_dealedImage setContentMode:UIViewContentModeScaleAspectFit];
//    _dealedImage.image = [self UIImageFromCVMat:CVGrayMat];

    //中值滤波
    cv::medianBlur(CVGrayMat, CVGrayMat, 5);
//    [_dealedImage setContentMode:UIViewContentModeScaleAspectFit];
//    _dealedImage.image = [self UIImageFromCVMat:CVGrayMat];

    //二值化
    cv::Mat CVBinaryMat;
    cv::threshold(CVGrayMat, CVBinaryMat, 120, 255, CV_THRESH_BINARY);
    //对图像求反
    cv::bitwise_not(CVBinaryMat, CVBinaryMat);
    
//    [_dealedImage setContentMode:UIViewContentModeScaleAspectFit];
//    _dealedImage.image = [self UIImageFromCVMat:CVBinaryMat];

    //开运算与闭运算
    cv::Mat CVResultMat;
    cv::erode(CVBinaryMat, CVResultMat, cv::Mat());
    cv::dilate(CVResultMat, CVResultMat, cv::Mat());
    cv::dilate(CVResultMat, CVResultMat, cv::Mat());
    cv::erode(CVResultMat, CVResultMat, cv::Mat());
//    [_dealedImage setContentMode:UIViewContentModeScaleAspectFit];
//    _dealedImage.image = [self UIImageFromCVMat:CVResultMat];


    //找到图片中的所有轮廓
    std::vector<std::vector<cv::Point>> contours;
    cv::findContours(CVResultMat, contours, CV_RETR_EXTERNAL, CV_CHAIN_APPROX_NONE);
    //
    cv::Mat ResultImage(CVResultMat.size(),CV_8U, cv::Scalar(255));
    cv::drawContours(ResultImage, contours, -1, cv::Scalar(0),10);
    [_dealedImage setContentMode:UIViewContentModeScaleAspectFit];
    _dealedImage.image = [self UIImageFromCVMat:ResultImage];

    NSLog(@"图像处理结束%ld\n",contours.size());
    
    if(2 != contours.size())
    {
        return;
    }
    float contourAreaLeaf = 0.0;
    float contourLengthLeaf = 0.0;
    
    long NewArray[10]={0,0};
    long lengthArray[10]={0,0};
    
    for(int i =0;i<contours.size();i++)
    {
        NewArray[i] = fabs(cv::contourArea(contours[i]));
        NSLog(@"NewArray:%ld\n",NewArray[i]);
        
        lengthArray[i] = cv::arcLength(contours[i], -1);
        NSLog(@"lengthArray[i]:%ld\n",lengthArray[i]);
    }
    //
    contourAreaLeaf = COIN_AREA/NewArray[0]*NewArray[1];
    //叶片的面积 周长
    contourLengthLeaf = COIN_LENGTH/lengthArray[0]*lengthArray[1];
    NSLog(@"图像处理结束-面积%f\n",contourAreaLeaf);
    NSLog(@"图像处理结束-周长%f\n",contourLengthLeaf);
    
    
    //叶长 叶宽 
    cv::RotatedRect leafAreaRect = cv::minAreaRect(contours[1]);
    float heightWidthRio = leafAreaRect.size.height/leafAreaRect.size.width;
    NSLog(@"叶面积-叶长%f\n",leafAreaRect.size.height);
    NSLog(@"叶面积-叶宽%f\n",leafAreaRect.size.width);
    NSLog(@"叶面积-长宽比%f\n",heightWidthRio);
    
    //
    _ResultLabel.text = [NSString stringWithFormat:@"%f",contourAreaLeaf];
    _leafLength.text = [NSString stringWithFormat:@"%f",contourLengthLeaf];
    
    float leafH = leafAreaRect.size.height*(COIN_LENGTH/lengthArray[0]);
    float leafW = leafAreaRect.size.width*(COIN_LENGTH/lengthArray[0]);
    
    _leafHeight.text = [NSString stringWithFormat:@"%f",leafH];
    _leafWidth.text = [NSString stringWithFormat:@"%f",leafW];
    _leafHW.text = [NSString stringWithFormat:@"%f",heightWidthRio];
    
  
    stringArea = [NSString stringWithFormat:@"叶面积：%f 平方厘米", contourAreaLeaf];
    stringLength = [NSString stringWithFormat:@"叶片周长：%f 厘米",contourLengthLeaf];
    stringHeight = [NSString stringWithFormat:@"叶长：%f 厘米",leafH];
    stringWidth = [NSString stringWithFormat:@"叶宽：%f 厘米",leafW];
    _stringHW = [NSString stringWithFormat:@"长宽比：%f ",heightWidthRio];
    
    NSLog(@"%@",ImagePrescriptionText);
    NSLog(@"%@",stringArea);
    NSLog(@"%@",stringLength);
    NSLog(@"%@",stringHeight);
    NSLog(@"%@",stringWidth);
    NSLog(@"%@",_stringHW);

    //自动保存数据
    static NSMutableArray *staticArray = [[NSMutableArray alloc] init];
    [staticArray addObject:ImagePrescriptionText];
    [staticArray addObject:stringArea];
    [staticArray addObject:stringLength];
    [staticArray addObject:stringHeight];
    [staticArray addObject:stringWidth];
    [staticArray addObject:_stringHW];
    NSLog(@"dataFilePath:%@",[self dataFilePath]);
    
    [staticArray writeToFile:[self dataFilePath] atomically:YES];
//    [array release];
    
    // Do any additional setup after loading the view from its nib.
}

//返回一个完整的文件路径
-(NSString *)dataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"calculate:%@",documentsDirectory);
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}


//将UIImage类型的图像转化为Mat类型
-(cv::Mat) cvMatFromUIImage:(UIImage *)image
{
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;
    
    cv::Mat cvMat(rows, cols, CV_8UC4); // 8 bits per component, 4 channels
    
    CGContextRef contextRef = CGBitmapContextCreate(cvMat.data,                 // Pointer to data
                                                    cols,                       // Width of bitmap
                                                    rows,                       // Height of bitmap
                                                    8,                          // Bits per component
                                                    cvMat.step[0],              // Bytes per row
                                                    colorSpace,                 // Colorspace
                                                    kCGImageAlphaNoneSkipLast |
                                                    kCGBitmapByteOrderDefault); // Bitmap info flags
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
    CGContextRelease(contextRef);
    CGColorSpaceRelease(colorSpace);
    
    return cvMat;
}


//将Mat类型的图像转化为UIImage类型
-(UIImage *)UIImageFromCVMat:(cv::Mat)cvMat
{
    NSData *data = [NSData dataWithBytes:cvMat.data length:cvMat.elemSize()*cvMat.total()];
    CGColorSpaceRef colorSpace;
    
    if (cvMat.elemSize() == 1) {
        colorSpace = CGColorSpaceCreateDeviceGray();
    } else {
        colorSpace = CGColorSpaceCreateDeviceRGB();
    }
    
    CGDataProviderRef provider = CGDataProviderCreateWithCFData(( CFDataRef)data);
    
    // Creating CGImage from cv::Mat
    CGImageRef imageRef = CGImageCreate(cvMat.cols,                                 //width
                                        cvMat.rows,                                 //height
                                        8,                                          //bits per component
                                        8 * cvMat.elemSize(),                       //bits per pixel
                                        cvMat.step[0],                            //bytesPerRow
                                        colorSpace,                                 //colorspace
                                        kCGImageAlphaNone|kCGBitmapByteOrderDefault,// bitmap info
                                        provider,                                   //CGDataProviderRef
                                        NULL,                                       //decode
                                        false,                                      //should interpolate
                                        kCGRenderingIntentDefault                   //intent
                                        );
    
    
    // Getting UIImage from CGImage
    UIImage *finalImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    
    return finalImage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
