//
//  ZSZHUD.m
//  YiJiYou
//
//  Created by 赵善志 on 2021/3/18.
//

#import "ZSZHUD.h"
#import "Category.h"
#import "YYKit.h"
@implementation ZSZHUD
+ (instancetype)shared{
    static ZSZHUD *_sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedSingleton = [[super allocWithZone:NULL] init];
    });
    return _sharedSingleton;
}
-(void)showWithLoadingString:(NSString *)loadstr andSuperView:(UIView *)sView{
    if (self.hud) {
        [self.hud removeFromSuperview];
    }
    MBProgressHUD *hud = [[MBProgressHUD alloc] init];
    hud.contentColor=[UIColor whiteColor];
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.bezelView.color = [UIColor colorWithHexString:@"#111111"];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.detailsLabel.text=loadstr;
    hud.detailsLabel.textColor=[UIColor whiteColor];
    hud.detailsLabel.font=[UIFont systemFontOfSize:14];
    hud.removeFromSuperViewOnHide = YES;

    self.hud=hud;
    [sView addSubview:hud];
    [self.hud showAnimated:YES];
}


-(void)showAlertWithString:(NSString *)alertString SuperView:(UIView *)sView completionBlock:(void (^)(void))block{
    if (self.hud) {
        [self.hud removeFromSuperview];
    }
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:sView animated:YES];
    hud.contentColor=[UIColor whiteColor];
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.mode=MBProgressHUDModeText;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor colorWithHexString:@"#111111"];//背景色
    hud.detailsLabel.text=alertString;
    hud.detailsLabel.textColor=[UIColor whiteColor];
    hud.detailsLabel.font=[UIFont systemFontOfSize:14];
    self.hud=hud;
    [self.hud hideAnimated:YES afterDelay:1.5f];
    self.hud.completionBlock = ^{
        if (block) {
            block();
        }
    };
}

-(void)showWithLoadingString:(NSString *)loadstr andSuperView:(UIView *)sView belowSubview:(UIView *)belowSubview{
    if (self.hud) {
        [self.hud removeFromSuperview];
    }
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:sView];
    hud.contentColor=[UIColor whiteColor];
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.bezelView.color = [UIColor colorWithHexString:@"#111111"];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.detailsLabel.text=loadstr;
    hud.detailsLabel.textColor=[UIColor whiteColor];
    hud.detailsLabel.font=[UIFont systemFontOfSize:14];
    hud.removeFromSuperViewOnHide = YES;
    self.hud=hud;
    [sView insertSubview:self.hud belowSubview:belowSubview];
    [self.hud showAnimated:YES];
}

-(void)HiddenHUD{
    [self.hud hideAnimated:YES];
}
@end
