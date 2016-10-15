//
//  UIImage+rotation.h
//  小画板
//
//  Created by 施扬 on 16/9/17.
//  Copyright © 2016年 stan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (rotation)

+(UIImage*)imageRotatedByRotation:(CGFloat)rotatition withImage:(UIImage *)image;

-(UIImage *)addFilter:(NSString *)filter;  

@end
