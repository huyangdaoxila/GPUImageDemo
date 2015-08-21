//
//  ViewController.m
//  GPUImageDemo
//
//  Created by huyang on 15/7/10.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "ViewController.h"

#import "LightEffectController.h"
#import "SepiaFilterController.h"
#import "ExposureFilterController.h"
#import "ContrastFilterController.h"
#import "SaturationFilterController.h"
#import "GammaFilterController.h"
#import "PixellateFilterController.h"
#import "PolarPixellateController.h"
#import "PixellatePositionController.h"
#import "PlokaDotsController.h"
#import "MoreFiltersController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)UITableView *tableView ;
@property(strong,nonatomic)NSArray     *dataArray ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataArray = @[@[@"BrightnessFilter - 亮度调节"    ,[LightEffectController class]],
                       @[@"SepiaFilter - 土黄色渲染"       ,[SepiaFilterController class]],
                       @[@"ExposureFilter - 曝光调节"      ,[ExposureFilterController class]],
                       @[@"ContrastFilter - 对比度调节"    ,[ContrastFilterController class]],
                       @[@"SaturationFilter - 饱和度调节"  ,[SaturationFilterController class]],
                       @[@"GammaFilter - 伽马线调节"       ,[GammaFilterController class]],
                       @[@"PixellateFilter - 像素模糊"       ,[PixellateFilterController class]],
                       @[@"PolarPixellateFilter - 像素极化翻转" ,[PolarPixellateController class]],
                       @[@"PixellatePositionFilter - (中心)像素模糊" ,[PixellatePositionController class]],
                       @[@"PlokaDotsFilter - 中圆点花"       ,[PlokaDotsController class]],
                       @[@"MoreFilter - 更多滤镜"       ,[MoreFiltersController class]]];
    
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
    cell.textLabel.text = [self titleForRowAtIndexPath:indexPath];
    return cell ;
}

#pragma mark - tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    switch (indexPath.row) {
//        case 0:
//        {
//            LightEffectController *brightNess = [LightEffectController new];
//            brightNess.img = self.selectedImage ;
//            brightNess.title = [self titleForRowAtIndexPath:indexPath];
//            [self.navigationController pushViewController:brightNess animated:YES];
//        }
//            break;
//        case 1:
//        {
//            SepiaFilterController *sepia = [SepiaFilterController new];
//            sepia.img = self.selectedImage ;
//            sepia.title = [self titleForRowAtIndexPath:indexPath];
//            [self.navigationController pushViewController:sepia animated:YES];
//        }
//            break;
//        case 2:
//        {
//            ExposureFilterController *exposure = [ExposureFilterController new];
//            exposure.img = self.selectedImage ;
//            exposure.title = [self titleForRowAtIndexPath:indexPath];
//            [self.navigationController pushViewController:exposure animated:YES];
//        }
//            break;
//        case 3:
//        {
//            ContrastFilterController *contrast = [ContrastFilterController new];
//            contrast.img = self.selectedImage ;
//            contrast.title = [self titleForRowAtIndexPath:indexPath];
//            [self.navigationController pushViewController:contrast animated:YES];
//        }
//            break;
//        case 4:
//        {
//            SaturationFilterController *saturation = [SaturationFilterController new];
//            saturation.img = self.selectedImage ;
//            saturation.title = [self titleForRowAtIndexPath:indexPath];
//            [self.navigationController pushViewController:saturation animated:YES];
//        }
//            break;
//        case 5:
//        {
//            GammaFilterController *gamma = [GammaFilterController new];
//            gamma.img = self.selectedImage ;
//            gamma.title = [self titleForRowAtIndexPath:indexPath];
//            [self.navigationController pushViewController:gamma animated:YES];
//        }
//            break;
//        case 6:
//        {
//            PixellateFilterController *pixellate = [PixellateFilterController new];
//            pixellate.img = self.selectedImage ;
//            pixellate.title = [self titleForRowAtIndexPath:indexPath];
//            [self.navigationController pushViewController:pixellate animated:YES];
//        }
//            break;
//        case 7:
//        {
//            PolarPixellateController *polarPixellate = [PolarPixellateController new];
//            polarPixellate.img = self.selectedImage ;
//            polarPixellate.title = [self titleForRowAtIndexPath:indexPath];
//            [self.navigationController pushViewController:polarPixellate animated:YES];
//        }
//            break;
//        case 8:
//        {
//            PixellatePositionController *pixellatePosition = [PixellatePositionController new];
//            pixellatePosition.img = self.selectedImage ;
//            pixellatePosition.title = [self titleForRowAtIndexPath:indexPath];
//            [self.navigationController pushViewController:pixellatePosition animated:YES];
//        }
//            break;
//        case 9:
//        {
//            PlokaDotsController *plokaDots = [PlokaDotsController new];
//            plokaDots.img = self.selectedImage ;
//            plokaDots.title = [self titleForRowAtIndexPath:indexPath];
//            [self.navigationController pushViewController:plokaDots animated:YES];
//        }
//            break;
//        case 10:
//        {
//            MoreFiltersController *more = [MoreFiltersController new];
//            more.img = self.selectedImage ;
//            more.title = [self titleForRowAtIndexPath:indexPath];
//            [self.navigationController pushViewController:more animated:YES];
//        }
//            break;
//            
//        default:
//            break;
//    }
    
    
    UIViewController *viewController = [self viewControllerForRowAtIndexPath:indexPath];
    viewController.title = [self titleForRowAtIndexPath:indexPath];
    [self.navigationController pushViewController:viewController animated:YES];
    
//    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - private methods

- (NSString *)titleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataArray[indexPath.row] firstObject];
}

- (UIViewController *)viewControllerForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self.dataArray[indexPath.row] lastObject] new];
}

@end
