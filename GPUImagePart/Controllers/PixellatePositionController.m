//
//  PixellatePositionController.m
//  GPUImageDemo
//
//  Created by huyang on 15/7/10.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "PixellatePositionController.h"

@interface PixellatePositionController ()

@end

@implementation PixellatePositionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fixSliderNeededValue
{
    self.slider.maximumValue = 0.5 ;
    self.slider.minimumValue = 0.0 ;
    self.slider.value = 0.25 ;
}

- (void)sliderAction:(UISlider *)slider
{
    GPUImagePixellatePositionFilter *PixellatePosition = [GPUImagePixellatePositionFilter new];
    
    PixellatePosition.radius = slider.value  ;
    
    // 可设置位置
    PixellatePosition.center = CGPointMake(0.3, 0.8);
    
    [PixellatePosition forceProcessingAtSize:self.inputImage.size];
    
    [PixellatePosition useNextFrameForImageCapture];
    
    [sourcePicture addTarget:PixellatePosition];
    
    [sourcePicture processImage];
    
    UIImage *sourceImage = [PixellatePosition imageFromCurrentFramebuffer] ;
    self.finalImageView.image = sourceImage ;
}

@end
