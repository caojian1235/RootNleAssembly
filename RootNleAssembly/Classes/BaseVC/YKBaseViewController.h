//
//  YKBaseViewController.h
//  YiShangKe
//
//  Created by ssjt on 2021/6/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YKBaseViewController : UIViewController

- (BOOL)showIsLogin:(id)userInfo;

///显示是否登陆
- (void)alertLoginShow:(void(^)(void))successClick userInfo:(id)userInfo;
///登录成功回调
@property (strong , nonatomic) void(^loginSuccessCallBack)(void);

@end

NS_ASSUME_NONNULL_END
