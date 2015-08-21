//
//  LightEffectController.m
//  GPUImageDemo
//
//  Created by huyang on 15/7/10.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "LightEffectController.h"

@interface LightEffectController ()

@property(strong,nonatomic)UIImage       *inputImage ;
@property(strong,nonatomic)UIImageView   *finalImageView ;

@property(strong,nonatomic)UIView        *toolView ;
@property(strong,nonatomic)UISlider      *slider ;

@end

@implementation LightEffectController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 初始化imageView
    _inputImage = [UIImage imageNamed:@"04.JPG"];
    _finalImageView = [[UIImageView alloc] initWithImage:_inputImage];
    _finalImageView.frame = CGRectZero ;
    [self.view addSubview:_finalImageView];
    [_finalImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    // 添加一个工具条
    _toolView = [[UIView alloc] initWithFrame:CGRectZero];
    _toolView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    [self.view addSubview:_toolView];
    [_toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@60);
    }];
    
    // 添加滑块儿控件
    _slider = [[UISlider alloc] initWithFrame:CGRectZero];
    _slider.backgroundColor = [UIColor clearColor] ;
    _slider.thumbTintColor = [UIColor whiteColor];
    _slider.minimumValue = -1.f ;
    _slider.maximumValue = 1.f ;
    _slider.value = 0.f ;
    [_slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [_toolView addSubview:_slider];
    [_slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_toolView.mas_left).offset(15);
        make.right.equalTo(_toolView.mas_right).offset(-15);
        make.top.equalTo(_toolView.mas_top).offset(10);
        make.bottom.equalTo(_toolView.mas_bottom).offset(-10);
    }];
}

#pragma mark --- 亮度调节

- (void)sliderAction:(UISlider *)slider
{
    CGFloat sliderValue = slider.value ;
    
    // 创建一个亮度的滤镜,并设置亮度的初始值
    GPUImageBrightnessFilter *brightnessFilter = [GPUImageBrightnessFilter new];
    // The adjusted brightness (-1.0 - 1.0, with 0.0 as the default)
    brightnessFilter.brightness = sliderValue ;
    
    // 设置要渲染的区域
    [brightnessFilter forceProcessingAtSize:_inputImage.size];
    
    // 持续对图片进行渲染
    [brightnessFilter useNextFrameForImageCapture];
    
    // 获取 GPUImagePicture 数据源
    GPUImagePicture *pic = [[GPUImagePicture alloc] initWithImage:_inputImage] ;
    
    // 添加调节亮度的滤镜
    [pic addTarget:brightnessFilter];
    
    // 开始渲染图片
    [pic processImage];
    
    // 获取渲染后的图片并且显示出来
    UIImage *sourceImage = [brightnessFilter imageFromCurrentFramebuffer] ;
    _finalImageView.image = sourceImage ;
}


@end
