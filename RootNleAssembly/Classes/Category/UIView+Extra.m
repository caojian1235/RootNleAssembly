//
//  UIView+Extra.m
//  DNProject
//
//  Created by zjs on 2019/1/16.
//  Copyright © 2019 zjs. All rights reserved.
//

#import "UIView+Extra.h"

@implementation DNCornerUtil

- (instancetype)initWithRadius:(DNRadius)radius fillColor:(UIColor *)fillColor borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    if (self = [super init]) {
        _radius = radius;
        _fillColor = fillColor;
        _borderColor = borderColor;
        _borderWidth = borderWidth;
    }
    return self;
}

+ (instancetype)cornerWithRadius:(DNRadius)radius fillColor:(UIColor *)fillColor {
    return [[self alloc] initWithRadius:radius fillColor:fillColor borderColor:nil borderWidth:0];
}

+ (instancetype)cornerWithRadius:(DNRadius)radius fillColor:(UIColor *)fillColor borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    return [[self alloc] initWithRadius:radius fillColor:fillColor borderColor:borderColor borderWidth:borderWidth];
}

@end


@implementation DNGradualChangingColor

- (instancetype)initWithColorFrom:(UIColor *)from to:(UIColor *)to type:(DNGradualType)type {
    if (self = [super init]) {
        _fromColor = from;
        _toColor = to;
        _type = type;
    }
    return self;
}

+ (instancetype)gradualChangingColorFrom:(UIColor *)from to:(UIColor *)to {
    return [[self alloc] initWithColorFrom:from to:to type:DNGradualTypeUpLeftToDownRight];
}

+ (instancetype)gradualChangingColorFrom:(UIColor *)from to:(UIColor *)to type:(DNGradualType)type {
    return [[self alloc] initWithColorFrom:from to:to type:type];
}

@end

@implementation CALayer (Extra)

static const char *dn_layer_key = "qq_layer_key";
static const char *dn_corner_key = "qq_corner_key";

- (CAShapeLayer *)dn_layer {
    CAShapeLayer *layer = objc_getAssociatedObject(self, &dn_layer_key);
    if (!layer) {
        layer = [CAShapeLayer layer];
        layer.frame = self.bounds;
        [self insertSublayer:layer atIndex:0];
        self.dn_layer = layer;
    }
    return layer;
}


- (void)setDn_layer:(CAShapeLayer *)dn_layer {
    objc_setAssociatedObject(self, &dn_layer_key, dn_layer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (DNCornerUtil *)dn_corner {
    DNCornerUtil *corner = objc_getAssociatedObject(self, &dn_corner_key);
    if (!corner) {
        corner = [[DNCornerUtil alloc] init];
        self.dn_corner = corner;
    }
    return corner;
}

- (void)setDn_corner:(DNCornerUtil *)dn_corner {
    objc_setAssociatedObject(self, &dn_corner_key, dn_corner, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)dn_updateCornerRadius:(void (^)(DNCornerUtil * _Nonnull))handler {
    
    if (handler) {
        handler(self.dn_corner);
    }
    CGColorRef fill = self.dn_corner.fillColor.CGColor;
    if (!fill || CGColorEqualToColor(fill, [UIColor clearColor].CGColor)) {
        if (!self.backgroundColor || CGColorEqualToColor(self.backgroundColor, [UIColor clearColor].CGColor)) {
            if (!self.dn_corner.borderColor || CGColorEqualToColor(self.dn_corner.borderColor.CGColor, [UIColor clearColor].CGColor)) {
                return;
            }
        }
        fill = self.backgroundColor;
        self.backgroundColor = [UIColor clearColor].CGColor;
    }
    
    DNRadius radius = self.dn_corner.radius;
    if (radius.upLeft < 0) {
        radius.upLeft = 0;
    }
    if (radius.upRight < 0) {
        radius.upRight = 0;
    }
    if (radius.downLeft < 0) {
        radius.downLeft = 0;
    }
    if (radius.downRight < 0) {
        radius.downRight = 0;
    }
    if (self.dn_corner.borderWidth <= 0) {
        self.dn_corner.borderWidth = 1;
    }
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat height = self.bounds.size.height;
    CGFloat width  = self.bounds.size.width;
    //左上
    [path moveToPoint:CGPointMake(radius.upLeft, 0)];
    [path addQuadCurveToPoint:CGPointMake(0, radius.upLeft) controlPoint:CGPointMake(0, 0)];
    //左下
    [path addLineToPoint:CGPointMake(0, height - radius.downLeft)];
    [path addQuadCurveToPoint:CGPointMake(radius.downLeft, height) controlPoint:CGPointMake(0, height)];
    //右下
    [path addLineToPoint:CGPointMake(width - radius.downRight, height)];
    [path addQuadCurveToPoint:CGPointMake(width, height - radius.downRight) controlPoint:CGPointMake(width, height)];
    //右上
    [path addLineToPoint:CGPointMake(width, radius.upRight)];
    [path addQuadCurveToPoint:CGPointMake(width - radius.upRight, 0) controlPoint:CGPointMake(width, 0)];
    
    [path addLineToPoint:CGPointMake(radius.upLeft, 0)];
    
//    [path stroke];
    [path closePath];
    [path addClip];
    
    self.dn_layer.path        = path.CGPath;
    self.dn_layer.fillColor   = fill;
    self.dn_layer.strokeColor = self.dn_corner.borderColor.CGColor;
    self.dn_layer.lineWidth   = self.dn_corner.borderWidth;
    
}
@end

@implementation UIView (Extra)

- (CGFloat)dn_x {
    
    return self.frame.origin.x;
}
- (void)setDn_x:(CGFloat)dn_x {
    
    CGRect frame   = self.frame;
    frame.origin.x = dn_x;
    self.frame = frame;
}

- (CGFloat)dn_y {
    
    return self.frame.origin.y;
}

- (void)setDn_y:(CGFloat)dn_y {
    
    CGRect frame   = self.frame;
    frame.origin.y = dn_y;
    self.frame = frame;
}

- (CGFloat)dn_right {
    
    return self.frame.origin.x + self.frame.size.width;
}
- (void)setDn_right:(CGFloat)dn_right {
    
    CGRect frame   = self.frame;
    frame.origin.x = dn_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)dn_bottom {
    
    return self.frame.origin.y + self.frame.size.height;
}
- (void)setDn_bottom:(CGFloat)dn_bottom {
    
    CGRect frame   = self.frame;
    frame.origin.y = dn_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)dn_width {
    
    return self.frame.size.width;
}
- (void)setDn_width:(CGFloat)dn_width {
    
    CGRect frame     = self.frame;
    frame.size.width = dn_width;
    self.frame = frame;
}

- (CGFloat)dn_height {
    
    return self.frame.size.height;
}
- (void)setDn_height:(CGFloat)dn_height {
    
    CGRect frame      = self.frame;
    frame.size.height = dn_height;
    self.frame = frame;
}


- (CGFloat)dn_centerX {
    
    return self.center.x;
}
- (void)setDn_centerX:(CGFloat)dn_centerX {
    
    self.center = CGPointMake(dn_centerX, self.center.y);
}

- (CGFloat)dn_centerY {
    
    return self.center.y;
}
- (void)setDn_centerY:(CGFloat)dn_centerY {
    
    self.center = CGPointMake(self.center.x, dn_centerY);
}

- (CGPoint)dn_origin {
    
    return self.frame.origin;
}
- (void)setDn_origin:(CGPoint)dn_origin {
    
    CGRect frame = self.frame;
    frame.origin = dn_origin;
    self.frame   = frame;
}

- (CGSize)dn_size {
    
    return self.frame.size;
}
- (void)setDn_size:(CGSize)dn_size {
    
    CGRect frame = self.frame;
    frame.size   = dn_size;
    self.frame   = frame;
}

- (UIViewController *)superViewController {
    
    for (UIView * next = self.superview; next; next = next.superview) {
        
        UIResponder * nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

// 创建屏幕快照
- (UIImage *)dn_createSnapshotImage {
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return snap;
}

- (NSData *)dn_createSnapshotPDF {
    
    CGRect bounds = self.bounds;
    NSMutableData* data = [NSMutableData data];
    CGDataConsumerRef consumer = CGDataConsumerCreateWithCFData((__bridge CFMutableDataRef)data);
    CGContextRef context = CGPDFContextCreate(consumer, &bounds, NULL);
    CGDataConsumerRelease(consumer);
    
    if (!context) return nil;
    
    CGPDFContextBeginPage(context, NULL);
    CGContextTranslateCTM(context, 0, bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    [self.layer renderInContext:context];
    CGPDFContextEndPage(context);
    CGPDFContextClose(context);
    CGContextRelease(context);
    
    return data;
}

//- (void)dn_makeCornerRadius:(UIRectCorner)rectCorner radius:(CGFloat)radius {
//    
//    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
//                                                     byRoundingCorners:rectCorner
//                                                           cornerRadii:CGSizeMake(radius, radius)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
//    maskLayer.frame = self.bounds;
//    maskLayer.path  = bezierPath.CGPath;
//    maskLayer.backgroundColor = self.backgroundColor.CGColor;
//    self.layer.mask = maskLayer;
//}

- (void)dn_updateCornerRadius:(void (^)(DNCornerUtil *))handler {
    if (handler) {
        handler(self.layer.dn_corner);
    }
    if (!self.layer.dn_corner.fillColor || CGColorEqualToColor(self.layer.dn_corner.fillColor.CGColor, [UIColor clearColor].CGColor)) {
        if (CGColorEqualToColor(self.backgroundColor.CGColor, [UIColor clearColor].CGColor)) {
            if (!self.layer.dn_corner.borderColor || CGColorEqualToColor(self.layer.dn_corner.borderColor.CGColor, [UIColor clearColor].CGColor)) {
                return;
            }
        }
        self.layer.dn_corner.fillColor = self.backgroundColor;
        self.backgroundColor = [UIColor clearColor];
    }
    [self.layer dn_updateCornerRadius:handler];
}

// 设置阴影
- (void)dn_setShadowColor:(UIColor *)color offset:(CGSize)offset cornerRadius:(CGFloat)cornerRadius opacity:(CGFloat)opacity shadowRadius:(CGFloat)effect {
    
    self.layer.cornerRadius       = cornerRadius;
    self.layer.shadowColor        = color.CGColor;
    self.layer.shadowOpacity      = opacity;
    self.layer.shadowRadius       = effect;
    self.layer.shadowOffset       = offset;
//    self.layer.shouldRasterize    = YES;
//    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (void)dn_setShadowColor:(UIColor *)color radius:(CGFloat)radius {
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                     byRoundingCorners:UIRectCornerAllCorners
                                                           cornerRadii:CGSizeMake(radius, radius)];
    //设置阴影路径
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.shadowPath    = bezierPath.CGPath;
    maskLayer.shadowColor   = color.CGColor;
    
    [self.layer insertSublayer:maskLayer atIndex:0];
    
}

- (void)dn_setGradientColor:(UIColor *)color toColor:(UIColor *)toColor startPoint:(CGPoint) startPoint endPoint:(CGPoint)endPoint{
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    // 渐变色颜色数组,可多个
    gradientLayer.colors = [NSArray arrayWithObjects:(id)[color CGColor], (id)[toColor CGColor], nil];
    // 渐变的开始点 (不同的起始点可以实现不同位置的渐变,如图)
    gradientLayer.startPoint = startPoint; //(0, 0)
    // 渐变的结束点
    gradientLayer.endPoint = endPoint; //(1, 1)
    [self.layer insertSublayer:gradientLayer atIndex:0];
    
    
}

- (void)removeLayer:(NSUInteger)index {
    NSArray<CALayer *> *subLayers = self.layer.sublayers;
    [subLayers[index] removeFromSuperlayer];
}
@end
