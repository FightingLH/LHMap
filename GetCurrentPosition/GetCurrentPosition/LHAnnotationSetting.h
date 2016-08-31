//
//  LHAnnotationSetting.h
//  GetCurrentPosition
//
//  Created by lh on 16/8/31.
//  Copyright © 2016年 lh. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DXCalloutAnimation) {
    DXCalloutAnimationNone,
    DXCalloutAnimationFadeIn,
    DXCalloutAnimationZoomIn
};

@interface LHAnnotationSetting : NSObject

@property(nonatomic, assign) CGFloat calloutOffset;

@property(nonatomic, assign) BOOL shouldRoundifyCallout;
@property(nonatomic, assign) CGFloat calloutCornerRadius;

@property(nonatomic, assign) BOOL shouldAddCalloutBorder;
@property(nonatomic, strong) UIColor *calloutBorderColor;
@property(nonatomic, assign) CGFloat calloutBorderWidth;

@property(nonatomic, assign) DXCalloutAnimation animationType;
@property(nonatomic, assign) NSTimeInterval animationDuration;

+ (instancetype)defaultSettings;
@end
