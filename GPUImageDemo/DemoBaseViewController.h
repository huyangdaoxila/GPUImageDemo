//
//  DemoBaseViewController.h
//  GPUImageDemo
//
//  Created by huyang on 15/7/10.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemoBaseViewController : UIViewController

{
    GPUImageOutput<GPUImageInput> *filter;
    GPUImagePicture *sourcePicture;
}

@property(strong,nonatomic)UIImage       *inputImage ;
@property(strong,nonatomic)UIImageView   *finalImageView ;

@property(strong,nonatomic)UIView        *toolView ;
@property(strong,nonatomic)UISlider      *slider ;
@property(strong,nonatomic)UIImage       *img ;


- (void)fixSliderNeededValue ;
- (void)sliderAction:(UISlider *)slider ;

@end
