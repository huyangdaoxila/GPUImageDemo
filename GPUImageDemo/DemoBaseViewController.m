//
//  DemoBaseViewController.m
//  GPUImageDemo
//
//  Created by huyang on 15/7/10.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "DemoBaseViewController.h"

@interface DemoBaseViewController ()

@end

@implementation DemoBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    [self fixSliderNeededValue];
    [_slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [_toolView addSubview:_slider];
    [_slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_toolView.mas_left).offset(15);
        make.right.equalTo(_toolView.mas_right).offset(-15);
        make.top.equalTo(_toolView.mas_top).offset(10);
        make.bottom.equalTo(_toolView.mas_bottom).offset(-10);
    }];
    
    
    sourcePicture = [[GPUImagePicture alloc] initWithImage:_inputImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --- need overwrite

- (void)fixSliderNeededValue
{

}

- (void)sliderAction:(UISlider *)slider
{

}



@end
