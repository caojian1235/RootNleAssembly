//
//  MBProgressHUD+NH.h
//  YiJiYou
//
//  Created by 灵恩 on 2021/3/2.
//

#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (NH)

//加载动图
+ (instancetype)showDengHUDAddedTo:(UIView *)view animated:(BOOL)animated;

/**

*  快速从window中隐藏ProgressView

*/
// 隐藏
+ (BOOL)hideDengHUDForView:(UIView *)view animated:(BOOL)animated;


@end

NS_ASSUME_NONNULL_END
