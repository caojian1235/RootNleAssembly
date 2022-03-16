//
//  DNJumpOtherMapSheet.m
//  YiJiYou
//
//  Created by 灵恩 on 2021/2/20.
//

#import "DNJumpOtherMapSheet.h"
#import <MapKit/MapKit.h>
#import "YKGetLocation.h"
@implementation DNJumpOtherMapSheet

//导航只需要目的地经纬度，endLocation为纬度、经度的数组
-(void)doNavigationWithEndLocation:(NSArray *)endLocation addressName:(NSString *)adress
{
    NSMutableArray *maps = [NSMutableArray array];
    //腾讯地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]]) {
        NSMutableDictionary *qqMapDic = [NSMutableDictionary dictionary];
        qqMapDic[@"title"] = @"腾讯地图";
        NSString *urlString = [[NSString stringWithFormat:@"qqmap://map/routeplan?from=我的位置&type=drive&tocoord=%@,%@&to=终点&coord_type=1&policy=0",endLocation[1], endLocation[0]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        qqMapDic[@"url"] = urlString;
        [maps addObject:qqMapDic];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{} completionHandler:nil];
        return;
    }
    //高德地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        NSMutableDictionary *gaodeMapDic = [NSMutableDictionary dictionary];
        gaodeMapDic[@"title"] = @"高德地图";
        
        YKGetLocation * location = [YKGetLocation shareInstance];
        
        NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=applicationName&sid=BGVIS1&slat=%f&slon=%f&sname=%@&did=BGVIS2&dlat=%@&dlon=%@&dname=%@&dev=0&m=0&t=0",location.latitude,location.longitude,@"我的位置",endLocation[1],endLocation[0],adress] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        gaodeMapDic[@"url"] = urlString;
        [maps addObject:gaodeMapDic];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{} completionHandler:nil];
        return;
    }
    //百度地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        NSMutableDictionary *baiduMapDic = [NSMutableDictionary dictionary];
        baiduMapDic[@"title"] = @"百度地图";
        NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=目的地&mode=driving&coord_type=gcj02",[endLocation[1] floatValue],[endLocation[0] floatValue]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        baiduMapDic[@"url"] = urlString;
        NSLog(@"%@+++++",urlString);
        [maps addObject:baiduMapDic];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{} completionHandler:nil];
        return;
    }
    //苹果原生地图-苹果原生地图方法和其他不一样
    NSMutableDictionary *iosMapDic = [NSMutableDictionary dictionary];
    iosMapDic[@"title"] = @"苹果地图";
    [maps addObject:iosMapDic];
    [self navAppleMap:endLocation[1] endLatitude:endLocation[0] addressName:adress];
}
//苹果地图
- (void)navAppleMap:(NSString *)endLongitude endLatitude:(NSString *)endLatitude addressName:(NSString *)address
{
    //终点坐标
    CLLocationCoordinate2D loc = CLLocationCoordinate2DMake([endLongitude floatValue], [endLatitude floatValue]);
    //用户位置
    MKMapItem *currentLoc = [MKMapItem mapItemForCurrentLocation];
    //终点位置
    MKMapItem *toLocation = [[MKMapItem alloc]initWithPlacemark:[[MKPlacemark alloc]initWithCoordinate:loc addressDictionary:nil] ];
    
    toLocation.name = address;
    
    
    NSArray *items = @[currentLoc,toLocation];
    //第一个
    NSDictionary *dic = @{
                          MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving,
                          MKLaunchOptionsMapTypeKey : @(MKMapTypeStandard),
                          MKLaunchOptionsShowsTrafficKey : @(YES)
                          };
    [MKMapItem openMapsWithItems:items launchOptions:dic];
}

@end
