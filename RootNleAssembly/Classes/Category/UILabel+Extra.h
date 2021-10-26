//
//  UILabel+Extra.h
//  YiShangKe
//
//  Created by ssjt on 2021/7/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Extra)


@property (nonatomic , strong)  dispatch_source_t timer;

- (void)resumerTimer;

//设置label 阴影
- (void)setLabelShadowColor:(UIColor *)color;


//获取label行数
- (NSInteger)getLineCount;

- (void)dn_timeDown:(NSInteger)timeDown downStr:(NSString *)downStr finishStr:(NSString *)finishStr;

@end

NS_ASSUME_NONNULL_END
