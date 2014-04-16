//
//  QRcodeViewController.h
//  duoduo
//
//  Created by tenyea on 14-4-4.
//  Copyright (c) 2014年 zzw. All rights reserved.
//
@protocol QRCodeDelegate <NSObject>



@end
#import "TenyeaBaseViewController.h"
#import "ZBarSDK.h"

@interface QRcodeViewController : UIViewController<ZBarReaderViewDelegate>


@property (nonatomic, strong) ZBarReaderView * readerView ;
@property (nonatomic, strong) NSTimer * timer ;
//    定时上下混动
@property (nonatomic, strong) UIImageView *barcode;

@property (nonatomic, weak) id <QRCodeDelegate> endDelegeta;
@end
