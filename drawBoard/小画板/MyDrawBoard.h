//
//  MyDrawBoard.h
//  小画板
//
//  Created by 施扬 on 16/9/16.
//  Copyright © 2016年 stan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STBezierPath;
typedef NS_ENUM(NSInteger,DRAW_INPUT_TYPE) {
    STDRAWTYPE,
    STRUBBERTYPE,
    STRECTTYPE,
    STOVALTYPE,
    STNONETYPE,
    STBLURTYPE
};

@interface MyDrawBoard : UIView

@property(nonatomic,assign)CGFloat lineWidth;

@property(nonatomic,strong)UIColor *lineColor;

@property(nonatomic,strong) NSMutableArray <STBezierPath *>*pathArray;

@property(nonatomic,assign) DRAW_INPUT_TYPE type;

@property(strong,nonatomic) UIImage *albumImage;

@property(nonatomic,strong) UIImageView *imageView;

@property(nonatomic,assign) CGFloat imageViewAlpha;

//@property(nonatomic,assign)CGFloat mosaicAlpha;

//@property(nonatomic,strong) NSMutableArray <UIImage*> *finalImage;

//@property(nonatomic,strong) NSMutableArray <NSNumber *> *lastIsImage;

@property(nonatomic)CGFloat mosaicWH ;

-(void)renderImageView;

-(void)addBlurEffect:(UIBlurEffectStyle)style;

-(void)cleanAllMosaic;

@end
