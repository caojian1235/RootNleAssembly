//
//  UIScrollView+Extension.h
//  DNProject
//
//  Created by zjs on 2018/7/20.
//  Copyright © 2018年 zjs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DNEmptyView: UIView

@property (nonatomic, copy) void (^DNEmptyRequestHandler)(void);

/** 图片名称 */
@property (nonatomic, copy) NSString *logoImageName;
/** 标题名称 */
@property (nonatomic, copy) NSString *titleLabelText;
/** 小标题名称 */
@property (nonatomic, copy) NSString *subTitleLabelText;
/** 按钮名称 */
@property (nonatomic, copy) NSString *requireButtonText;
/** 文本颜色 */
@property (nonatomic, assign) UIColor *titleColor;
/** 按钮背景颜色 */
@property (nonatomic, strong) UIColor *requireButtonBGColor;
/** 按钮文本颜色 */
@property (nonatomic, strong) UIColor *requireButtonTextColor;

- (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName;
@end



typedef void(^RefreshBlock)(void);
//typedef void(^RefHeadGIFBlock)(MJRefreshGifHeader *head);
//typedef void(^RefFootGIFBlock)(MJRefreshAutoGifFooter *foot);

@interface UIScrollView (Extension)

//@property (nonatomic, strong) DNEmptyView * emptyView;

///==============================================
/// 下拉刷新
///==============================================

/**
 *  @brief  普通下拉刷新
 *
 *  @param  refreshBlock 下拉回调
 */
- (void)dn_startHeaderRefreshWithRefreshBlock:(RefreshBlock)refreshBlock;

/**
 *  @brief  带图片下拉刷新
 *
 *  @param  idleImages      下拉时图片数组
 *  @param  pullImages      松手时图片数组
 *  @param  refreshImages   刷新时图片数组
 *  @param  refreshBlock    下拉刷新完成回调
 */
- (void)dn_startGifHeaderWithIdleImages:(NSArray *)idleImages pullImages:(NSArray *)pullImages refreshImages:(NSArray *)refreshImages refreshWithBlock:(RefreshBlock)refreshBlock;


///==============================================
/// 上拉加载
///==============================================

/**
 *  @brief  普通上拉加载
 *
 *  @param  refreshBlock 上拉回调
 */
- (void)dn_startFooterUploadRefreshBlock:(RefreshBlock)refreshBlock;

/**
 *  @brief  带图片上拉加载
 *
 *  @param  idleImages      上拉时图片数组
 *  @param  pullImages      松手时图片数组
 *  @param  refreshImages   刷新时图片数组
 *  @param  refreshBlock    下拉刷新完成回调
 */
- (void)dn_startGIFAutoFootWithIdleImages:(NSArray *)idleImages pullImages:(NSArray *)pullImages refreshImages:(NSArray *)refreshImages refreshWithBlock:(RefreshBlock)refreshBlock;

/**
 *  @brief  带图片上拉加载
 *
 *  @param  idleImages      上拉时图片数组
 *  @param  pullImages      松手时图片数组
 *  @param  refreshImages   刷新时图片数组
 *  @param  refreshBlock    下拉刷新完成回调
 */
- (void)dn_startGIFBackFootWithIdleImages:(NSArray *)idleImages pullImages:(NSArray *)pullImages refreshImages:(NSArray *)refreshImages refreshWithBlock:(RefreshBlock)refreshBlock;
@end
