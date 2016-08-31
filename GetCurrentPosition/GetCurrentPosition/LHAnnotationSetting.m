//
//  LHAnnotationSetting.m
//  GetCurrentPosition
//
//  Created by lh on 16/8/31.
//  Copyright © 2016年 lh. All rights reserved.
//

#import "LHAnnotationSetting.h"

@implementation LHAnnotationSetting
+ (instancetype)defaultSettings {
    LHAnnotationSetting *newSettings = [[super alloc] init];
    if (newSettings) {
        newSettings.calloutOffset = 10.0f;
        
        newSettings.shouldRoundifyCallout = YES;
        newSettings.calloutCornerRadius = 5.0f;
        
        newSettings.shouldAddCalloutBorder = YES;
        newSettings.calloutBorderColor = [UIColor colorWithRed:0.329 green:0.565 blue:0.616 alpha:1.000];
        newSettings.calloutBorderWidth = 2.0;
        
        newSettings.animationType = DXCalloutAnimationZoomIn;
        newSettings.animationDuration = 0.25;
    }
    return newSettings;
}

@end
