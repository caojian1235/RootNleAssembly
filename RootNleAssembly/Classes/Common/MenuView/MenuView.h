//
//  MenuView.h
//  YiShangKe
//
//  Created by ssjt on 2021/6/25.
//

#import <UIKit/UIKit.h>


//
//  JLHomeMenuView.h
//  JianLian
//
//  Created by RuanYun on 2019/7/16.
//  Copyright © 2019 安徽软云科技. All rights reserved.
//

@protocol JLScenicSpotMenuDelegate <NSObject>

- (void)btnShopLaterClick:(NSInteger)index;

@end


@interface MenuView : UIView

//{@"图片"，@“标题”}
@property (strong , nonatomic) NSDictionary *dataDic;

//是否显示底部园标
@property (assign , nonatomic) BOOL isShowPageCurrent;
//是否能够滑动
@property (assign , nonatomic) BOOL isCanScroll;
//每行显示多少个
@property (assign , nonatomic) NSInteger rowNumber;

@property (nonatomic, assign) CGFloat  ImageWidth;

@property (nonatomic, assign) CGFloat  ImageHeight;

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIFont  *titleFont;

@property (nonatomic, assign) CGFloat  topImage;

@property (nonatomic, assign) CGFloat  topTitle;
///是否设置圆角
@property (nonatomic, assign) BOOL  isMask;

//每行显示多少行
@property (assign , nonatomic) NSInteger colNumber;


//datas
@property (strong , nonatomic) NSArray *datas;


/**
 初始化
 
 @param rowNumber 每行显示数量
 @param frame 尺寸大小
 
 */
- (instancetype)initWithRowNumber:(NSInteger)rowNumber colNumber:(NSInteger)colNumber frame:(CGRect)frame ;

@property (weak , nonatomic)  id<JLScenicSpotMenuDelegate >  delegate;


@end

