//
//  ViewController.m
//  RXQCoreLocation
//
//  Created by Shevchenko on 2018/6/2.
//  Copyright © 2018年 Shevchenko. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (strong, nonatomic) CLLocationManager *locManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _locManager = [[CLLocationManager alloc] init];
    
    _locManager.delegate = self;
    
    _locManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [_locManager requestAlwaysAuthorization];
    
    _locManager.distanceFilter =  100;
    
    [_locManager startUpdatingLocation];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate {
    return true;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *loc = [locations firstObject];
    float longitude = loc.coordinate.longitude;
    float latitude = loc.coordinate.latitude;
    self.label1.text = [NSString stringWithFormat:@"%f",longitude];
    self.label2.text = [NSString stringWithFormat:@"%f",latitude];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSString *errorMsg = nil;
    if ([error code] == kCLErrorDenied) {
        errorMsg = @"访问被拒绝";
    }
    if ([error code] == kCLErrorLocationUnknown) {
        errorMsg = @"获取位置信息失败";
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Location" message:errorMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}


@end
