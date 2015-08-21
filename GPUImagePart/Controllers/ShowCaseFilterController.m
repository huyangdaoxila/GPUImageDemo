//
//  ShowCaseFilterController.m
//  GPUImageDemo
//
//  Created by huyang on 15/7/10.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "ShowCaseFilterController.h"

@interface ShowCaseFilterController ()

{
    GPUImageOutput<GPUImageInput> *filter;
}

@property(strong,nonatomic)UIImage       *inputImage ;
@property(strong,nonatomic)UIImageView   *finalImageView ;

@property(strong,nonatomic)UIView        *toolView ;
@property(strong,nonatomic)UISlider      *slider ;

@end

@implementation ShowCaseFilterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initSubviewsUI];
}

#pragma mark --- 初始化子视图

- (void)initSubviewsUI
{
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
    [self initFilterWithType];
    [_slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [_toolView addSubview:_slider];
    [_slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_toolView.mas_left).offset(15);
        make.right.equalTo(_toolView.mas_right).offset(-15);
        make.top.equalTo(_toolView.mas_top).offset(10);
        make.bottom.equalTo(_toolView.mas_bottom).offset(-10);
    }];
}

#pragma mark --- 根据不同的类型初始化filter , 并设置slider的相关的值

- (void)initFilterWithType
{
    GPUImageFilterType type  = self.fliterType ;
    switch (type) {
        case GPUIMAGE_HALFTONE:
        {
            self.title = @"halftone";
            [self.slider setValue:0.01];
            [self.slider setMinimumValue:0.0];
            [self.slider setMaximumValue:0.05];
            filter = [GPUImageHalftoneFilter new];
        }
            break;
        case GPUIMAGE_CROSSHATCH:
        {
            self.title = @"crosshatch";
            [self.slider setValue:0.03];
            [self.slider setMinimumValue:0.01];
            [self.slider setMaximumValue:0.06];
            filter = [GPUImageCrosshatchFilter new];
        }
            break;
        case GPUIMAGE_MONOCHROME:
        {
            self.title = @"monochrome";
            [self.slider setValue:1.0];
            [self.slider setMinimumValue:0.0];
            [self.slider setMaximumValue:1.0];
            filter = [GPUImageMonochromeFilter new];
            [(GPUImageMonochromeFilter*)filter setColor:(GPUVector4){0.0,0.0,1.0,1.0}];
        }
            break;
        case GPUIMAGE_SATURATION:
        {
            self.title = @"saturation";
            [self.slider setValue:1.0];
            [self.slider setMinimumValue:0.0];
            [self.slider setMaximumValue:2.0];
            filter = [GPUImageSaturationFilter new];
        }
            break;
        case GPUIMAGE_LEVELS:
        {
            self.title = @"levels";
            [self.slider setValue:0.0];
            [self.slider setMinimumValue:0.0];
            [self.slider setMaximumValue:1.0];
            filter = [GPUImageLevelsFilter new];
        }
            break;
        case GPUIMAGE_RGB:
        {
            self.title = @"RGB";
            [self.slider setValue:1.0];
            [self.slider setMinimumValue:0.0];
            [self.slider setMaximumValue:2.0];
            filter = [GPUImageRGBFilter new];
        }
            break;
        case GPUIMAGE_HUE:
        {
            self.title = @"Hue";
            [self.slider setValue:90.0];
            [self.slider setMinimumValue:0.0];
            [self.slider setMaximumValue:360.0];
            filter = [GPUImageHueFilter new];
        }
            break;
        case GPUIMAGE_WHITEBALANCE:
        {
            self.title = @"white blance";
            [self.slider setValue:5000.0];
            [self.slider setMinimumValue:2500.0];
            [self.slider setMaximumValue:7500.0];
            filter = [GPUImageWhiteBalanceFilter new];
        }
            break;
        case GPUIMAGE_SHARPEN:
        {
            self.title = @"sharpen";
            [self.slider setValue:0.0];
            [self.slider setMinimumValue:-1.0];
            [self.slider setMaximumValue:4.0];
            filter = [GPUImageSharpenFilter new];
        }
            break;
        case GPUIMAGE_UNSHARPMASK:
        {
            self.title = @"unsharp mask";
            [self.slider setValue:1.0];
            [self.slider setMinimumValue:0.0];
            [self.slider setMaximumValue:5.0];
            filter = [GPUImageUnsharpMaskFilter new];
        }
            break;
        case GPUIMAGE_HIGHLIGHTSHADOW:
        {
            self.title = @"highlights and shadows";
            [self.slider setValue:1.0];
            [self.slider setMinimumValue:0.0];
            [self.slider setMaximumValue:1.0];
            filter = [GPUImageHighlightShadowFilter new];
        }
            break;
        case GPUIMAGE_HAZE:
        {
            self.title = @"HAZE / UV";
            [self.slider setValue:0.2];
            [self.slider setMinimumValue:-0.2];
            [self.slider setMaximumValue:0.2];
            filter = [GPUImageHazeFilter new];
        }
            break;
        case GPUIMAGE_HISTOGRAM:
        {
            self.title = @"histogram";
            [self.slider setValue:16.0];
            [self.slider setMinimumValue:4.0];
            [self.slider setMaximumValue:32.0];
            filter = [[GPUImageHistogramFilter alloc] initWithHistogramType:kGPUImageHistogramRGB];
        }
            break;
        case GPUIMAGE_THRESHOLD:
        {
            self.title = @"Luminance Threshold";
            [self.slider setMinimumValue:0.0];
            [self.slider setMaximumValue:1.0];
            [self.slider setValue:0.5];
            
            filter = [[GPUImageLuminanceThresholdFilter alloc] init];
        }
            break;
        case GPUIMAGE_ADAPTIVETHRESHOLD:
        {
            self.title = @"Adaptive Threshold";
            self.slider.hidden = NO;
            
            [self.slider setMinimumValue:1.0];
            [self.slider setMaximumValue:20.0];
            [self.slider setValue:1.0];
            
            filter = [[GPUImageAdaptiveThresholdFilter alloc] init];
        }
            break;
        case GPUIMAGE_AVERAGELUMINANCETHRESHOLD:
        {
            self.title = @"Avg. Lum. Threshold";
            self.slider.hidden = NO;
            
            [self.slider setMinimumValue:0.0];
            [self.slider setMaximumValue:2.0];
            [self.slider setValue:1.0];
            
            filter = [[GPUImageAverageLuminanceThresholdFilter alloc] init];
        }
            break;
        case GPUIMAGE_SOBELEDGEDETECTION:
        {
            self.title = @"Sobel Edge Detection";
            self.slider.hidden = NO;
            
            [self.slider setMinimumValue:0.0];
            [self.slider setMaximumValue:1.0];
            [self.slider setValue:0.25];
            
            filter = [[GPUImageSobelEdgeDetectionFilter alloc] init];
        }
            break;
        case GPUIMAGE_HARRISCORNERDETECTION:
        {
            self.title = @"Harris Corner Detection";
            self.slider.hidden = NO;
            
            [self.slider setMinimumValue:0.01];
            [self.slider setMaximumValue:0.70];
            [self.slider setValue:0.20];
            
            filter = [[GPUImageHarrisCornerDetectionFilter alloc] init];
            [(GPUImageHarrisCornerDetectionFilter *)filter setThreshold:0.20];
        }
            break;
        case GPUIMAGE_NOBLECORNERDETECTION:
        {
            self.title = @"Noble Corner Detection";
            self.slider.hidden = NO;
            
            [self.slider setMinimumValue:0.01];
            [self.slider setMaximumValue:0.70];
            [self.slider setValue:0.20];
            
            filter = [[GPUImageNobleCornerDetectionFilter alloc] init];
            [(GPUImageNobleCornerDetectionFilter *)filter setThreshold:0.20];
        }
            break;
        case GPUIMAGE_SHITOMASIFEATUREDETECTION:
        {
            self.title = @"Shi-Tomasi Feature Detection";
            self.slider.hidden = NO;
            
            [self.slider setMinimumValue:0.01];
            [self.slider setMaximumValue:0.70];
            [self.slider setValue:0.20];
            
            filter = [[GPUImageShiTomasiFeatureDetectionFilter alloc] init];
            [(GPUImageShiTomasiFeatureDetectionFilter *)filter setThreshold:0.20];
        }
            break;
        case GPUIMAGE_HOUGHTRANSFORMLINEDETECTOR:
        {
            self.title = @"Line Detection";
            self.slider.hidden = NO;
            
            [self.slider setMinimumValue:0.2];
            [self.slider setMaximumValue:1.0];
            [self.slider setValue:0.6];
            
            filter = [[GPUImageHoughTransformLineDetector alloc] init];
            [(GPUImageHoughTransformLineDetector *)filter setLineDetectionThreshold:0.60];
        }
            break;
        case GPUIMAGE_PREWITTEDGEDETECTION:
        {
            self.title = @"Prewitt Edge Detection";
            self.slider.hidden = NO;
            
            [self.slider setMinimumValue:0.0];
            [self.slider setMaximumValue:1.0];
            [self.slider setValue:1.0];
            
            filter = [[GPUImagePrewittEdgeDetectionFilter alloc] init];
        }
            break;
        case GPUIMAGE_CANNYEDGEDETECTION:
        {
            self.title = @"Canny Edge Detection";
            self.slider.hidden = NO;
            
            [self.slider setMinimumValue:0.0];
            [self.slider setMaximumValue:1.0];
            [self.slider setValue:1.0];
            
            filter = [[GPUImageCannyEdgeDetectionFilter alloc] init];
        }
            break;
        case GPUIMAGE_THRESHOLDEDGEDETECTION:
        {
            self.title = @"Threshold Edge Detection";
            self.slider.hidden = NO;
            
            [self.slider setMinimumValue:0.0];
            [self.slider setMaximumValue:1.0];
            [self.slider setValue:0.25];
            
            filter = [[GPUImageThresholdEdgeDetectionFilter alloc] init];
        }
            break;
        case GPUIMAGE_LOCALBINARYPATTERN:
        {
            self.title = @"Local Binary Pattern";
            self.slider.hidden = NO;
            
            [self.slider setMinimumValue:1.0];
            [self.slider setMaximumValue:5.0];
            [self.slider setValue:1.0];
            
            filter = [[GPUImageLocalBinaryPatternFilter alloc] init];
        }
            break;
        case GPUIMAGE_LOWPASS:
        {
            self.title = @"Low Pass";
            self.slider.hidden = NO;
            
            [self.slider setMinimumValue:0.0];
            [self.slider setMaximumValue:1.0];
            [self.slider setValue:0.5];
            
            filter = [[GPUImageLowPassFilter alloc] init];
        }
            break;
        case GPUIMAGE_HIGHPASS:
        {
            self.title = @"High Pass";
            self.slider.hidden = NO;
            
            [self.slider setMinimumValue:0.0];
            [self.slider setMaximumValue:1.0];
            [self.slider setValue:0.5];
            
            filter = [[GPUImageHighPassFilter alloc] init];
        }
            break;
        case GPUIMAGE_SKETCH:
        {
            self.title = @"Sketch";
            self.slider.hidden = NO;
            
            [self.slider setMinimumValue:0.0];
            [self.slider setMaximumValue:1.0];
            [self.slider setValue:0.25];
            
            filter = [[GPUImageSketchFilter alloc] init];
        }
            break;
        case GPUIMAGE_THRESHOLDSKETCH:
        {
            self.title = @"Threshold Sketch";
            self.slider.hidden = NO;
            
            [self.slider setMinimumValue:0.0];
            [self.slider setMaximumValue:1.0];
            [self.slider setValue:0.25];
            
            filter = [[GPUImageThresholdSketchFilter alloc] init];
        }
            break;
        case GPUIMAGE_SMOOTHTOON:
        {
            self.title = @"Smooth Toon";
            self.slider.hidden = NO;
            
            [self.slider setMinimumValue:1.0];
            [self.slider setMaximumValue:6.0];
            [self.slider setValue:1.0];
            
            filter = [[GPUImageSmoothToonFilter alloc] init];
        }
            break;
        case GPUIMAGE_EMBOSS:
        {
            self.title = @"Emboss";
            self.slider.hidden = NO;
            
            [self.slider setMinimumValue:0.0];
            [self.slider setMaximumValue:5.0];
            [self.slider setValue:1.0];
            
            filter = [[GPUImageEmbossFilter alloc] init];
        }
            break;
        case GPUIMAGE_POSTERIZE:
        {
            self.title = @"Posterize";
            self.slider.hidden = NO;
            
            [self.slider setMinimumValue:1.0];
            [self.slider setMaximumValue:20.0];
            [self.slider setValue:10.0];
            
            filter = [[GPUImagePosterizeFilter alloc] init];
        }
            break;
        case GPUIMAGE_SWIRL:
        {
            self.title = @"Swirl";
            self.slider.hidden = NO;
            
            [self.slider setMinimumValue:0.0];
            [self.slider setMaximumValue:2.0];
            [self.slider setValue:1.0];
            
            filter = [[GPUImageSwirlFilter alloc] init];
        }
            break;
        case GPUIMAGE_BULGE:
        {
            self.title = @"Bulge";
            self.slider.hidden = NO;
            
            [self.slider setMinimumValue:-1.0];
            [self.slider setMaximumValue:1.0];
            [self.slider setValue:0.5];
            
            filter = [[GPUImageBulgeDistortionFilter alloc] init];
        }
            break;
        case GPUIMAGE_SPHEREREFRACTION:
        {
            self.title = @"Sphere Refraction";
            self.slider.hidden = NO;
            
            [self.slider setMinimumValue:0.0];
            [self.slider setMaximumValue:1.0];
            [self.slider setValue:0.15];
            
            filter = [[GPUImageSphereRefractionFilter alloc] init];
            [(GPUImageSphereRefractionFilter *)filter setRadius:0.15];
        }
            break;
        case GPUIMAGE_GLASSSPHERE:
        {
            self.title = @"Glass Sphere";
            self.slider.hidden = NO;
            
            [self.slider setMinimumValue:0.0];
            [self.slider setMaximumValue:1.0];
            [self.slider setValue:0.15];
            
            filter = [[GPUImageGlassSphereFilter alloc] init];
            [(GPUImageGlassSphereFilter *)filter setRadius:0.15];
        }
            break;
        case GPUIMAGE_PINCH:
        {
            self.title = @"Pinch";
            self.slider.hidden = NO;
            
            [self.slider setMinimumValue:-2.0];
            [self.slider setMaximumValue:2.0];
            [self.slider setValue:0.5];
            
            filter = [[GPUImagePinchDistortionFilter alloc] init];
        }
            break;
        case GPUIMAGE_PERLINNOISE:
        {
            self.title = @"Perlin Noise";
            self.slider.hidden = NO;
            
            [self.slider setMinimumValue:1.0];
            [self.slider setMaximumValue:30.0];
            [self.slider setValue:8.0];
            
            filter = [[GPUImagePerlinNoiseFilter alloc] init];
        }
            break;
        case GPUIMAGE_KUWAHARA:
        {
            self.title = @"Kuwahara";
            self.slider.hidden = NO;
            
            [self.slider setMinimumValue:3.0];
            [self.slider setMaximumValue:8.0];
            [self.slider setValue:3.0];
            
            filter = [[GPUImageKuwaharaFilter alloc] init];
        }
            break;
        case GPUIMAGE_VIGNETTE:
        {
            self.title = @"Vignette";
            self.slider.hidden = NO;
            
            [self.slider setMinimumValue:0.5];
            [self.slider setMaximumValue:0.9];
            [self.slider setValue:0.75];
            
            filter = [[GPUImageVignetteFilter alloc] init];
        }
            break;
        case GPUIMAGE_GAUSSIAN:
        {
            self.title = @"Gaussian Blur";
            self.slider.hidden = NO;
            
            [self.slider setMinimumValue:0.0];
            [self.slider setMaximumValue:24.0];
            [self.slider setValue:2.0];
            
            filter = [[GPUImageGaussianBlurFilter alloc] init];
        }
            break;
        case GPUIMAGE_BOXBLUR:
        {
            self.title = @"Box Blur";
            self.slider.hidden = NO;
            
            [self.slider setMinimumValue:0.0];
            [self.slider setMaximumValue:24.0];
            [self.slider setValue:2.0];
            
            filter = [[GPUImageBoxBlurFilter alloc] init];
        }
            break;
        case GPUIMAGE_MOTIONBLUR:
        {
            self.title = @"Motion Blur";
            self.slider.hidden = NO;
            
            [self.slider setMinimumValue:0.0];
            [self.slider setMaximumValue:180.0f];
            [self.slider setValue:0.0];
            
            filter = [[GPUImageMotionBlurFilter alloc] init];
        }
            break;
        case GPUIMAGE_ZOOMBLUR:
        {
            self.title = @"Zoom Blur";
            self.slider.hidden = NO;
            
            [self.slider setMinimumValue:0.0];
            [self.slider setMaximumValue:2.5f];
            [self.slider setValue:1.0];
            
            filter = [[GPUImageZoomBlurFilter alloc] init];
        }
            break;
        case GPUIMAGE_BILATERAL:
        {
            self.title = @"Bilateral Blur";
            self.slider.hidden = NO;
            
            [self.slider setMinimumValue:0.0];
            [self.slider setMaximumValue:10.0];
            [self.slider setValue:1.0];
            
            filter = [[GPUImageBilateralFilter alloc] init];
        }
            break;
        default:
            break;
    }
}

#pragma mark --- 滑动slider的事件函数

- (void)sliderAction:(UISlider *)slider
{
    float keyValue = slider.value ;
    GPUImageFilterType type  = self.fliterType ;
    switch (type) {
        case GPUIMAGE_HALFTONE:
        {
            [(GPUImageHalftoneFilter *)filter setFractionalWidthOfAPixel:keyValue];
        }
            break;
        case GPUIMAGE_CROSSHATCH:
        {
            [(GPUImageCrosshatchFilter *)filter setCrossHatchSpacing:keyValue];
        }
            break;
        case GPUIMAGE_MONOCHROME:
        {
            [(GPUImageMonochromeFilter *)filter setIntensity:keyValue];
        }
            break;
        case GPUIMAGE_SATURATION:
        {
            [(GPUImageSaturationFilter *)filter setSaturation:keyValue];
        }
            break;
        case GPUIMAGE_LEVELS:
        {
            [(GPUImageLevelsFilter *)filter setRedMin:keyValue gamma:1.0 max:1.0 minOut:0.0 maxOut:1.0];
            [(GPUImageLevelsFilter *)filter setGreenMin:keyValue gamma:1.0 max:1.0 minOut:0.0 maxOut:1.0];
            [(GPUImageLevelsFilter *)filter setBlueMin:keyValue gamma:1.0 max:1.0 minOut:0.0 maxOut:1.0];
        }
            break;
        case GPUIMAGE_RGB:
        {
            [(GPUImageRGBFilter *)filter setGreen:keyValue];
        }
            break;
        case GPUIMAGE_HUE:
        {
            [(GPUImageHueFilter *)filter setHue:keyValue];
        }
            break;
        case GPUIMAGE_WHITEBALANCE:
        {
            [(GPUImageWhiteBalanceFilter *)filter setTemperature:keyValue];
        }
            break;
        case GPUIMAGE_SHARPEN:
        {
            [(GPUImageSharpenFilter *)filter setSharpness:keyValue];
        }
            break;
        case GPUIMAGE_UNSHARPMASK:
        {
            [(GPUImageUnsharpMaskFilter *)filter setIntensity:keyValue];
        }
            break;
        case GPUIMAGE_HIGHLIGHTSHADOW:
        {
            [(GPUImageHighlightShadowFilter *)filter setHighlights:keyValue];
        }
            break;
        case GPUIMAGE_HAZE:
        {
            [(GPUImageHazeFilter *)filter setDistance:keyValue];
        }
            break;
        case GPUIMAGE_HISTOGRAM:
        {
            [(GPUImageHistogramFilter *)filter setDownsamplingFactor:round(keyValue)];
        }
            break;
        case GPUIMAGE_THRESHOLD:
        {
            [(GPUImageLuminanceThresholdFilter *)filter setThreshold:keyValue];
        }
            break;
        case GPUIMAGE_ADAPTIVETHRESHOLD:
        {
            [(GPUImageAdaptiveThresholdFilter *)filter setBlurRadiusInPixels:keyValue];
        }
            break;
        case GPUIMAGE_AVERAGELUMINANCETHRESHOLD:
        {
            [(GPUImageAverageLuminanceThresholdFilter *)filter setThresholdMultiplier:keyValue];
        }
            break;
        case GPUIMAGE_SOBELEDGEDETECTION:
        {
            [(GPUImageSobelEdgeDetectionFilter *)filter setEdgeStrength:keyValue];
        }
            break;
        case GPUIMAGE_HARRISCORNERDETECTION:
        {
            [(GPUImageHarrisCornerDetectionFilter *)filter setThreshold:keyValue];
        }
            break;
        case GPUIMAGE_NOBLECORNERDETECTION:
        {
            [(GPUImageNobleCornerDetectionFilter *)filter setThreshold:keyValue];
        }
            break;
        case GPUIMAGE_SHITOMASIFEATUREDETECTION:
        {
            [(GPUImageShiTomasiFeatureDetectionFilter *)filter setThreshold:keyValue];
        }
            break;
        case GPUIMAGE_HOUGHTRANSFORMLINEDETECTOR:
        {
            [(GPUImageHoughTransformLineDetector *)filter setLineDetectionThreshold:keyValue];
        }
            break;
        case GPUIMAGE_PREWITTEDGEDETECTION:
        {
            [(GPUImagePrewittEdgeDetectionFilter *)filter setEdgeStrength:keyValue];
        }
            break;
        case GPUIMAGE_CANNYEDGEDETECTION:
        {
            [(GPUImageCannyEdgeDetectionFilter *)filter setBlurTexelSpacingMultiplier:keyValue];
        }
            break;
        case GPUIMAGE_THRESHOLDEDGEDETECTION:
        {
            [(GPUImageThresholdEdgeDetectionFilter *)filter setThreshold:keyValue];
        }
            break;
        case GPUIMAGE_LOCALBINARYPATTERN:
        {
            CGFloat multiplier = keyValue;
            [(GPUImageLocalBinaryPatternFilter *)filter setTexelWidth:(multiplier / self.view.bounds.size.width)];
            [(GPUImageLocalBinaryPatternFilter *)filter setTexelHeight:(multiplier / self.view.bounds.size.height)];
        }
            break;
        case GPUIMAGE_LOWPASS:
        {
            [(GPUImageLowPassFilter *)filter setFilterStrength:keyValue];
        }
            break;
        case GPUIMAGE_HIGHPASS:
        {
            [(GPUImageHighPassFilter *)filter setFilterStrength:keyValue];
        }
            break;
        case GPUIMAGE_SKETCH:
        {
            [(GPUImageSketchFilter *)filter setEdgeStrength:keyValue];
        }
            break;
        case GPUIMAGE_THRESHOLDSKETCH:
        {
            [(GPUImageThresholdSketchFilter *)filter setThreshold:keyValue];
        }
            break;
        case GPUIMAGE_SMOOTHTOON:
        {
            [(GPUImageSmoothToonFilter *)filter setBlurRadiusInPixels:keyValue];
        }
            break;
        case GPUIMAGE_EMBOSS:
        {
            [(GPUImageEmbossFilter *)filter setIntensity:keyValue];
        }
            break;
        case GPUIMAGE_POSTERIZE:
        {
            [(GPUImagePosterizeFilter *)filter setColorLevels:round(keyValue)];
        }
            break;
        case GPUIMAGE_SWIRL:
        {
            [(GPUImageSwirlFilter *)filter setAngle:keyValue];
        }
            break;
        case GPUIMAGE_BULGE:
        {
            [(GPUImageBulgeDistortionFilter *)filter setScale:keyValue];
        }
            break;
        case GPUIMAGE_SPHEREREFRACTION:
        {
            [(GPUImageSphereRefractionFilter *)filter setRadius:keyValue];
        }
            break;
        case GPUIMAGE_GLASSSPHERE:
        {
            [(GPUImageGlassSphereFilter *)filter setRadius:keyValue];
        }
            break;
        case GPUIMAGE_PINCH:
        {
            [(GPUImagePinchDistortionFilter *)filter setScale:keyValue];
        }
            break;
        case GPUIMAGE_PERLINNOISE:
        {
            [(GPUImagePerlinNoiseFilter *)filter setScale:keyValue];
        }
            break;
        case GPUIMAGE_KUWAHARA:
        {
            [(GPUImageKuwaharaFilter *)filter setRadius:round(keyValue)];
        }
            break;
        case GPUIMAGE_VIGNETTE:
        {
            [(GPUImageVignetteFilter *)filter setVignetteEnd:keyValue];
        }
            break;
        case GPUIMAGE_GAUSSIAN:
        {
            [(GPUImageGaussianBlurFilter *)filter setBlurRadiusInPixels:keyValue];
        }
            break;
        case GPUIMAGE_BOXBLUR:
        {
            [(GPUImageBoxBlurFilter *)filter setBlurRadiusInPixels:keyValue];
        }
            break;
        case GPUIMAGE_MOTIONBLUR:
        {
            [(GPUImageMotionBlurFilter *)filter setBlurAngle:keyValue];
        }
            break;
        case GPUIMAGE_ZOOMBLUR:
        {
            [(GPUImageZoomBlurFilter *)filter setBlurSize:keyValue];
        }
            break;
        case GPUIMAGE_BILATERAL:
        {
            [(GPUImageBilateralFilter *)filter setDistanceNormalizationFactor:keyValue];
        }
            break;
        default:
            break;
    }
    
    // 设置要渲染的区域
    [filter forceProcessingAtSize:_inputImage.size];
    
    // 持续对图片进行渲染
    [filter useNextFrameForImageCapture];
    
    // 获取 GPUImagePicture 数据源
    GPUImagePicture *pic = [[GPUImagePicture alloc] initWithImage:_inputImage] ;
    
    // 添加调节亮度的滤镜
    [pic addTarget:filter];
    
    // 开始渲染图片
    [pic processImage];
    
    // 获取渲染后的图片并且显示出来
    UIImage *sourceImage = [filter imageFromCurrentFramebuffer] ;
    _finalImageView.image = sourceImage ;
}

@end
