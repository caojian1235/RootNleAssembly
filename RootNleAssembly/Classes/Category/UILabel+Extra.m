//
//  UILabel+Extra.m
//  YiShangKe
//
//  Created by ssjt on 2021/7/7.
//

#import "UILabel+Extra.h"
#import <objc/runtime.h>
static const NSInteger tag = 299953;

@implementation UILabel (Extra)

- (void)setLabelShadowColor:(UIColor *)color{
    
    NSShadow *shadow = [[NSShadow alloc]init];
     shadow.shadowBlurRadius = 1.0;
    shadow.shadowOffset = CGSizeMake(1, 1);
     shadow.shadowColor = color;
    NSAttributedString *attrStringNsg = [[NSAttributedString alloc]initWithString:self.text attributes:@{NSShadowAttributeName:shadow}];
     
    self.attributedText = attrStringNsg;
    
}

- (NSInteger)getLineCount{
    
    [self layoutIfNeeded];
    CGFloat labelHeight = [self sizeThatFits:CGSizeMake(self.frame.size.width, MAXFLOAT)].height;
    NSNumber *count = @((labelHeight) / self.font.lineHeight);
    
    
    return  [count integerValue];
}

- (void)dn_timeDown:(NSInteger)timeDown downStr:(NSString *)downStr finishStr:(NSString *)finishStr {
    
    __block NSInteger timeout = timeDown; //倒计时时间

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);

    dispatch_source_set_timer(self.timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行

    dispatch_source_set_event_handler(self.timer, ^{

    if(timeout<=0){ //倒计时结束，关闭

    dispatch_source_cancel(self.timer);

    dispatch_async(dispatch_get_main_queue(), ^{

    //设置界面的按钮显示 根据自己需求设置（倒计时结束后调用）

    self.text = downStr;

    });

    }else{

    dispatch_async(dispatch_get_main_queue(), ^{

    //设置界面的按钮显示 根据自己需求设置

    //                NSLog(@"____%@",strTime);

    int second =timeout%60;//秒

    int minutes = timeout/60%60;//分钟的。

    int hour = timeout/60/60%24;//小时

//    int day = timeout/60/60/24;//天

    NSString *strTime = [NSString stringWithFormat:@"待接诊 %d小时%d分钟%d秒后关闭订单",hour,minutes,second ];

    self.text = strTime;

    });

    timeout--;

    }

    });

    dispatch_resume(self.timer);
}

- (dispatch_source_t)timer{
    return objc_getAssociatedObject(self, &tag);
    
}

- (void)setTimer:(dispatch_source_t)timer{
    objc_setAssociatedObject(self, &tag, timer, OBJC_ASSOCIATION_RETAIN);
}




- (void)resumerTimer{
    
    if (self.timer) {
        dispatch_source_cancel(self.timer);
    }
    
}

@end
