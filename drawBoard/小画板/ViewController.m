//
//  ViewController.m
//  小画板
//
//  Created by 施扬 on 16/9/16.
//  Copyright © 2016年 stan. All rights reserved.
//

#import "ViewController.h"
#import "MyDrawBoard.h"
#import "UIImage+rotation.h"

/*
 balalnalanalanalanalanlaank
 */


@interface ViewController ()<UINavigationBarDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet MyDrawBoard *myDrawBoard;
@property (weak, nonatomic) IBOutlet UISlider *drawSli;
@property (weak, nonatomic) IBOutlet UISlider *rubSli;
@property(assign,nonatomic) int filterIndex;





@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
     self.myDrawBoard.lineWidth = 5;
    
    _filterIndex = 0;
}
#pragma mark - 画图

#pragma mark - 选择颜色
-(IBAction)colorSelect:(UIButton *)sender
{
    _myDrawBoard.lineColor =  sender.backgroundColor;
}
#pragma mark - 保存

- (IBAction)saveAction:(UIButton *)sender {
    
    UIGraphicsBeginImageContextWithOptions(_myDrawBoard.bounds.size, NO, 0);
    
    [self.myDrawBoard drawViewHierarchyInRect:_myDrawBoard.bounds afterScreenUpdates:YES];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(newImage, nil, nil, nil);
    
}



#pragma mark ------------------ 以下为新增功能

- (IBAction)drawAction:(UIButton *)sender {
     [self setDrawType:STDRAWTYPE];
    
}
- (IBAction)drawSlider:(UISlider *)sender {
    
    _myDrawBoard.lineWidth = sender.value/2;
}

//橡皮擦
- (IBAction)rubberAction:(UIButton*)sender {
    
    [self setDrawType:STRUBBERTYPE];
}

//橡皮擦大小
- (IBAction)rubberSlider:(UISlider *)sender {
    [self setDrawType:STRUBBERTYPE];
    
        _myDrawBoard.lineWidth = sender.value /2;
    
    
}

//撤销
- (IBAction)cancel:(UIButton *)sender {
    
//    if ([_myDrawBoard.lastIsImage.lastObject isEqual:@0]) {
//        [_myDrawBoard.pathArray removeLastObject];
//        [_myDrawBoard.lastIsImage removeLastObject];
//    }else{
//        [_myDrawBoard.finalImage removeLastObject];
//        [_myDrawBoard.lastIsImage removeLastObject];
//    }
    [_myDrawBoard.pathArray removeLastObject];
   
    [_myDrawBoard setNeedsDisplay];
    
    
}

//删除
- (IBAction)delete:(UIButton *)sender {
    
    [_myDrawBoard.pathArray removeAllObjects];
   
    [_myDrawBoard setNeedsDisplay];
}
//矩形
- (IBAction)rectAction:(UIButton *)sender {
    [self setDrawType:STRECTTYPE];
}

//圆形
- (IBAction)ovalAction:(UIButton *)sender {
    [self setDrawType:STOVALTYPE];
}


#pragma mark - 改变type属性
-(void)setDrawType:(DRAW_INPUT_TYPE)type{
    
    if (_myDrawBoard.type!=STNONETYPE) {
        _myDrawBoard.type = type;
    }
    

    
    switch (type) {
        case STDRAWTYPE:
            _myDrawBoard.lineWidth = _drawSli.value/2;
            break;
        case STRUBBERTYPE:
            _myDrawBoard.lineWidth = _rubSli.value/2;
            break;
        case STRECTTYPE:
            _myDrawBoard.lineWidth = _drawSli.value/2;
            break;
        case STOVALTYPE:
            _myDrawBoard.lineWidth = _drawSli.value/2;
            
            break;
            
        default:
            break;
    }
}

- (IBAction)albumAction:(UIButton *)sender {
    
    [self getImageFromAlbum];
}


#pragma mark - 去相册图片
-(void)getImageFromAlbum
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    
     UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    
    //设置读取属性为全部显示
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    ipc.delegate = self;
    
    [self presentViewController:ipc animated:YES completion:nil];
}


#pragma mark - 获取图片后的操作

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 设置图片
     _myDrawBoard.albumImage = info[UIImagePickerControllerOriginalImage];
 
}
- (IBAction)fastenAction:(UIButton *)sender {
    
    [_myDrawBoard renderImageView];
}

#pragma mark - 设置图片效果

- (IBAction)opacityAction:(UISlider *)sender {
    
    if (_myDrawBoard.imageView) {
        _myDrawBoard.imageView.alpha = sender.value;
        _myDrawBoard.imageViewAlpha = sender.value;
        
    }
    
}
- (IBAction)modeAction:(UIButton *)sender {
    
  
    
//    NSArray *filterArray = @[ @"ColorInvert", @"ColorMonochrome", @"ColorPosterize", @"FalseColor",@"RGBToneCurve", @"MaximumComponent", @"MinimumComponent", @"PhotoEffectChrome", @"PhotoEffectMono", @"PhotoEffectNoir",@"PhotoEffectProcess", @"PhotoEffectTonal", @"PhotoEffectTransfer", @"SepiaTone"];
//    
//    _myDrawBoard.imageView.image =  [_myDrawBoard.imageView.image addFilter:filterArray[_filterIndex]];
    
   
    
//    NSArray *filterArray = @[@"ExtraLight",@"Light",@"Dark"];
    
//    if (_filterIndex==0) {
//        [_myDrawBoard addBlurEffect:UIBlurEffectStyleExtraLight];
//    }else if(_filterIndex==1){
//        [_myDrawBoard addBlurEffect:UIBlurEffectStyleLight];
//    }else{
//         [_myDrawBoard addBlurEffect:UIBlurEffectStyleDark];
//    }
//    
//    _filterIndex++;
//    if (_filterIndex == 2) {
//        _filterIndex = 0;
//    }
    [_myDrawBoard addBlurEffect:UIBlurEffectStyleDark];
}

- (IBAction)mosaicSlider:(UISlider *)sender {
    
    _myDrawBoard.mosaicWH = sender.value;
    
//     [_myDrawBoard addBlurEffect:UIBlurEffectStyleDark];
}

- (IBAction)cleanAction:(id)sender {
    
    [_myDrawBoard cleanAllMosaic];
    
}



@end
