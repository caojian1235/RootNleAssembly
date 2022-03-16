//
//  YKWebViewController.m
//  YiShangKe
//
//  Created by ssjt on 2021/7/21.
//

#import "YKWebViewController.h"
#import "GKNavigationBar.h"
#import "LYEmptyViewHeader.h"
#import "Masonry.h"
#import "MJRefresh.h"
#import "YSKDefineMacro.h"
#import "ZSZHUD.h"
#import "Category.h"
@interface YKWebViewController ()<WKNavigationDelegate,UIGestureRecognizerDelegate,WKScriptMessageHandler,WKUIDelegate>



@end

@implementation YKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.gk_navTitle = self.titleName;
    self.allowZoomScale = YES;
    
    [self setControlForSuper];
    [self addConstrainsForSuper];
    
   
   
    
    if (self.hideNavgationBar) {
        self.gk_navigationBar.hidden = self.hideNavgationBar;
        self.webProgress.hidden = YES;
    }
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled  = TRUE;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshWebView) name:@"loginSuccess" object:nil];
    
}

- (void)refreshWebView{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@""]
                                                                cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                            timeoutInterval:10];
    [self.webView loadRequest:request];
    [self reloadWKWebViewWithURL:self.url pathUrl:nil];
    
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    BOOL rlt = FALSE;
//    // 手势
    if (self.webView.canGoBack==YES) {
            //返回上级页面
            [self.webView goBack];
        } else {
            rlt = TRUE;
    }
    return rlt;
}

///返回按钮点击
- (void)backItemClick:(id)sender{
    NSLog(@"111");
    //判断是否能返回到H5上级页面
    if (self.webView.canGoBack == YES) {
        //返回上级页面
        [self.webView goBack];
    } else {
        //退出控制器
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)setControlForSuper {
    [self.view addSubview:self.webView];
    _webView.navigationDelegate = self;
    _webView.UIDelegate = self;
    MJWeakSelf
    LYEmptyView *emptyView = [LYEmptyView emptyActionViewWithImageStr:@"errorNetwork"
                                                               titleStr:@"无数据"
                                                              detailStr:@"网络异常!"
                                                            btnTitleStr:@"重新加载"
                                                          btnClickBlock:^{
        [weakSelf.webView reload];
    }];
      //元素竖直方向的间距
      emptyView.subViewMargin = 5.f;
      //标题颜色
      emptyView.titleLabTextColor = RGB(153, 153, 153);
      //描述字体
      emptyView.detailLabFont = [UIFont systemFontOfSize:14];
      //按钮背景色
//          emptyView.actionBtnBackGroundColor = MainColor(90, 180, 160);
      //设置空内容占位图
    _webView.ly_emptyView = emptyView;
    _webView.ly_emptyView.autoShowEmptyView = NO;
    [_webView ly_hideEmptyView];
    [self.view addSubview:self.webProgress];
    
    [self.webView addObserver:self
                   forKeyPath:@"estimatedProgress"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    [self.webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark -- AddConstrainsForSuper
- (void)addConstrainsForSuper {
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.hideNavgationBar) {
            make.top.mas_equalTo(0);
        }else{
            make.top.mas_equalTo(self.gk_navigationBar.mas_bottom);
        }
       
        make.leading.trailing.mas_equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.view.mas_bottom);
        }
    }];
    
    [self.webProgress mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.gk_navigationBar.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_offset(AUTO_MARGIN(2));
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.webProgress.progress = self.webView.estimatedProgress;
        if (self.webProgress.progress == 1) {
            /*
             *添加一个简单的动画，将webProgress的Height变为1.4倍，在开始加载网页的代理中会恢复为1.5倍
             *动画时长0.25s，延时0.3s后开始动画
             *动画结束后将webProgress隐藏
             */
            DNWeak(self)
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakself.webProgress.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                weakself.webProgress.hidden = YES;
            }];
        }
    }else if ([keyPath isEqualToString:@"canGoBack"]){
//        if (self.navigationController.viewControllers.count == 1) {
//            if (self.webView.canGoBack==YES) {
//
//                self.gk_navigationBar.backItem.hidesBackButton = NO;
//
//                } else {
//
//                    self.gk_navigationBar.backItem.hidesBackButton = YES;
//                }
//        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}



- (void)reloadWKWebViewWithURL:(NSString *)urlStr pathUrl:(NSString *)pathUrl{
    
    if (DNullStr(self.url)) {
        return;
    }
    if ([urlStr isValidUrl]) {
        
      
        NSURL        *url = [NSURL URLWithString:urlStr];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url
                                                      cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                  timeoutInterval:10];


        
        [self.webView  loadRequest:request];
        
    } else {
        
        NSString *front = [urlStr substringToIndex:5];
        if ([front containsString:@"http"] || [front containsString:@"https"]) {
            NSMutableURLRequest * requset = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
            requset.timeoutInterval = 10;
            [self.webView  loadRequest:requset];
            
        } else {
//            NSString *html = [NSString stringWithFormat:@"<html> \n" "<head> \n" "<style type=\"text/css\"> \n" "body {font-size:15px;}\n" "</style> \n" "</head> \n" "<body>" "<script type='text/javascript'>" "window.onload = function(){\n" "var $img = document.getElementsByTagName('img');\n" "for(var p in  $img){\n" " $img[p].style.width = '100%%';\n" "$img[p].style.height ='auto'\n" "}\n" "}" "</script>%@" "</body>" "</html>", urlStr];
//                    NSString *path = [[NSBundle mainBundle] bundlePath];
            NSURL    *pathUrl1  = [NSURL fileURLWithPath:urlStr];
            NSMutableURLRequest * request;
            if(pathUrl != nil){
                
                NSURL *url = [NSURL URLWithString:urlStr];
                request = [NSMutableURLRequest requestWithURL:url];
                request.timeoutInterval = 10;
                
//                request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:pathUrl relativeToURL:[NSURL fileURLWithPath:urlStr]]];
            }else{
                request.timeoutInterval = 10;
                request = [NSMutableURLRequest requestWithURL:pathUrl1];
            }
            [self.webView  loadRequest:request];
           
        }
    }
}

#pragma mark -- UITableView Delegate && DataSource
#pragma mark -- Other Delegate

//通过接收JS传出消息的name进行捕捉的回调方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    /*
     message.body: 触发js方法传的值
     message.name: 触发js的方法名
    */
    
    // 判断代理方法是否存在
    if ([self.interactiveDelegate respondsToSelector:@selector(interactiveMethod:)]) {
        [self.interactiveDelegate interactiveMethod:message];
    }
    
}
// WKWebView Delegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    DNLog(@"开始加载网页");
    self.webView.hidden = YES;
    //开始加载网页时展示出webProgress
    //self.webProgress.hidden = NO;
    //开始加载网页的时候将webProgress的Height恢复为1.5倍
    self.webProgress.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    //防止webProgress被网页挡住
    [self.view bringSubviewToFront:self.webProgress];
    [[ZSZHUD shared] showWithLoadingString:@"加载中" andSuperView:self.view];
    [_webView ly_hideEmptyView];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    DNLog(@"加载完成");
    self.webView.hidden = NO;
    
    self.allowZoomScale = NO;

    [[ZSZHUD shared] HiddenHUD];
    [_webView ly_hideEmptyView];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    DNLog(@"加载失败");
    self.webView.hidden = YES;
    [[ZSZHUD shared] HiddenHUD];
    [_webView ly_showEmptyView];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    self.webView.hidden = YES;
    DNLog(@"加载失败:%@",error);
    //加载失败同样需要隐藏webProgress
    [[ZSZHUD shared] HiddenHUD];
    [_webView ly_showEmptyView];
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

-  (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    //    DLOG(@"msg = %@ frmae = %@",message,frame);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

// 缩放
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return !self.isAllowZoomScale ? nil : self.webView.scrollView.subviews.firstObject;
}

- (void)removeWebCache {
    
    if (@available(iOS 9.0, *)) {
        
        NSSet *websiteDataTypes= [NSSet setWithArray:@[WKWebsiteDataTypeDiskCache,
                                                       //WKWebsiteDataTypeOfflineWebApplication
                                                        WKWebsiteDataTypeMemoryCache,
                                                        //WKWebsiteDataTypeLocal
                                                        WKWebsiteDataTypeCookies,
                                                        //WKWebsiteDataTypeSessionStorage,
                                                        //WKWebsiteDataTypeIndexedDBDatabases,
                                                        //WKWebsiteDataTypeWebSQLDatabases
                                                        ]];
        // All kinds of data
        // NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes
                                                   modifiedSince:dateFrom
                                               completionHandler:^{
                
        }];
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        
    }
    else {
        //先删除cookie
        NSHTTPCookie *cookie;
        NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (cookie in [storage cookies]) {
            [storage deleteCookie:cookie];
        }
        
        NSString *libraryDir = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *bundleId  =  [[[NSBundle mainBundle] infoDictionary]
                                objectForKey:@"CFBundleIdentifier"];
        NSString *webkitFolderInLib = [NSString stringWithFormat:@"%@/WebKit",libraryDir];
        NSString *webKitFolderInCaches = [NSString
                                          stringWithFormat:@"%@/Caches/%@/WebKit",libraryDir,bundleId];
        NSString *webKitFolderInCachesfs = [NSString
                                            stringWithFormat:@"%@/Caches/%@/fsCachedData",libraryDir,bundleId];
        NSError *error;
        /* iOS8.0 WebView Cache的存放路径 */
        [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCaches error:&error];
        [[NSFileManager defaultManager] removeItemAtPath:webkitFolderInLib error:nil];
        /* iOS7.0 WebView Cache的存放路径 */
        [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCachesfs error:&error];
        NSString *cookiesFolderPath = [libraryDir stringByAppendingString:@"/Cookies"];
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&error];
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
    }
}



//#pragma mark - GKGesturePopHandlerProtocol
//- (BOOL)popGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    return YES;
//}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
   
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
   
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    // 清除缓存
    [self removeWebCache];
    
    
    @try {
//            [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
        } @catch (NSException *exception) {
            NSLog(@"多次删除removeObserver -- estimatedProgress 报错了");
        } @finally {
            
        }
        
        @try {
//            [self.webView removeObserver:self forKeyPath:@"canGoBack"];
            
        } @catch (NSException *exception) {
               NSLog(@"多次删除removeObserver--canGoBack -- 报错了");
           } @finally {
               
           }
    
//    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
//    [self.webView removeObserver:self forKeyPath:@"canGoBack"];
    
    [self.webView stopLoading];
    [self.webView removeFromSuperview];
   
    self.webView = nil;
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[NSURLCache sharedURLCache] setDiskCapacity:0];
    [[NSURLCache sharedURLCache] setMemoryCapacity:0];
    DNLog(@"%@ dealloc",[self class]);
}

- (UIProgressView *)webProgress {
    
    if (!_webProgress) {
        
        _webProgress = [[UIProgressView alloc] init];
        // 设置进度条的背景颜色
        _webProgress.progressTintColor = COMMOM_GREEN_COLOR;
        
        _webProgress.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    }
    return _webProgress;
}

- (WKWebView *)webView {
    
    if (!_webView) {
        
//        NSString *jScript = @"sessionStorage.setItem('Authorize','{\"token\":\"111111\"}')";
//
//        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript
//                                                         injectionTime:WKUserScriptInjectionTimeAtDocumentStart
//                                                      forMainFrameOnly:NO];
         //这个类主要用来做native与JavaScript的交互管理
        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
        
//        [wkUController addUserScript:wkUScript];
//        [wkUController addScriptMessageHandler:self  name:@"backAction"];
//        [wkUController addScriptMessageHandler:self  name:@"payMent"];
       
        WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
//
        wkWebConfig.preferences.javaScriptEnabled = YES;
        wkWebConfig.preferences.javaScriptCanOpenWindowsAutomatically = YES;
        wkWebConfig.suppressesIncrementalRendering = YES; // 是否支持记忆读取
        //跨域问题
       [wkWebConfig.preferences setValue:@YES forKey:@"allowFileAccessFromFileURLs"];
        if (@available(iOS 10.0, *)) {
             [wkWebConfig setValue:@YES forKey:@"allowUniversalAccessFromFileURLs"];

        }
        wkWebConfig.userContentController = wkUController;
        
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:wkWebConfig];
//        _webView.allowsBackForwardNavigationGestures = YES;
        
        
        if (@available(iOS 11.0, *)) {
            _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _webView;
}

@end
