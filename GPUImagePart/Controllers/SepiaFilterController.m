//
//  SepiaFilterController.m
//  GPUImageDemo
//
//  Created by huyang on 15/7/10.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "SepiaFilterController.h"

@interface SepiaFilterController ()

@property(strong,nonatomic)UIImage       *inputImage ;
@property(strong,nonatomic)UIImageView   *finalImageView ;

@end

@implementation SepiaFilterController

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
    
    [self setUpNavigationBar];
}

#pragma mark --- 设置 NavigationBarItems

- (void)setUpNavigationBar
{
    UIBarButtonItem *reset = [[UIBarButtonItem alloc] initWithTitle:@"还原" style:UIBarButtonItemStylePlain target:self action:@selector(resetAction)];
    UIBarButtonItem *filter = [[UIBarButtonItem alloc] initWithTitle:@"渲染" style:UIBarButtonItemStylePlain target:self action:@selector(filterAction)];
    
    NSArray *items = @[filter,reset];
    self.navigationItem.rightBarButtonItems = items ;
}

#pragma mark ---  NavigationBarItems action methods

- (void)resetAction
{
    _finalImageView.image = _inputImage ;
}
- (void)filterAction
{
    GPUImagePicture *pic = [[GPUImagePicture alloc] initWithImage:_inputImage];
    
    GPUImageSepiaFilter *sepiaFilter = [GPUImageSepiaFilter new];
    
    [pic addTarget:sepiaFilter];
    [sepiaFilter useNextFrameForImageCapture];
    [pic processImage];
    
    UIImage *filterdImage = [sepiaFilter imageFromCurrentFramebuffer];
    _finalImageView.image = filterdImage ;
}

@end
