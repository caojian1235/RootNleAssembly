//
//  UIButton+EnlargeTouchArea.m
//  YunLanCashier
//
//  Created by 灵恩 on 2020/3/3.
//  Copyright © 2020 zjs. All rights reserved.
//

#import "UIButton+EnlargeTouchArea.h"
#import <objc/runtime.h>

static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;


@implementation UIButton (EnlargeTouchArea)

- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left {
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect)enlargedRect {
    NSNumber* topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber* rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber* leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge) {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    } else {
        return self.bounds;
    }
}

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event {
    CGRect rect = [self enlargedRect];
    //如果按钮设置为不可点击、隐藏、透明度小于等于0.01或者点击在按钮内部，则直接执行父类方法
    if (CGRectEqualToRect(rect, self.bounds) || self.userInteractionEnabled == NO || self.hidden == YES || self.alpha <= 0.01) {
        return [super hitTest:point withEvent:event];
    }
    //判断点击是否在放大的范围内
    return CGRectContainsPoint(rect, point) ? self : nil;
}

@end
