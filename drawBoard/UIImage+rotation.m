//
//  UIImage+rotation.m
//  小画板
//
//  Created by 施扬 on 16/9/17.
//  Copyright © 2016年 stan. All rights reserved.
//

#import "UIImage+rotation.h"
#import <CoreGraphics/CoreGraphics.h>

@implementation UIImage (rotation)

+(UIImage*)imageRotatedByRotation:(CGFloat)rotatition withImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    
    imageView.transform = CGAffineTransformRotate(imageView.transform, rotatition);
    
    UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, NO, 0);
    
    [imageView drawViewHierarchyInRect:imageView.frame afterScreenUpdates:YES];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}



- (UIImage *)addFilter:(NSString *)filterName
{
    //将UIImage转换成CIImage
    CIImage *ciImage = [[CIImage alloc] initWithImage:self];
    
    //创建滤镜
    CIFilter *filter = [CIFilter filterWithName:filterName keysAndValues:kCIInputImageKey, ciImage, nil];
    
    
    //已有的值不变，其他的设为默认值
    [filter setDefaults];
    
    //获取绘制上下文
    CIContext *context = [CIContext contextWithOptions:nil];
    
    //渲染并输出CIImage
    CIImage *outputImage = [filter outputImage];
    
    //创建CGImage句柄
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    //获取图片
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    
    //释放CGImage句柄
    CGImageRelease(cgImage);
    
    return image;
}



@end
