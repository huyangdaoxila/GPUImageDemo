//
//  MoreFiltersController.m
//  GPUImageDemo
//
//  Created by huyang on 15/7/10.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "MoreFiltersController.h"
#import "ShowCaseFilterController.h"

@interface MoreFiltersController ()<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)UITableView *tableView ;
@property(strong,nonatomic)NSArray     *dataArray ;

@end

@implementation MoreFiltersController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"各种滤镜";
    /*

     */
    self.dataArray = @[@"HALFTONE - 半色调",
                       @"CROSSHATCH - 双向影线",
                       @"MONOCHROME - 单色显示",
                       @"SATURATION - 色饱和度",
                       @"LEVELS - 色阶调整",
                       @"RGB -(此处绿色着色)",
                       @"HUE - 着色",
                       @"WHITEBALANCE - 白色平衡",
                       @"SHARPEN - 锐化",
                       @"UNSHARPMASK - 非锐化遮盖",
                       @"HIGHLIGHTSHADOW - 高光阴影",
                       @"HAZE - 淡褐色",
                       @"HISTOGRAM - 直方图效果",
                       @"THRESHOLD - 黑白漫画风格",
                       @"ADAPTIVETHRESHOLD - 自适应黑白漫画",
                       @"AVERAGELUMINANCETHRESHOLD - 平均亮度黑白漫画",
                       @"SOBELEDGEDETECTION - sobel边缘检测",
                       @"HARRISCORNERDETECTION - harris边角检测",
                       @"NOBLECORNERDETECTION - 角点检测",
                       @"SHITOMASIFEATUREDETECTION - Shi-Tomasi角点检测",
                       @"HOUGHTRANSFORMLINEDETECTOR - 线检测",
                       @"PREWITTEDGEDETECTION - prewitt边缘检测",
                       @"CANNYEDGEDETECTION - canny边缘检测",
                       @"THRESHOLDEDGEDETECTION - 阈值边缘检测",
                       @"LOCALBINARYPATTERN - 局部二值模式",
                       @"LOWPASS - 低通滤波",
                       @"HIGHPASS - 高通滤波",
                       @"SKETCH - 素描",
                       @"THRESHOLDSKETCH - 阈值素描",
                       @"SMOOTHTOON - 光滑渲染",
                       @"EMBOSS - 凹凸印,浮雕",
                       @"POSTERIZE - 多色调分色印",
                       @"SWIRL - 漩涡效果",
                       @"BULGE - 凸起膨胀",
                       @"SPHEREREFRACTION - 球形折射",
                       @"GLASSSPHERE - 玻璃折射",
                       @"PINCH - 捏,夹紧",
                       @"PERLINNOISE - 柏林噪音算法",
                       @"KUWAHARA - 桑原滤波",
                       @"VIGNETTE - 晕映照",
                       @"GAUSSIAN - 高斯模糊",
                       @"BOXBLUR - 均值模糊",
                       @"MOTIONBLUR - 动态模糊",
                       @"ZOOMBLUR - 变焦模糊",
                       @"BILATERAL - 双边模糊"];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self ;
    _tableView.delegate = self ;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

#pragma mark - tableView datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1 ;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    cell.textLabel.textAlignment = NSTextAlignmentCenter ;
    cell.textLabel.textColor = [UIColor redColor];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell ;
}

#pragma mark - tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShowCaseFilterController *showcase = [ShowCaseFilterController new];
    showcase.fliterType = indexPath.row ;
    showcase.img = self.img ;
    [self.navigationController pushViewController:showcase animated:YES];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
