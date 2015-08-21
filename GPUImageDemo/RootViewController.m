//
//  RootViewController.m
//  GPUImageDemo
//
//  Created by huyang on 15/7/10.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "RootViewController.h"
#import "ViewController.h"
#import <Foundation/Foundation.h>


@interface RootViewController ()<UIActionSheetDelegate>

@property(strong,nonatomic)UIActionSheet *actionSheet ;
@property(strong,nonatomic)UIImage       *selectedImage;
@property(strong,nonatomic)UIButton      *next ;
@property(nonatomic)UIControl *dragCircleView ;

- (void)addDragCircleView ;
- (void)touchDown:(UIControl *)sender ;
- (void)handlePan:(UIPanGestureRecognizer *)recognizer ;


@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"home";
    self.view.backgroundColor = [UIColor whiteColor];
    [self addDragCircleView];

    UIButton *list = [UIButton buttonWithType:UIButtonTypeCustom];
    list.layer.masksToBounds = YES ;
    list.layer.cornerRadius = 5.f ;
    list.titleLabel.font = [UIFont systemFontOfSize:22.f];
    list.frame = CGRectMake(20, KFullHeight-60, KFullWidth-40, 50);
    [list setTitle:@"赶紧去看看吧" forState:UIControlStateNormal];
    [list setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [list setBackgroundColor:[UIColor colorWithRed:52/255.f green:152/255.f blue:219/255.f alpha:1.f]];
    [list  addTarget:self action:@selector(goToFilterList) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:list];
//    [self attributeStringTest];
}

- (void)attributeStringTest
{
    NSString *content = @"somehow it doesn't give me the correct height.\nI think the method is buggy.\nIf I run the following code, it gives me bounding size: 572.324951, 19.000000 ignoring the given width of 200. It should give me something like 100 of height.";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:5];
    [style setParagraphSpacing:10.f];
    [style setAlignment:NSTextAlignmentLeft];
    [attributedString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.f],
                                      NSForegroundColorAttributeName:[UIColor blueColor],
                                      NSParagraphStyleAttributeName:style} range:NSMakeRange(0, content.length)];
    CGRect rect = [attributedString boundingRectWithSize:CGSizeMake(KFullWidth-40.f, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, KFullWidth - 40.f, rect.size.height)];
    testLabel.numberOfLines = 0 ;
    testLabel.backgroundColor = [UIColor cyanColor];
    testLabel.attributedText = attributedString ;
    [self.view addSubview:testLabel];
}

#pragma mark - POPAnimationDelegate

- (void)pop_animationDidApply:(POPDecayAnimation *)anim
{
    BOOL isDragViewOutsideOfSuperView = !CGRectContainsRect(self.view.frame, self.dragCircleView.frame);
    if (isDragViewOutsideOfSuperView) {
        CGPoint currentVelocity = [anim.velocity CGPointValue];
        CGPoint velocity = CGPointMake(currentVelocity.x, -currentVelocity.y);
        POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
        positionAnimation.velocity = [NSValue valueWithCGPoint:velocity];
        positionAnimation.toValue = [NSValue valueWithCGPoint:self.view.center];
        [self.dragCircleView.layer pop_addAnimation:positionAnimation forKey:@"layerPositionAnimation"];
    }
}

#pragma mark - Private Instance methods

- (void)addDragCircleView
{
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(handlePan:)];
    
    self.dragCircleView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    self.dragCircleView.center = self.view.center;
    self.dragCircleView.layer.cornerRadius = CGRectGetWidth(self.dragCircleView.bounds)/2;
    self.dragCircleView.backgroundColor = [UIColor cyanColor];
    [self.dragCircleView addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
    [self.dragCircleView addGestureRecognizer:recognizer];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 110, 60)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:18.f];
    titleLabel.textColor = [UIColor blueColor];
    titleLabel.numberOfLines = 0 ;
    NSString *content = @"让你的照片更酷炫" ;
    NSMutableAttributedString * attriString = [[NSMutableAttributedString alloc]initWithString:content];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:5];
    [style setAlignment:NSTextAlignmentCenter];
    [attriString setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.f],
                                 NSForegroundColorAttributeName:[UIColor blueColor],NSParagraphStyleAttributeName:style} range:NSMakeRange(0, content.length)];
    titleLabel.attributedText = attriString ;
    [self.dragCircleView addSubview:titleLabel];
    
    [self.view addSubview:self.dragCircleView];
}

- (void)touchDown:(UIControl *)sender
{
    [sender.layer pop_removeAllAnimations];
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
    if(recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [recognizer velocityInView:self.view];
        POPDecayAnimation *positionAnimation = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPosition];
        positionAnimation.delegate = self;
        positionAnimation.velocity = [NSValue valueWithCGPoint:velocity];
        [recognizer.view.layer pop_addAnimation:positionAnimation forKey:@"layerPositionAnimation"];
    }
}


- (void)goToFilterList
{
    ViewController *vc = [ViewController new];
    vc.title = @"Filter List";
    [self.navigationController pushViewController:vc animated:YES];
}

@end
