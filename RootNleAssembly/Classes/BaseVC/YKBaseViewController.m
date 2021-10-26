//
//  YKBaseViewController.m
//  YiShangKe
//
//  Created by ssjt on 2021/6/3.
//

#import "YKBaseViewController.h"
#import "SYBAlertView.h"
@interface YKBaseViewController ()


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
   
    
    if (@available(iOS 13.0, *)) {
        self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    } else {
        
    }
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}


- (void)tokenChange{
    
    
}














@end
