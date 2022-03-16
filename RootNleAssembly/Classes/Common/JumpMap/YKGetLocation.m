//
//  YKGetLocation.m
//  YiShangKe
//
//  Created by ssjt on 2021/8/23.
//

#import "YKGetLocation.h"
@interface YKGetLocation ()

@property (nonatomic , strong) AMapLocationManager           *locationManager;



@end

@implementation YKGetLocation

static YKGetLocation *location = nil;

+ (instancetype)shareInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!location) {
            location = [[self alloc] init];
        }
    });
    return location;
}

- (void)startLocationBlock:(void(^)(CLLocation *location, AMapLocationReGeocode *regeocode))success{
    
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
            
            if (error)
            {
                NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
                
                if (error.code == AMapLocationErrorLocateFailed)
                {
                    return;
                }
            }
        
        
        CLLocationDegrees latitude = location.coordinate.latitude;
        CLLocationDegrees longitude = location.coordinate.longitude;
        
        self.latitude  = latitude;
        self.longitude = longitude;
        if ([regeocode.city containsString:@"市"]) {
            self.cityName =  [regeocode.city stringByReplacingOccurrencesOfString:@"市" withString:@""];
            
        }else{
            self.cityName =  regeocode.city;
            
        }
        
        self.address = regeocode.formattedAddress;
        
        success?success(location,regeocode):nil;
        
        NSLog(@"location:%@", location);
            
           
        }];
}

- (AMapLocationManager *)locationManager{
    
    if (!_locationManager) {
        _locationManager = [[AMapLocationManager alloc] init];
        //   定位超时时间，最低2s，此处设置为2s
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.locationTimeout =2;
        //   逆地理请求超时时间，最低2s，此处设置为2s
        _locationManager.reGeocodeTimeout = 2;
    }
    return _locationManager;
}

@end
