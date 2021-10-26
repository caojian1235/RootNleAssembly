//
//  YKWebViewController.h
//  YiShangKe
//
//  Created by ssjt on 2021/7/21.
//

#import "YKBaseViewController.h"
#import <WebKit/WebKit.h>
@protocol WebViewInteractiveDelegate <NSObject>// 一般用控制器名+Delegate命名

- (void)interactiveMethod:(WKScriptMessage *_Nullable)message;

@end
NS_ASSUME_NONNULL_BEGIN

@interface YKWebViewController : YKBaseViewController

@property (nonatomic, assign, getter=isAllowZoomScale) BOOL allowZoomScale;

@property (nonatomic, strong) UIProgressView *webProgress;

@property (nonatomic, strong) WKWebView *webView;

///代理交互事件
/*
 message.body: 触发js方法传的值
 message.name: 触发js的方法名
*/
@property (nonatomic , weak)  id<WebViewInteractiveDelegate> interactiveDelegate;

@property (nonatomic , copy)  NSString * url;

@property (nonatomic , copy)  NSString * articleID;

@property (nonatomic , copy)  NSString * articleDetail;
///医护风采ID
@property (nonatomic , copy)  NSString * medicalStyleID;

@property (nonatomic , copy)  NSString * titleName;

@property (nonatomic , assign) BOOL hideNavgationBar;


@end

NS_ASSUME_NONNULL_END
