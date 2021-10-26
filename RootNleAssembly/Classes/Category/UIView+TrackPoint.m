//
//  UIView+TrackPoint.m
//  Where
//
//  Created by 灵恩 on 2020/3/19.
//  Copyright © 2020 子说. All rights reserved.
//

#import "UIView+TrackPoint.h"
#import <objc/runtime.h>
#import "YSKDefineMacro.pch"
#import <Masonry/Masonry.h>
static const NSInteger tag = 10086;

@implementation UIView (TrackPoint)

static char *SectionKey = "SectionKey";
static char *RowKey = "RowKey";
static char *IndexIDKey = "IndexIDKey";
static char *nameKey = "nameKey";
static char *pathKey = "pathKey";
static char *imagesArrayKey = "imagesArrayKey";

-(void)setSection:(NSInteger)section{
    objc_setAssociatedObject(self, SectionKey, @(section), OBJC_ASSOCIATION_ASSIGN);
}
-(NSInteger)section{
    return [objc_getAssociatedObject(self, SectionKey) integerValue];
}

-(void)setRow:(NSInteger)row{
    objc_setAssociatedObject(self, RowKey, @(row), OBJC_ASSOCIATION_ASSIGN);
}
-(NSInteger)row{
    return [objc_getAssociatedObject(self, RowKey) integerValue];
}

-(void)setIndexID:(NSString *)indexID{
    objc_setAssociatedObject(self, IndexIDKey, indexID, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString *)indexID{
     return objc_getAssociatedObject(self, IndexIDKey);
}

-(void)setName:(NSString *)name{
    objc_setAssociatedObject(self, nameKey, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString *)name{
     return objc_getAssociatedObject(self, nameKey);
}

-(void)setPath:(NSString *)path{
    objc_setAssociatedObject(self, pathKey, path, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString *)path{
     return objc_getAssociatedObject(self, pathKey);
}

-(void)setImagesArray:(NSArray *)imagesArray{
    objc_setAssociatedObject(self, imagesArrayKey, imagesArray, OBJC_ASSOCIATION_RETAIN);
}
-(NSArray *)imagesArray{
    return objc_getAssociatedObject(self, imagesArrayKey);
}

- (void)setCornerRadius:(CGFloat)value addRectCorners:(UIRectCorner)rectCorner{
    [self layoutIfNeeded];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(value, value)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = path.CGPath;
   
    self.layer.mask = shapeLayer;
}
-(void)setCornerRadius:(CGFloat)value andLineWidth:(CGFloat)width StrokeColor:(UIColor *)sColor addRectCorners:(UIRectCorner)rectCorner{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(value, value)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setLineWidth:width];
    [shapeLayer setStrokeColor:sColor.CGColor];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = path.CGPath;
//    self.layer.mask=shapeLayer;
    [self.layer addSublayer:shapeLayer];
}





- (void)addTrackPointToView:(UIView *)ToView  collor:(UIColor *)coller  number :(NSString *)number  view:(UIView *)addView{
    

    if (self.trackView == nil) {
        
        UILabel * trackView = UILabel.new;
        
        trackView.tag = tag;
        trackView.textColor = UIColor.whiteColor;
        trackView.backgroundColor = coller;
        trackView.textAlignment = NSTextAlignmentCenter;
        trackView.text = [NSString stringWithFormat:@"%@",number];
        trackView.font = AUTO_SYSTEM_FONT_SIZE(10);
        
        trackView.layer.masksToBounds = YES;
        trackView.layer.cornerRadius = ((addView.frame.size.width)*0.3 + (addView.frame.size.height)*0.3)/4;
        self.trackView = trackView;
        [ToView addSubview:trackView];
        
        [trackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(addView.mas_right).offset(- ((addView.frame.size.width)*0.3 + (addView.frame.size.height)*0.3)/6);
            make.top.mas_equalTo(addView.mas_top).offset(- ((addView.frame.size.width)*0.3 + (addView.frame.size.height)*0.3)/4);
            make.width.height.mas_equalTo(((addView.frame.size.width)*0.3 + (addView.frame.size.height)*0.3)/2);
        }];
        
    }
    self.trackView.hidden = NO;
    
    self.trackView.text = [NSString stringWithFormat:@"%@",number];
}

- (void)hidenBadge
{
    //从父视图上面移除
    self.trackView.hidden = YES;
//    [self.trackView removeFromSuperview];
}

#pragma mark - GetterAndSetter

- (UILabel *)trackView
{
    //通过runtime创建一个UILabel的属性
    return objc_getAssociatedObject(self, &tag);
     
}

- (void)setTrackView:(UILabel *)trackView
{
    objc_setAssociatedObject(self, &tag, trackView, OBJC_ASSOCIATION_RETAIN);
}

//
//-(void)setTagViewWithTagNameArray:(NSArray *)names AndMAXWidth:(CGFloat)MAXWidth MiddleConstraintsWidth:(CGFloat)middleWidth MAXNumber:(int)num{
//    [self removeAllSubviews];
//    MASViewAttribute *right;
//    int k = 0;
//    for (int i = 0; i < names.count; i ++) {
//        UILabel * TipLabel = UILabel.new;
//        TipLabel.font      = mfont(10);
//        TipLabel.text      = names[i];
//        TipLabel.textAlignment = NSTextAlignmentCenter;
//        TipLabel.layer.cornerRadius  = 2;
//        TipLabel.layer.masksToBounds = YES;
//        TipLabel.layer.borderWidth = 0.5;
////        TipLabel.backgroundColor = [COMMOM_YELLOW_COLOR colorWithAlphaComponent:0.1];
//        TipLabel.textColor       = COMMOM_YELLOW_COLOR;
//        TipLabel.layer.borderColor = COMMOM_YELLOW_COLOR.CGColor;
//        if ([self caluateWidth:names[i]] > MAXWidth) {
//            break;
//        }
//        [self addSubview:TipLabel];
//        [TipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.mas_top).with.offset(0);
//            make.width.equalTo([NSNumber numberWithFloat:[self caluateWidth:names[i]]]);
//            if (k == 0) {
//                make.left.equalTo(self.mas_left).with.offset(0);
//            } else {
//                make.left.equalTo(right).with.offset(middleWidth);
//            }
//            make.height.mas_equalTo(self.mas_height);
//        }];
//        right=TipLabel.mas_right;
//        k++;
//        if(k == num){
//            break;
//        }
//    }
//}


@end
