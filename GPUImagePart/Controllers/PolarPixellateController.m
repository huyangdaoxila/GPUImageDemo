//
//  PolarPixellateController.m
//  GPUImageDemo
//
//  Created by huyang on 15/7/10.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "PolarPixellateController.h"

@interface PolarPixellateController ()

@end

@implementation PolarPixellateController

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
    self.slider.maximumValue = 0.1 ;
    self.slider.minimumValue = -0.1 ;
    self.slider.value = 0.05 ;
}

- (void)sliderAction:(UISlider *)slider
{
    GPUImagePolarPixellateFilter *PolarPixellate = [GPUImagePolarPixellateFilter new];
    
    PolarPixellate.pixelSize = CGSizeMake(slider.value, slider.value)  ;
    
    [PolarPixellate forceProcessingAtSize:self.inputImage.size];
    
    [PolarPixellate useNextFrameForImageCapture];
    
    [sourcePicture addTarget:PolarPixellate];
    
    [sourcePicture processImage];
    
    UIImage *sourceImage = [PolarPixellate imageFromCurrentFramebuffer] ;
    self.finalImageView.image = sourceImage ;
}

@end
