//
//  YKBaseViewController.h
//  YiShangKe
//
//  Created by ssjt on 2021/6/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YKBaseViewController : UIViewController
///验证是否登陆
- (BOOL)showIsLogin:(id)userInfo;

///刷新UI
- (void)refreshUI;
///刷新请求
- (void)refreshRequestUI;
///loading 加载view
@property (nonatomic , strong) UIView * contentView;

///显示是否登陆
- (void)alertLoginShow:(void(^)(void))successClick userInfo:(id)userInfo;
///登录成功回调
@property (strong , nonatomic) void(^loginSuccessCallBack)(void);

@end

NS_ASSUME_NONNULL_END
