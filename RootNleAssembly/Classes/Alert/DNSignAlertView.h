//
//  DNSignAlertView.h
//  Where
//
//  Created by zjs on 2019/12/27.
//  Copyright © 2019 子说. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DNSignAlertView : UIView

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) UILabel   *alertTitle;

@property (nonatomic, assign) BOOL          isLimit;

@property (nonatomic, copy) void(^confirmBlock)(NSString *result);

- (void)showAlertView;
@end

NS_ASSUME_NONNULL_END
