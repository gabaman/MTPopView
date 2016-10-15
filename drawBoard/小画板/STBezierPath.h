//
//  STBezierPath.h
//  小画板
//
//  Created by 施扬 on 16/9/16.
//  Copyright © 2016年 stan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyDrawBoard.h"

@interface STBezierPath : UIBezierPath

@property(nonatomic,strong)UIColor *lineColor;

@property(nonatomic,strong)UIImage *imagePath;

@property(nonatomic,strong)UIVisualEffectView *effectView;

+(instancetype)bezierPathWithBeginPoint:(CGPoint)point endPoint:(CGPoint)endPoint type:(DRAW_INPUT_TYPE)type;

+(CGRect)rectWithBeginPoint:(CGPoint)beginPoint endPoint:(CGPoint)endPoint;

@end
