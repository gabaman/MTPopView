//
//  STBezierPath.m
//  小画板
//
//  Created by 施扬 on 16/9/16.
//  Copyright © 2016年 stan. All rights reserved.
//

#import "STBezierPath.h"


@implementation STBezierPath

+(instancetype)bezierPathWithBeginPoint:(CGPoint)beginPoint endPoint:(CGPoint)endPoint type:(DRAW_INPUT_TYPE)type
{
    CGFloat rectX = beginPoint.x>endPoint.x?endPoint.x:beginPoint.x;
    CGFloat rectY = beginPoint.y>endPoint.y?endPoint.y:beginPoint.y;
    CGFloat rectWidth = fabs(endPoint.x - beginPoint.x);
    CGFloat rectHeight = fabs(endPoint.y - beginPoint.y);
    
    return (type==STRECTTYPE)?[STBezierPath bezierPathWithRect:CGRectMake(rectX, rectY, rectWidth, rectHeight)]:[STBezierPath bezierPathWithOvalInRect:CGRectMake(rectX, rectY, rectWidth, rectHeight)];
}

+(CGRect)rectWithBeginPoint:(CGPoint)beginPoint endPoint:(CGPoint)endPoint
{
    CGFloat rectX = beginPoint.x>endPoint.x?endPoint.x:beginPoint.x;
    CGFloat rectY = beginPoint.y>endPoint.y?endPoint.y:beginPoint.y;
    CGFloat rectWidth = fabs(endPoint.x - beginPoint.x);
    CGFloat rectHeight = fabs(endPoint.y - beginPoint.y);
    
    return CGRectMake(rectX, rectY, rectWidth, rectHeight);

}

@end
