//
//  SYBAlertView.m
//  CashierChoke
//
//  Created by zjs on 2019/8/21.
//  Copyright © 2019 zjs. All rights reserved.
//

#import "SYBAlertView.h"
#import "YSKDefineMacro.pch"
#import "Masonry.h"
@interface SYBAlertView ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, strong) UILabel  *alertTitle;
@property (nonatomic, strong) UILabel  *alertMessage;
@end
static SYBAlertView *alertView = nil;
@implementation SYBAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        if (@available(iOS 13.0, *)) {
            self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
        } else {
        
        }
        [self setupSubviews];
        [self setupConstraints];
    }
    return self;
}

+ (instancetype)shareInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!alertView) {
            alertView = [[self alloc] init];
        }
    });
    return alertView;
}

- (void)setupSubviews {
    
    self.contentView = [[UIView alloc] init];
    self.contentView.layer.cornerRadius  = 5.f;
    self.contentView.layer.masksToBounds = YES;
    self.contentView.backgroundColor = UIColor.whiteColor;
    
    self.lineView  = [[UIView alloc] init];
    self.lineView.backgroundColor = UIColor.groupTableViewBackgroundColor;
    
    self.cancelBtn = [[UIButton alloc] init];
    self.cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:AUTO_FONT_SIZE(15)];
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:COMMOM_BLACK_COLOR forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.confirmBtn = [[UIButton alloc] init];
    self.confirmBtn.backgroundColor = COMMOM_GREEN_COLOR;
    self.confirmBtn.titleLabel.font = [UIFont boldSystemFontOfSize:AUTO_FONT_SIZE(15)];
    [self.confirmBtn setTitle:@"确认退款" forState:UIControlStateNormal];
    [self.confirmBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [self.confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.alertTitle = [[UILabel alloc] init];
    self.alertTitle.font = [UIFont boldSystemFontOfSize:AUTO_FONT_SIZE(17)];
    self.alertTitle.text = @"退款金额";
    self.alertTitle.textColor = COMMOM_BLACK_COLOR;
    self.alertTitle.textAlignment = NSTextAlignmentCenter;
    
    self.alertMessage = [[UILabel alloc] init];
    self.alertMessage.font = AUTO_SYSTEM_FONT_SIZE(14);
    self.alertMessage.text = @"退款金额";
    self.alertMessage.textColor = COMMOM_BLACK_COLOR;
    self.alertMessage.textAlignment = NSTextAlignmentCenter;
    self.alertMessage.numberOfLines = 0;
    self.hidden = YES;
    self.isShow = NO;
}

- (void)setupConstraints {
    
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.centerY.mas_equalTo(self);
        make.width.mas_offset(SCREEN_W * 0.75);
    }];
    
    [self.contentView addSubview:self.alertTitle];
    [self.alertTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.contentView.mas_top).inset(AUTO_MARGIN(16)).priorityHigh();
        make.leading.trailing.mas_equalTo(self.contentView).inset(AUTO_MARGIN(20));
    }];
    
    [self.contentView addSubview:self.alertMessage];
    [self.alertMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.alertTitle.mas_bottom).mas_offset(AUTO_MARGIN(8)).priorityHigh();
        make.leading.trailing.mas_equalTo(self.alertTitle);
    }];
    
    [self.contentView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.alertMessage.mas_bottom).mas_offset(AUTO_MARGIN(25));
        make.leading.trailing.mas_equalTo(self.contentView);
        make.height.mas_offset(AUTO_MARGIN(1));
    }];
    
    [self.contentView addSubview:self.cancelBtn];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.lineView.mas_bottom);
        make.leading.bottom.mas_equalTo(self.contentView);
        make.width.mas_offset(SCREEN_W * 0.375);
        make.height.mas_offset(SCREEN_W * 0.12);
    }];
    
    [self.contentView addSubview:self.confirmBtn];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.mas_equalTo(self.cancelBtn);
        make.leading.mas_equalTo(self.cancelBtn.mas_trailing);
        make.trailing.mas_equalTo(self.contentView.mas_trailing);
    }];
   
}

#pragma mark -- Public Methods
- (void)showAlertView {
    
    if ( [SYBAlertView shareInstance].hidden == YES && [SYBAlertView shareInstance].isShow == YES){
        [SYBAlertView shareInstance].hidden = NO;
        [SYBAlertView shareInstance].frame = UIScreen.mainScreen.bounds;
        [SYBAlertView shareInstance].backgroundColor = UIColor.clearColor;
        [SYBAlertView shareInstance].alpha = 1;
        [SYBAlertView shareInstance].contentView.transform = CGAffineTransformMakeScale(1.1, 1.1);
        [UIView animateWithDuration:0.35 animations:^{
            [UIApplication.sharedApplication.keyWindow addSubview:[SYBAlertView shareInstance]];
            [SYBAlertView shareInstance].backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
            [SYBAlertView shareInstance].contentView.transform = CGAffineTransformIdentity;
            
        }];
    }else{
        self.hidden = NO;
        self.frame = UIScreen.mainScreen.bounds;
        [UIApplication.sharedApplication.keyWindow addSubview:self];
        self.contentView.transform = CGAffineTransformMakeScale(1.1, 1.1);
        [UIView animateWithDuration:0.35 animations:^{
           
            self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
            self.contentView.transform = CGAffineTransformIdentity;
        }];
    }
    
   
}

#pragma mark -- Private Methods
- (void)cancelAction {
    [self hideAlertView];
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (void)confirmAction {
    [self hideAlertView];
    if (self.confirmBlock) {
        self.confirmBlock();
    }
}

- (void)hideAlertView {
    
    if ([SYBAlertView shareInstance].hidden == NO && self.isShow == YES) {
        
        [SYBAlertView shareInstance].contentView.transform = CGAffineTransformIdentity;
        [UIView animateWithDuration:0.35 animations:^{
            
            [SYBAlertView shareInstance].backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
            [SYBAlertView shareInstance].contentView.transform = CGAffineTransformMakeScale(0.1, 0.1);
            [SYBAlertView shareInstance].alpha = 0.0;
            
        } completion:^(BOOL finished) {

            [SYBAlertView shareInstance].hidden = YES;
            [SYBAlertView shareInstance].isShow = NO;
            
        }];
        
    }else{
        self.contentView.transform = CGAffineTransformIdentity;
        [UIView animateWithDuration:0.35 animations:^{
            
            self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
            self.contentView.transform = CGAffineTransformMakeScale(0.1, 0.1);
            self.alpha = 0.0;
            
        } completion:^(BOOL finished) {
           
          
                [self removeFromSuperview];
            
            
           
        }];
    }
    
   
}


- (void)setTitle:(NSString *)title {
    
    _title = title;
    self.alertTitle.text = title;
}

- (void)setMessage:(NSString *)message {
    
    _message = message;
    self.alertMessage.text = message;
}

- (void)setCancleTitle:(NSString *)cancleTitle {
    
    _cancleTitle = cancleTitle;
    [self.cancelBtn setTitle:cancleTitle forState:UIControlStateNormal];
}

- (void)setConfirmTitle:(NSString *)confirmTitle {
    
    _confirmTitle = confirmTitle;
    [self.confirmBtn setTitle:confirmTitle forState:UIControlStateNormal];
}

- (void)setTitleColor:(UIColor *)titleColor {
    
    _titleColor = titleColor;
    self.alertTitle.textColor = titleColor;
}

- (void)setMessageColor:(UIColor *)messageColor {
    
    _messageColor = messageColor;
    self.alertMessage.textColor = messageColor;
}

- (void)setCancelTitleColor:(UIColor *)cancelTitleColor {
    
    _cancelTitleColor = cancelTitleColor;
    [self.cancelBtn setTitleColor:cancelTitleColor forState:UIControlStateNormal];
}

- (void)setConfirmTitleColor:(UIColor *)confirmTitleColor {
    
    _confirmTitleColor = confirmTitleColor;
    [self.confirmBtn setTitleColor:confirmTitleColor forState:UIControlStateNormal];
}

- (void)setConfirmBackgroundColor:(UIColor *)confirmBackgroundColor {
    
    _confirmBackgroundColor = confirmBackgroundColor;
    self.confirmBtn.backgroundColor = confirmBackgroundColor;
}


- (void)setHideCancelBtn:(BOOL)hideCancelBtn {
    
    _hideCancelBtn = hideCancelBtn;
    self.cancelBtn.hidden = YES;
    [self.cancelBtn mas_updateConstraints:^(MASConstraintMaker *make) {
       
        make.width.mas_offset(0);
    }];
}
@end
