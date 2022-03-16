//
//  SYBAlertView.h
//  CashierChoke
//
//  Created by zjs on 2019/8/21.
//  Copyright © 2019 zjs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYBAlertView : UIView

@property (nonatomic,   copy) void(^cancelBlock)(void);
@property (nonatomic,   copy) void(^confirmBlock)(void);

/* 标题 */
@property (nonatomic,   copy) NSString *title;
/* 描述 */
@property (nonatomic,   copy) NSString *message;
/* 取消按钮title */
@property (nonatomic,   copy) NSString *cancleTitle;
/* 确定按钮title */
@property (nonatomic,   copy) NSString *confirmTitle;
/* 标题字体颜色 */
@property (nonatomic, strong) UIColor *titleColor;
/* 描述字体颜色 */
@property (nonatomic, strong) UIColor *messageColor;
/* 取消按钮title字体颜色 */
@property (nonatomic, strong) UIColor *cancelTitleColor;
/* 确定按钮title字体颜色 */
@property (nonatomic, strong) UIColor *confirmTitleColor;
/* 确定按钮背景颜色 */
@property (nonatomic, strong) UIColor *confirmBackgroundColor;

/* 隐藏取消按钮 */
@property (nonatomic, assign) BOOL hideCancelBtn;

/* 隐藏取消按钮 */
@property (nonatomic, assign) BOOL isShow;

/* 显示alertView */
- (void)showAlertView;

+ (instancetype)shareInstance;
@end

NS_ASSUME_NONNULL_END
