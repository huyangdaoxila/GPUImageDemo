//
//  UIColor+CustomColor.m
//  Masonry_cpmplexCellDemo
//
//  Created by huyang on 15/6/19.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "UIColor+CustomColor.h"

@implementation UIColor (CustomColor)

#pragma mark - Public class methods

+ (UIColor *)KGrayColor
{
    return [self colorWithRed:84 green:84 blue:84];
}

+ (UIColor *)KRedColor
{
    return [self colorWithRed:231 green:76 blue:60];
}

+ (UIColor *)KYellowColor
{
    return [self colorWithRed:241 green:196 blue:15];
}

+ (UIColor *)KGreenColor
{
    return [self colorWithRed:46 green:204 blue:113];
}

+ (UIColor *)KBlueColor
{
    return [self colorWithRed:52 green:152 blue:219];
}

+ (UIColor *)KSunsetColor
{
    return [self colorWithRed:254 green:200 blue:118];
}

+ (UIColor *)KLightBlueColor
{
    return [self colorWithRed:124 green:212 blue:249];
}

+ (UIColor *)KLightPurpleColor
{
    return [self colorWithRed:172 green:142 blue:250];
}

+ (UIColor *)KLightGreenColor
{
    return [self colorWithRed:147 green:248 blue:176];
}

+ (UIColor *)KWeiBoPlus
{
    return [self colorWithRed:240 green:240 blue:240];
}

+ (UIColor *)KRandomColor
{
    return [self colorWithRed:arc4random()%256 green:arc4random()%256 blue:arc4random()%256] ;
}



+ (UIColor *)colorWithRed:(NSUInteger)red
                    green:(NSUInteger)green
                     blue:(NSUInteger)blue
{
    return [UIColor colorWithRed:(float)(red/255.f)
                           green:(float)(green/255.f)
                            blue:(float)(blue/255.f)
                           alpha:1.f];
}

@end
