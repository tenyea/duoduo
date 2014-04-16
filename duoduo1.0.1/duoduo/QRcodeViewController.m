//
//  QRcodeViewController.m
//  duoduo
//
//  Created by tenyea on 14-4-4.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "QRcodeViewController.h"
#import "ZBarSDK.h"
#import "TYButton.h"
@interface QRcodeViewController ()

@end

@implementation QRcodeViewController
#define barcode_width 200
#define barcode_heigth 200
@synthesize readerView = readerView;
@synthesize timer = timer;
@synthesize barcode = barcode;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//  初始化zbar
    [self _initZBar];
//  初始化扫描背景
    [self _initBackground];
//  初始化按钮
    [self _initButton];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark -
#pragma mark init
//  初始化扫描背景
-(void)_initBackground{
    //    初始化扫描背景
    UIImage *barcode_background = [UIImage imageNamed:@"home_barcode_background.png"];
    UIImageView *barcodeImageView = [[UIImageView alloc]initWithImage:barcode_background];
    barcodeImageView.frame = CGRectMake((ScreenWidth - barcode_width)/2, CGRectGetMidY(self.view.frame) - barcode_heigth/2, barcode_width, barcode_heigth);
    [self.view addSubview:barcodeImageView];
    
    //    初始化扫描条
    barcode = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_barcode.png"]];
    barcode.frame = CGRectMake(15, 15, barcode_width- 30, 3);
    barcode.highlighted = YES;
    [barcodeImageView addSubview:barcode];
//    循环移动扫描条
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(barcodeMove) userInfo:nil repeats:YES];
}
//  初始化zbar
-(void)_initZBar{
    readerView = [[ZBarReaderView alloc]init];
    readerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height );
    readerView.readerDelegate = self;
    //关闭闪光灯
    readerView.torchMode = 0;
    //扫描区域
    CGRect scanMaskRect = CGRectMake(60, CGRectGetMidY(readerView.frame) - 100, 200, 200);
    //    设置放大倍数 防止扫描区域不准确
    readerView.zoom = 1;
    readerView.maxZoom = 1;
    //处理模拟器
    if (TARGET_IPHONE_SIMULATOR) {
        ZBarCameraSimulator *cameraSimulator
        = [[ZBarCameraSimulator alloc]initWithViewController:self];
        cameraSimulator.readerView = readerView;
    }
    [self.view addSubview:readerView];
    //扫描区域计算
    readerView.scanCrop = [self getScanCrop:scanMaskRect readerViewBounds:readerView.bounds];
//    启动
    [readerView start];
}
//  初始化按钮
-(void)_initButton{
    TYButton *button = [[TYButton alloc]init];
    button.backgroundColor = [UIColor grayColor];
    button.alpha = .5;
    [button setTitle:button_cancel forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.touchBlock = ^(TYButton *btn){
        [self closeZbar];
    };
    button.frame = CGRectMake(ScreenWidth -100 , ScreenHeight - 100, 50, 25);
    [self.view addSubview:button];

}
#pragma mark -
#pragma mark method
bool flag = false;
//扫描条滚动
-(void)barcodeMove{
    if (flag) {
        [UIView animateWithDuration:1 animations:^{
            barcode.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
        }];
    }else{
        [UIView animateWithDuration:1 animations:^{
            barcode.transform = CGAffineTransformTranslate(barcode.transform, 0, barcode_heigth - 15*2 - 3);
        } completion:^(BOOL finished) {
        }];
    }
    flag = !flag;
}
//计算扫描范围
-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)rvBounds
{
    CGFloat x,y,width,height;
    //
    x = rect.origin.x / rvBounds.size.width;
    y = rect.origin.y / rvBounds.size.height;
    width = rect.size.width / rvBounds.size.width;
    height = rect.size.height / rvBounds.size.height;
    
    return CGRectMake(x, y, width, height);
}
//关闭zbar 并弹出
-(void)closeZbar{
    [timer invalidate];
    [self.readerView stop];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -
#pragma mark Delegate 
#pragma mark ZBarReaderViewDelegate
- (void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image
{
    
    for (ZBarSymbol *symbol in symbols) {
        NSLog(@"%@", symbol.data);
        break;
    }
    [self performSelector:@selector(closeZbar) withObject:nil afterDelay:1];

}
@end
