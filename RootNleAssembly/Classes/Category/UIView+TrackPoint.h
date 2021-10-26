//
//  UIView+TrackPoint.h
//  Where
//
//  Created by 灵恩 on 2020/3/19.
//  Copyright © 2020 子说. All rights reserved.
//



#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (TrackPoint)
@property(nonatomic,assign)NSInteger   section;//用来记录当前控件所在具体是哪一组
@property(nonatomic,assign)NSInteger   row;//用来记录当前控件所在具体是哪一行
@property(nonatomic,copy)NSString      *indexID;//用来给控件添加下标id，在点击事件的方法中直接根据下标id去做业务逻辑

@property(nonatomic,copy)NSString      *name;//用于记录imageview的图片名称
@property(nonatomic,copy)NSString      *path;//用于记录imageview的图片路径
@property(nonatomic,strong)NSArray     *imagesArray;//用于记录当前view所在自定义相册的图片数组

//重新赋值view.layer.mask实现圆角效果
-(void)setCornerRadius:(CGFloat)value addRectCorners:(UIRectCorner)rectCorner;


-(void)setCornerRadius:(CGFloat)value andLineWidth:(CGFloat)width StrokeColor:(UIColor *)sColor addRectCorners:(UIRectCorner)rectCorner;


- (void)addTrackPointToView:(UIView *)ToView  collor:(UIColor *)coller  number :(NSString *)number  view:(UIView *)addView;

- (void)hidenBadge;

- (void)setTagViewWithTagNameArray:(NSArray *)names AndMAXWidth:(CGFloat)MAXWidth MiddleConstraintsWidth:(CGFloat)middleWidth MAXNumber:(int)num;




@property (strong , nonatomic) UILabel *trackView;


@end

NS_ASSUME_NONNULL_END
