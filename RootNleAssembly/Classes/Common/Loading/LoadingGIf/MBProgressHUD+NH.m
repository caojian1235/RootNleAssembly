//
//  MBProgressHUD+NH.m
//  YiJiYou
//
//  Created by 灵恩 on 2021/3/2.
//

#import "MBProgressHUD+NH.h"
#import "UIImage+GIF.h"
#import "YJLoadingView.h"
#import "YSKDefineMacro.h"
#import "SDWebImage.h"
@implementation MBProgressHUD (NH)

// 显示gif
+ (instancetype)showDengHUDAddedTo:(UIView *)view animated:(BOOL)animated {
  
    MBProgressHUD *hud = [[self alloc] initWithView: view];
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeCustomView;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"loading" ofType:@"gif" ];
    NSData *data = [NSData dataWithContentsOfFile:path];
    UIImage *image = [UIImage sd_imageWithData:data]; // 要配合 SDWebImage
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0 ,AUTO_MARGIN(150), AUTO_MARGIN(150))];
    YJLoadingView * loadingView = [[YJLoadingView alloc] initWithFrame:CGRectMake(view.frame.size.width/2 - AUTO_MARGIN(75) , view.frame.size.height/2 - AUTO_MARGIN(75), AUTO_MARGIN(150), AUTO_MARGIN(150))];
    [loadingView addSubview:imageView];
    imageView.image = image;
    hud.backgroundColor = UIColor.whiteColor;
    hud.customView = loadingView;
    hud.square = YES;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor clearColor];
    [view addSubview:hud];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud showAnimated:animated];
    });
   
    return hud;
}

// 隐藏
+ (BOOL)hideDengHUDForView:(UIView *)view animated:(BOOL)animated {
    MBProgressHUD *hud = [self HUDForView:view];
    if (hud != nil) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            hud.removeFromSuperViewOnHide = YES;
            [hud hideAnimated:animated];
        });
        return YES;
    }
    return NO;
}






@end
