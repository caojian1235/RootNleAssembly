//
//  YKBaseViewController.m
//  YiShangKe
//
//  Created by ssjt on 2021/6/3.
//

#import "YKBaseViewController.h"
#import "YSKDefineMacro.h"
#import "MJRefresh.h"
#import "SYBAlertView.h"
#import "DXManagerLoadingViewModel.h"
#import "ReactiveObjC.h"
#import "GKNavigationBar.h"
#import "Toast.h"
@interface YKBaseViewController ()

@property (nonatomic , strong) DXManagerLoadingViewModel * loadingViewModel;

@property (nonatomic , strong) RACDisposable *loadingHandler;

@property (nonatomic , strong) RACDisposable *showMessageHandler;

@property (nonatomic , strong) RACDisposable *isRefreshHandler;

@property (nonatomic , strong) RACDisposable *refreshHandler;

@property (nonatomic , strong) RACDisposable *refreshRequestHandler;

@end

@implementation YKBaseViewController

- (BOOL)showIsLogin:(id)userInfo{
    
    if (userInfo != nil) {
       
        return YES;
    }else{
        return NO;
    }
}

- (void)alertLoginShow:(void(^)(void))successClick userInfo:(id)userInfo{
    
    if (userInfo != nil) {
        successClick?successClick():nil;
        return;
    }
    
    SYBAlertView *alertView = [[SYBAlertView alloc] init];
    alertView.title   = @"温馨提示";
    alertView.message = @"需要登录后再使用";
    alertView.confirmTitle = @"确定";
    alertView.confirmBlock = successClick;
    [alertView showAlertView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    self.gk_navigationBar.layer.zPosition = 100;
    self.gk_navigationBar.hidden          = YES;
    if (@available(iOS 13.0, *)) {
        self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    } else {
        
    }
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self bindPublickRAC];
    
}

- (void)bindPublickRAC{
    
    if (self.loadingHandler == nil || self.showMessageHandler == nil) {
        MJWeakSelf
        
        self.loadingHandler = [[RACObserve([DXManagerLoadingViewModel shareInstance], isLoading) takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
            
         
            
            if ([x boolValue] == YES) {
                ///加载动画显示
//                weakSelf.contentView.hidden = NO;
//                weakSelf.contentView.layer.zPosition = 10;
//
//                if ([DXManagerLoadingViewModel shareInstance].isRefresh == NO) {
//
//                    weakSelf.loadingView = [GKBallLoadingView loadingViewInView:strongSelf.contentView];
//                    weakSelf.loadingView.layer.zPosition = 11;
//                    weakSelf.loadingView.backgroundColor = DXManagerLoadingViewModel.shareInstance.loadingColor?:UIColor.whiteColor;
////                    loadingView.backgroundColor = colorHex(@"#08081D");
//                    [weakSelf.loadingView startLoading];
//                }else{
//
//                    [[ZSZHUD shared] showWithLoadingString:@"加载中" andSuperView:weakSelf.view];
//                }
            }else{
                //加载动画隐藏
//
//                if (weakSelf.loadingView) {
//                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//                        [weakSelf.loadingView stopLoading];
//                        [weakSelf.loadingView removeFromSuperview];
//
//                        weakSelf.loadingView = nil;
//                        weakSelf.contentView.hidden = YES;
//
//                    });
//                }else{
//                    [[ZSZHUD shared] HiddenHUD];
//                    weakSelf.contentView.hidden = YES;
//                }
//
                
                    
              
               
            }
        }];
        
        self.showMessageHandler = [[RACObserve([DXManagerLoadingViewModel shareInstance], showMessage)  takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
           
        
            
            if (!DNullStr(x)) {
                
                [weakSelf.view makeToast:x duration:2.0 position:CSToastPositionCenter];
                [DXManagerLoadingViewModel shareInstance].showMessage = @"";
            }
           
        }];
        
        self.refreshHandler = [[[[DXManagerLoadingViewModel shareInstance] refreshUISubject] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
            
            NSLog(@"refresh");
            
            
            [weakSelf refreshUI];
            
        }];
    
    self.refreshRequestHandler = [[[[DXManagerLoadingViewModel shareInstance] refreshRequestSubeject ] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
       
        
        
        [weakSelf refreshRequestUI];
        
        
    }];
    }
    
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tokenChange) name:@"tokenChange" object:nil];
    
    [DXManagerLoadingViewModel shareInstance].isLoading = NO;
    [DXManagerLoadingViewModel shareInstance].showMessage = @"";
    [DXManagerLoadingViewModel shareInstance].isRefresh  = NO;
    
    [self bindPublickRAC];
    
    
    
}

- (void)refreshRequestUI{
    
    
}

- (void)refreshUI{
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"tokenChange" object:nil];
    
    [self.loadingHandler dispose];
    [self.showMessageHandler dispose];
    [self.refreshHandler dispose];
    [self.isRefreshHandler dispose];
    [self.refreshRequestHandler dispose];
    
    self.loadingHandler = nil;
    self.showMessageHandler = nil;
    self.refreshHandler = nil;
    self.isRefreshHandler = nil;
    self.refreshRequestHandler = nil;
}


- (void)tokenChange{
    
    
}





- (UIView *)contentView{
    
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.backgroundColor = UIColor.clearColor;
        [self.view addSubview:_contentView];
        _contentView.frame = self.view.bounds;
    }
    return _contentView;
    
}


- (DXManagerLoadingViewModel *)loadingViewModel{
    
    if (!_loadingViewModel) {
        _loadingViewModel = [DXManagerLoadingViewModel shareInstance];
    }
    return _loadingViewModel;
    
}











@end
