//
//  LHAnnotationView.h
//  GetCurrentPosition
//
//  Created by lh on 16/8/31.
//  Copyright © 2016年 lh. All rights reserved.
//

#import <MapKit/MapKit.h>
@class LHAnnotationSetting;
@interface LHAnnotationView : MKAnnotationView
@property(nonatomic, strong) UIView *pinView;
@property(nonatomic, strong) UIView *calloutView;
@property (nonatomic,assign) NSInteger anViewType;//隐藏类型
- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation
                   reuseIdentifier:(NSString *)reuseIdentifier
                           pinView:(UIView *)pinView
                       calloutView:(UIView *)calloutView
                          settings:(LHAnnotationSetting *)settings;
- (void)hideCalloutView;
- (void)showCalloutView;

@end
