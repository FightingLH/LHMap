//
//  ViewController01.m
//  GetCurrentPosition
//
//  Created by lh on 16/8/29.
//  Copyright © 2016年 lh. All rights reserved.
//

#import "ViewController01.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "LHAnnotationView.h"
#import "LHAnnotationSetting.h"
#import "LHDrawView.h"
@interface VZTHotelAnnotation : NSObject <MKAnnotation>
@property(nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic,assign) NSInteger annotationType;
@end

@implementation VZTHotelAnnotation
- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate {
    self = [super init];
    if (self) {
        self.coordinate  = coordinate;
    }
    return self;
}
@end
@interface ViewController01 () <MKMapViewDelegate,CLLocationManagerDelegate>
@property (nonatomic,strong) MKMapView *mapView;

@end

@implementation ViewController01
- (MKMapView *)mapView
{
    if (!_mapView) {
        MKMapView *mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
        mapView.delegate = self;
        [self.view addSubview:mapView];
        //经纬度
        CLLocationCoordinate2D coordinate2D = {31.859942,117.2882028929};
        //比例尺
        MKCoordinateSpan span = {.01,.01};
        //        mapView.scrollEnabled = NO;
        //        mapView.zoomEnabled = NO;
        //        mapView.showsBuildings = YES;
        MKCoordinateRegion region = MKCoordinateRegionMake(coordinate2D, span);
        [mapView setRegion:region];
        _mapView = mapView;
    }
    return _mapView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"路线规划";
    self.view.backgroundColor = [UIColor whiteColor];
    [self mapView];
    [self drawLine];
}

- (void)drawLine
{
    //起点和终点的经纬度
    CLLocationCoordinate2D start = {32.864942016,117.2882028929};
    CLLocationCoordinate2D end = {31.854942016,117.2882028929};
    //起点终点的详细信息
    MKPlacemark *startPlace = [[MKPlacemark alloc]initWithCoordinate:start addressDictionary:nil];
    MKPlacemark *endPlace = [[MKPlacemark alloc]initWithCoordinate:end addressDictionary:nil];
    //起点 终点的 节点
    MKMapItem *startItem = [[MKMapItem alloc]initWithPlacemark:startPlace];
    MKMapItem *endItem = [[MKMapItem alloc]initWithPlacemark:endPlace];
    //路线请求
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc]init];
    request.source = startItem;
    request.destination = endItem;
    //选择什么方式
    request.transportType = MKDirectionsTransportTypeWalking;
    //发送请求
    MKDirections *directions = [[MKDirections alloc]initWithRequest:request];
    __block NSInteger sumDistance = 0;
    //计算
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        NSLog(@"%@",response.routes);
        if (!error) {
            //取出一条路线
            MKRoute *route = response.routes[0];
            for (int i = 0; i<route.steps.count; i++) {
                MKRouteStep *step = route.steps[i];
                NSLog(@"%f----%f",step.polyline.coordinate.latitude,step.polyline.coordinate.longitude);
                if (i == 0) {
                    VZTHotelAnnotation *annotation = [[VZTHotelAnnotation alloc]init];
                    annotation.annotationType = 1;
                    annotation.coordinate = step.polyline.coordinate;
                    //添加大头针
                    [self.mapView addAnnotation:annotation];
                }else if(i == route.steps.count-1){
                    VZTHotelAnnotation *annotation = [[VZTHotelAnnotation alloc]init];
                    annotation.annotationType = 2;
                    annotation.coordinate = step.polyline.coordinate;
                    //添加大头针
                    [self.mapView addAnnotation:annotation];
                }
                //添加路线
                [self.mapView addOverlay:step.polyline];
                //距离
                sumDistance += step.distance;
            }
            //
            NSLog(@"总距离 %ld",(long)sumDistance);
            [self setRegionForDepAndArr:start Arr:end];//将起始点和终点显示在地图上
        }
    }];
}
#pragma mark -将地图标注显示在整个界面上
- (void)setRegionForDepAndArr:(CLLocationCoordinate2D)depcoo Arr:(CLLocationCoordinate2D)arrcoo {
    MKMapRect zoomRect = MKMapRectNull;
    for (id <MKAnnotation> annotation in self.mapView.annotations) {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        if (MKMapRectIsNull(zoomRect)) {
            zoomRect = pointRect;
        } else {
            zoomRect = MKMapRectUnion(zoomRect, pointRect);
        }
    }
    zoomRect = [self.mapView mapRectThatFits:zoomRect];
    [self.mapView setVisibleMapRect:zoomRect edgePadding:UIEdgeInsetsMake(30, 30, 15, 30) animated:NO];
}

#pragma  mark - 添加覆盖物
-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    //绘制线条
    if ([overlay isKindOfClass:[MKPolyline class]])
    {
        MKPolylineRenderer *polylineRender = [[MKPolylineRenderer alloc]initWithPolyline:overlay];
        polylineRender.strokeColor = [UIColor redColor];
        polylineRender.lineWidth = 2;
        return polylineRender;
        
    }
    return nil;
}
#pragma mark -绘制view
#pragma mark mapview delegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[VZTHotelAnnotation class]]){
        
        VZTHotelAnnotation *an = annotation;
        
        UIImageView *pinView = nil;
        UIView *calloutView = nil;
        LHAnnotationView *annotationView = (LHAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:NSStringFromClass([LHAnnotationView class])];
        //  annotationView.canShowCallout = YES;
        if (!annotationView) {
            pinView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"定位"]];
            pinView.frame = CGRectMake(0, 0, 18.5, 25.5);
            calloutView = [[LHDrawView alloc] initWithFrame:CGRectMake(0, 0, 80, 35)];
            calloutView.backgroundColor = [UIColor clearColor];
            if (an.annotationType == 1) {//第一个annotation
                UILabel *title = [[UILabel alloc]init];
                title.frame = CGRectMake(10, 10, 60, 15);
                title.text = @"hi";
                title.textAlignment = NSTextAlignmentCenter;
                [calloutView addSubview:title];
            }else{//第二个annotation
                UILabel *title = [[UILabel alloc]init];
                title.frame = CGRectMake(10, 10, 60, 15);
                title.textAlignment = NSTextAlignmentCenter;
                title.text = @"hello";
                [calloutView addSubview:title];
            }
            annotationView = [[LHAnnotationView alloc] initWithAnnotation:annotation
                                                                reuseIdentifier:NSStringFromClass([LHAnnotationView class])
                                                                        pinView:pinView
                                                                    calloutView:calloutView
                                                                       settings:[LHAnnotationSetting defaultSettings]];
            if(an.annotationType == 1){
                annotationView.anViewType = 3;
            }else{
                annotationView.anViewType = 4;
            }
            [annotationView showCalloutView];
        }else {
            [annotationView showCalloutView];
            pinView = (UIImageView *)annotationView.pinView;
            pinView.image = [UIImage imageNamed:@"定位"];
        }
        return annotationView;
    }
    return nil;
}


- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    if ([view isKindOfClass:[LHAnnotationView class]]) {
        LHAnnotationView *vs = (LHAnnotationView *)view;
        if (vs.anViewType == 3) {
            [((LHAnnotationView *)view)hideCalloutView];
            view.layer.zPosition = -1;
        }else{
            [((LHAnnotationView *)view)showCalloutView];
            view.layer.zPosition = 0;
        }
        if (vs.anViewType == 4) {
            [((LHAnnotationView *)view)hideCalloutView];
            view.layer.zPosition = -1;
        }else{
            [((LHAnnotationView *)view)showCalloutView];
            view.layer.zPosition = 0;
        }
    }
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view isKindOfClass:[LHAnnotationView class]]) {
        LHAnnotationView *vs = (LHAnnotationView *)view;
        if (vs.anViewType == 3) {
            [((LHAnnotationView *)view)showCalloutView];
            view.layer.zPosition = 0;
        }else{
            [((LHAnnotationView *)view)hideCalloutView];
            view.layer.zPosition = -1;
        }
        if (vs.anViewType == 4) {
            [((LHAnnotationView *)view)showCalloutView];
            view.layer.zPosition = 0;
        }else{
            [((LHAnnotationView *)view)hideCalloutView];
            view.layer.zPosition = -1;
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
