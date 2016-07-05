//
//  ViewController.m
//  GetCurrentPosition
//
//  Created by lh on 16/7/5.
//  Copyright © 2016年 lh. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

#define ALERT_MSG(msg) static UIAlertView *alert; alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];\
[alert show];\

@interface ViewController ()<CLLocationManagerDelegate>
@property (nonatomic,strong)CLLocationManager *locationManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self start];
}


-(void)start{
    
    self.title = @"后台定位";
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] > 8)
    {
        /** 请求用户权限：分为：只在前台开启定位  /在后台也可定位， */
        
        /** 只在前台开启定位 */
        //        [self.locationManager requestWhenInUseAuthorization];
        
        /** 后台也可以定位 */
        [self.locationManager requestAlwaysAuthorization];
    }
    
    if ([[UIDevice currentDevice].systemVersion floatValue] > 9)
    {
        /** iOS9新特性：将允许出现这种场景：同一app中多个location manager：一些只能在前台定位，另一些可在后台定位（并可随时禁止其后台定位）。 */
        [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    }
    
    /** 开始定位 */
    [self.locationManager startUpdatingLocation];
}
#pragma mark -  定位代理方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *loc = [locations objectAtIndex:0];
    
    NSLog(@"经纬度  %f  %f ",loc.coordinate.latitude,loc.coordinate.longitude);
    NSString *str = [NSString stringWithFormat:@"我的实时位置坐标经度%f纬度%f",loc.coordinate.latitude,loc.coordinate.longitude];
    
    ALERT_MSG(str);
    
    //    NSURLSession *session = [NSURLSession sharedSession];
    //
    //    NSURLSessionDataTask *task = [session dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://ac.ybjk.com/ua.php"]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    //        //        NSLog(@"response  %@",response);
    //
    //        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //
    //        NSLog(@"result %@",result);
    //    }];
    //
    //    [task resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
