//
//  PixellateFilterController.m
//  GPUImageDemo
//
//  Created by huyang on 15/7/10.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "PixellateFilterController.h"

@interface PixellateFilterController ()

@end

@implementation PixellateFilterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIAlertView *alert = [[UIAlertView  alloc] initWithTitle:@"提示" message:@"此操作比较耗资源,慎用" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

- (void)fixSliderNeededValue
{
    self.slider.maximumValue = 0.3 ;
    self.slider.minimumValue = 0.0 ;
    self.slider.value = 0.05 ;
}

- (void)sliderAction:(UISlider *)slider
{
    GPUImagePixellateFilter *PixellateFilter = [GPUImagePixellateFilter new];
    
    PixellateFilter.fractionalWidthOfAPixel = slider.value ;
    
    // size 可自由设置 , 此操作比较耗资源,慎用
    [PixellateFilter forceProcessingAtSize:self.inputImage.size];
    
    [PixellateFilter useNextFrameForImageCapture];
    
    [sourcePicture addTarget:PixellateFilter];
    
    [sourcePicture processImage];
    
    UIImage *sourceImage = [PixellateFilter imageFromCurrentFramebuffer] ;
    self.finalImageView.image = sourceImage ;
}

@end
