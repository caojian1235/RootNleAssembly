//
//  YKGetLocation.h
//  YiShangKe
//
//  Created by ssjt on 2021/8/23.
//

#import <Foundation/Foundation.h>
#import "AMapFoundationKit.h"
#import "AMapLocationKit.h"


NS_ASSUME_NONNULL_BEGIN

@interface YKGetLocation : NSObject

@property (nonatomic , strong) NSString *cityID;

@property (nonatomic , assign) CLLocationDegrees latitude;

@property (nonatomic , assign) CLLocationDegrees longitude;

@property (nonatomic , strong) NSString *cityName;

@property (nonatomic , strong) NSString *address;

- (void)startLocationBlock:( void(^)( CLLocation * location,AMapLocationReGeocode * regeocode) )success;
+ (instancetype)shareInstance;

@end

NS_ASSUME_NONNULL_END
