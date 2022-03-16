//
//  ZSZHUD.h
//  YiJiYou
//
//  Created by 赵善志 on 2021/3/18.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
@interface ZSZHUD : NSObject

@property(nonatomic,weak)MBProgressHUD   *hud;

+(instancetype)shared;

-(void)showWithLoadingString:(NSString *)loadstr andSuperView:(UIView *)sView;

-(void)showWithLoadingString:(NSString *)loadstr andSuperView:(UIView *)sView belowSubview:(UIView *)belowSubview;

-(void)showAlertWithString:(NSString *)alertString SuperView:(UIView *)sView completionBlock:(void (^)(void))block;

-(void)HiddenHUD;



@end


