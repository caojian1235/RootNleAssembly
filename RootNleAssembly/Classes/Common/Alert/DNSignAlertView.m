//
//  DNSignAlertView.m
//  Where
//
//  Created by zjs on 2019/12/27.
//  Copyright © 2019 子说. All rights reserved.
//

#import "DNSignAlertView.h"
#import "YSKDefineMacro.h"
#import "Masonry.h"
#import "Category.h"
@interface DNSignAlertView ()<UITextViewDelegate>

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *confirmBtn;



@end

@implementation DNSignAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupSubviews];
        [self setupConstraints];
    }
    return self;
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
    [self.cancelBtn setTitleColor:MAIN_BLACK_COLOR_3 forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.confirmBtn = [[UIButton alloc] init];
    self.confirmBtn.backgroundColor = COMMOM_GREEN_COLOR;
    self.confirmBtn.titleLabel.font = [UIFont boldSystemFontOfSize:AUTO_FONT_SIZE(15)];
    [self.confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [self.confirmBtn setTitleColor:MAIN_BLACK_COLOR_3 forState:UIControlStateNormal];
    [self.confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.alertTitle = [[UILabel alloc] init];
    self.alertTitle.font = [UIFont boldSystemFontOfSize:AUTO_FONT_SIZE(17)];
    self.alertTitle.text = @"回复评论";
    self.alertTitle.textColor = MAIN_BLACK_COLOR_3;
    
    self.textView = [[UITextView alloc] init];
    self.textView.font = AUTO_SYSTEM_FONT_SIZE(13);
    self.textView.textColor = MAIN_BLACK_COLOR_6;
    self.textView.dn_placeholder = @"输入文字（50字以内）";
    self.textView.delegate = self;
    
}

- (void)setupConstraints {
    
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.centerY.mas_equalTo(self);
        make.width.mas_offset(SCREEN_W * 0.75);
    }];
    
    [self.contentView addSubview:self.alertTitle];
    [self.alertTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.contentView.mas_top).inset(AUTO_MARGIN(16));
        make.leading.trailing.mas_equalTo(self.contentView).inset(AUTO_MARGIN(20));
    }];
    
    [self.contentView addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.alertTitle.mas_bottom).mas_offset(AUTO_MARGIN(8));
        make.leading.trailing.mas_equalTo(self.alertTitle);
        make.height.mas_offset(SCREEN_W * 0.1);
    }];
    
    [self.contentView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.textView.mas_bottom).mas_offset(AUTO_MARGIN(25));
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

- (void)textViewDidChange:(UITextView *)textView{
    
    if (textView.markedTextRange == nil && textView.text.length > 50 && !self.isLimit) {
           //提示语
//           [self showMessage:@"输入限制50个字符以内"];
           //截取
           textView.text = [textView.text substringToIndex:50];
       }
    
}

#pragma mark -- Public Methods
- (void)showAlertView {
    
    self.frame = UIScreen.mainScreen.bounds;
    [UIApplication.sharedApplication.keyWindow addSubview:self];
    self.contentView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    [UIView animateWithDuration:0.35 animations:^{
       
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
        self.contentView.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark -- Private Methods
- (void)cancelAction {
    
    [self  hideAlertView];
}

- (void)confirmAction {
    
  
    if (self.confirmBlock) {
        self.confirmBlock(self.textView.text);
        [self hideAlertView];
    }
}

- (void)hideAlertView {
    
    self.contentView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:0.35 animations:^{
        
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        self.contentView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        self.alpha = 0.0;
        
    } completion:^(BOOL finished) {
       
        [self removeFromSuperview];
    }];
}

@end
