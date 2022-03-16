//
//  UIView+Extra.h
//  DNProject
//
//  Created by zjs on 2019/1/16.
//  Copyright © 2019 zjs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
NS_ASSUME_NONNULL_BEGIN

struct DNRadius {
    CGFloat upLeft;     //The radius of upLeft. 左上半径
    CGFloat upRight;    //The radius of upRight.    右上半径
    CGFloat downLeft;   //The radius of downLeft.   左下半径
    CGFloat downRight;  //The radius of downRight.  右下半径
};
typedef struct DNRadius DNRadius;

static DNRadius const DNRadiusZero = (DNRadius){0, 0, 0, 0};

NS_INLINE bool DNRadiusIsEqual(DNRadius radius1, DNRadius radius2) {
    return radius1.upLeft == radius2.upLeft && radius1.upRight == radius2.upRight && radius1.downLeft == radius2.downLeft && radius1.downRight == radius2.downRight;
}

NS_INLINE DNRadius DNRadiusMake(CGFloat upLeft, CGFloat upRight, CGFloat downLeft, CGFloat downRight) {
    DNRadius radius;
    radius.upLeft = upLeft;
    radius.upRight = upRight;
    radius.downLeft = downLeft;
    radius.downRight = downRight;
    return radius;
}

NS_INLINE DNRadius DNRadiusMakeSame(CGFloat radius) {
    DNRadius result;
    result.upLeft = radius;
    result.upRight = radius;
    result.downLeft = radius;
    result.downRight = radius;
    return result;
}


typedef NS_ENUM(NSUInteger, DNGradualType) {
    DNGradualTypeUpLeftToDownRight = 0,
    DNGradualTypeVertical,
    DNGradualTypeHorizontal,
    DNGradualTypeUpRightToDownLeft
};

@interface DNCornerUtil : NSObject

/**The radiuses of 4 corners.   4个圆角的半径*/
@property (nonatomic, assign) DNRadius radius;
/**The color that will fill the layer/view. 将要填充layer/view的颜色*/
@property (nonatomic, strong) UIColor *fillColor;
/**The color of the border. 边框颜色*/
@property (nonatomic, strong) UIColor *borderColor;
/**The lineWidth of the border. 边框宽度*/
@property (nonatomic, assign) CGFloat borderWidth;

@end

@interface DNGradualChangingColor : NSObject

@property (nonatomic, strong) UIColor *fromColor;
@property (nonatomic, strong) UIColor *toColor;
@property (nonatomic, assign) DNGradualType type;

@end

@interface CALayer (Extra)

@property (nonatomic, strong) DNCornerUtil *dn_corner;

/**
 Add corner to a CALayer instance
 给一个CALayer对象添加圆角
 @param handler Deal the properities of corner, see QQCorner.
 corner的属性，看QQCorner的介绍
 @warning If you pass nil or clearColor to both 'fillColor' and 'borderColor' params in corner, this method will do nothing.
 如果在corner对象中，fillColor 和 borderColor 都被设置为 nil 或者 clearColor，这个方法什么都不会做。
 */
- (void)dn_updateCornerRadius:(void(^)(DNCornerUtil *corner))handler;
@end

@interface UIView (Extra)

/** Shortcut for frame.origin.x */
@property (nonatomic) CGFloat dn_x;

/** Shortcut for frame.origin.y */
@property (nonatomic) CGFloat dn_y;

/** Shortcut for frame.origin.x */
@property (nonatomic) CGFloat dn_right;

/** Shortcut for frame.origin.x + frame.size.width */
@property (nonatomic) CGFloat dn_bottom;

/** Shortcut for frame.size.width */
@property (nonatomic) CGFloat dn_width;

/** Shortcut for frame.size.height */
@property (nonatomic) CGFloat dn_height;

/** Shortcut for center.x */
@property (nonatomic) CGFloat dn_centerX;

/** Shortcut for center.y */
@property (nonatomic) CGFloat dn_centerY;

/** Shortcut for frame.origin */
@property (nonatomic) CGPoint dn_origin;

/** Shortcut for frame.size */
@property (nonatomic) CGSize  dn_size;

// 获取父视图控制器
- (UIViewController *)superViewController;

// 创建屏幕快照
- (UIImage *)dn_createSnapshotImage;
// 创建屏幕快照 PDF
- (nullable NSData *)dn_createSnapshotPDF;

/**
 Add corner to a UIView instance
 给一个UIView对象添加圆角
 @param handler Deal the properities of corner, see QQCorner.
 corner的属性，看QQCorner的介绍
 @warning If you pass nil or clearColor to both 'fillColor' and 'borderColor' params in corner, this method will do nothing.
 如果在corner对象中，fillColor 和 borderColor 都被设置为 nil 或者 clearColor，这个方法什么都不会做。
 */
//#warning AutoLayout 可能失效
- (void)dn_updateCornerRadius:(void(^)(DNCornerUtil *corner))handler;

//- (void)dn_makeCornerRadius:(UIRectCorner)rectCorner radius:(CGFloat)radius;

- (void)dn_setShadowColor:(UIColor *)color offset:(CGSize)offset cornerRadius:(CGFloat)cornerRadius opacity:(CGFloat)opacity shadowRadius:(CGFloat)effect;

- (void)dn_setGradientColor:(UIColor *)color toColor:(UIColor *)toColor startPoint:(CGPoint) startPoint endPoint:(CGPoint)endPoint;

- (void)removeLayer:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
