//
//  PlokaDotsController.m
//  GPUImageDemo
//
//  Created by huyang on 15/7/10.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "PlokaDotsController.h"

@interface PlokaDotsController ()

@end

@implementation PlokaDotsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)fixSliderNeededValue
{
    self.slider.maximumValue = 0.3 ;
    self.slider.minimumValue = 0.0 ;
    self.slider.value = 0.05 ;
}

- (void)sliderAction:(UISlider *)slider
{
    GPUImagePolkaDotFilter *PolkaDot = [GPUImagePolkaDotFilter new];
    
    PolkaDot.fractionalWidthOfAPixel = slider.value  ;
    
    [PolkaDot forceProcessingAtSize:self.inputImage.size];
    
    [PolkaDot useNextFrameForImageCapture];
    
    [sourcePicture addTarget:PolkaDot];
    
    [sourcePicture processImage];
    
    UIImage *sourceImage = [PolkaDot imageFromCurrentFramebuffer] ;
    self.finalImageView.image = sourceImage ;
}

@end
