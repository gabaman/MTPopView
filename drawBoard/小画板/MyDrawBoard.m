//
//  MyDrawBoard.m
//  小画板
//
//  Created by 施扬 on 16/9/16.
//  Copyright © 2016年 stan. All rights reserved.
//

#import "MyDrawBoard.h"
#import "STBezierPath.h"
#import "UIImage+rotation.h"
#define ARC4RANDOM_MAX      0x100000000

@interface MyDrawBoard ()<UIGestureRecognizerDelegate>

@property(nonatomic,strong)STBezierPath *currentPath;
@property(nonatomic,assign)CGPoint beginPoint;

//@property(nonatomic,assign)CGPoint blurBeginPoint;
@property(nonatomic,assign)UIBlurEffectStyle style;

//@property(nonatomic,strong)NSMutableArray <UIView *> *blurViewArray;



@end

@implementation MyDrawBoard

//-(NSMutableArray<UIView *> *)blurViewArray
//{
//    if (!_blurViewArray) {
//        _blurViewArray = [NSMutableArray array];
//        
//    }
//    return _blurViewArray;
//}
//-(NSMutableArray<NSNumber *> *)lastIsImage
//{
//    if (!_lastIsImage) {
//        _lastIsImage = [NSMutableArray array];
//    }
//    return _lastIsImage;
//}
//绘图
- (void)drawRect:(CGRect)rect {
    
    for (STBezierPath *path in _pathArray) {
        if (path.imagePath) {
            [path.imagePath drawInRect:self.bounds];
        }
        else{
            [path.lineColor set];
            
            [path stroke];
        }
        
        
    }
    [_currentPath.lineColor set];
    [_currentPath stroke];
    
    
    
}
-(UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        
        _imageView.userInteractionEnabled = YES;
        
        _type = STNONETYPE;
        
        [self setupGesture];
        
        [self addSubview:_imageView];
        
    }
    
    return _imageView;
}

//-(NSMutableArray<UIImage *> *)finalImage
//{
//    if (!_finalImage) {
//        _finalImage = [NSMutableArray array];
//    }
//    return _finalImage;
//}

-(void)setAlbumImage:(UIImage *)albumImage
{
    _albumImage = albumImage;
    self.imageView.image = albumImage;
    
    [self setNeedsDisplay];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    //yes表示同时支持多个手势
    return YES;
    
}


-(void)awakeFromNib
{
    if (_pathArray == nil) {
         _pathArray = [NSMutableArray array];
    }
    _mosaicWH = 20;
    _imageViewAlpha = 1;

  
}
#pragma mark - 毛玻璃效果
//-(void)addBlurEffect:(UIBlurEffectStyle)style
//{
//    if (_imageView) {
//        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:style];
//        UIVisualEffectView *blurView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
//        
//        blurView.frame = _imageView.frame;
//        _blurView = blurView;
//        [self addSubview:blurView];
//    }
//    
//}

-(void)addBlurEffect:(UIBlurEffectStyle)style
{
    _type = STBLURTYPE;
    _style = style;
    
}

-(void)setupGesture
{
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotationAction:)];
    rotationGesture.delegate  = self;
    [self.imageView addGestureRecognizer:rotationGesture];
    
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchAction:)];
    pinchGesture.delegate = self;
    [self.imageView addGestureRecognizer:pinchGesture];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tapGesture.delegate = self;
    [self.imageView addGestureRecognizer:tapGesture];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    panGesture.delegate = self;
    [self.imageView addGestureRecognizer:panGesture];
    
    
}
-(void)tapAction:(UITapGestureRecognizer*)gesture
{
    [self renderImageView];
}

-(void)panAction:(UIPanGestureRecognizer *)gesture
{
    if (gesture.state==UIGestureRecognizerStateBegan||gesture.state==UIGestureRecognizerStateChanged) {
        CGPoint location = [gesture locationInView:gesture.view.superview];
        _imageView.center = location;
    }
}

-(void)rotationAction:(UIRotationGestureRecognizer*)gesture
{
    //设置imageview的形变
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, gesture.rotation);
    
    //复位
    gesture.rotation = 0;
}

-(void)pinchAction:(UIPinchGestureRecognizer *)gesture
{
    self.imageView.transform = CGAffineTransformScale(self.imageView.transform, gesture.scale, gesture.scale);
    gesture.scale = 1 ;
}



    
    
    
    
//        for (UIImage *image in _finalImage) {
//            [image drawInRect:self.bounds];
//        }
//    
//    
//   
//    
//    for (STBezierPath *path in _pathArray) {
//        
//        [path.lineColor set];
//        
//        [path stroke];
//    }
    
    


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   CGPoint loc = [touches.anyObject locationInView:self];
    
//    STBezierPath *path = [[STBezierPath alloc]init];
//   
//    path.lineWidth = _lineWidth;
  
    _beginPoint = loc;

    switch (_type) {
        case STRUBBERTYPE:
            [self movePath:[UIColor whiteColor] beginPoint:loc];
            break;
        case STDRAWTYPE:
            [self movePath:_lineColor beginPoint:loc];
            break;
        case STOVALTYPE:
            
            break;
        case STRECTTYPE:
            
            break;
        case STBLURTYPE:
          
            break;
            
        default:
            break;
    }

}

-(void)movePath:(UIColor *)color beginPoint:(CGPoint)beginPoint
{
    STBezierPath *path = [[STBezierPath alloc]init];
    
    path.lineWidth = _lineWidth;
    
    path.lineColor = color;
    
    [path moveToPoint:beginPoint];
    
    [self.pathArray addObject:path];

}



-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint loc = [touches.anyObject locationInView:self];
    
    
    
    switch (_type) {
        case STRUBBERTYPE:
            [self.pathArray.lastObject addLineToPoint:loc];
            break;
        case STDRAWTYPE:
            [self.pathArray.lastObject addLineToPoint:loc];
            break;
        case STOVALTYPE:
            _currentPath = [STBezierPath bezierPathWithBeginPoint:_beginPoint endPoint:loc type:STOVALTYPE];
            _currentPath.lineColor = _lineColor;
            _currentPath.lineWidth = _lineWidth;
            break;
        case STRECTTYPE:
            _currentPath = [STBezierPath bezierPathWithBeginPoint:_beginPoint endPoint:loc type:STRECTTYPE];
            _currentPath.lineColor = _lineColor;
            _currentPath.lineWidth = _lineWidth;
            break;
        case STBLURTYPE:
//        {
//            UIBlurEffect *effect = [UIBlurEffect effectWithStyle:_style];
//            UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:effect];
//            effectView.center = loc;
//            effectView.bounds = CGRectMake(0, 0, 20, 20);
//            effectView.alpha = arc4random()/(2*ARC4RANDOM_MAX) +0.5;
//            [self addSubview:effectView];
//            
//            
//            [self.blurViewArray addObject:effectView];
//             break;
//        }
            break;
        default:
            break;
    }

    [self setNeedsDisplay];
}

-(void)creatMosaic:(CGPoint)beginPoint endPoint:(CGPoint)endPoint
{
    UIView *mosaicView = [[UIView alloc]init];
    
    CGRect viewRect = [STBezierPath rectWithBeginPoint:beginPoint endPoint:endPoint];
    
    mosaicView.frame = viewRect;
    
    int mosaicWH = _mosaicWH;
    
    int countW =  (viewRect.size.width/mosaicWH);
    
    int countH = (viewRect.size.height/mosaicWH);
    
    for (int i = 0 ; i<countW; i++) {
        for (int j = 0; j<countH; j++) {
            CGRect rect = CGRectMake(i*mosaicWH, j*mosaicWH, mosaicWH, mosaicWH);
            UIVisualEffectView *effView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];

            effView.frame = rect;
            effView.alpha = arc4random()/(4*ARC4RANDOM_MAX) +0.75;
            [mosaicView addSubview:effView];
        }
    }
    
    [self addSubview: mosaicView];
    
 
}

-(void)cleanAllMosaic
{
  
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_type == STNONETYPE) {
        return;
    }
    
    if (_currentPath) {
         [self.pathArray addObject:_currentPath];
        _currentPath = nil;
        _beginPoint = (CGPoint){0,0};
        return;
    }
     CGPoint loc = [touches.anyObject locationInView:self];
   
    if (_type ==STBLURTYPE) {
        [self creatMosaic:_beginPoint endPoint:loc];
    }
  
        _type = STDRAWTYPE;
        _style = 0;

}

#pragma mark -渲染图片到图层
-(void)renderImageView
{
    //高亮效果
    [UIView animateWithDuration:0.25 animations:^{
        self.imageView.alpha = 0;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.25 animations:^{
            self.imageView.alpha = _imageViewAlpha;
        } completion:^(BOOL finished) {
            
            
            UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
            
            
            [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
            
            UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
            
            UIGraphicsEndImageContext();
            
            STBezierPath *path = [[STBezierPath alloc]init];
            path.imagePath = newImage;
            [self.pathArray addObject:path];
            
            [self setNeedsDisplay];
            
            
            //移除父控件
            [self.imageView removeFromSuperview];
           
            self.imageView = nil;
          
            
            _type = STDRAWTYPE;
        }];
        
    }];
    

}





@end
