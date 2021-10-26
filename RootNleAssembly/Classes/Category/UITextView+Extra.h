//
//  UITextView+Extra.h
//  CashierChoke
//
//  Created by zjs on 2019/8/20.
//  Copyright © 2019 zjs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^textViewHeightDidChangedBlock)(CGFloat currentTextViewHeight);

@interface UITextView (Extra)

- (void)dn_limitMaxLength:(NSInteger)maxLength;

- (void)dn_setPlaceholder:(NSString *)placeholder placeholderColor:(UIColor *)color;



/* 占位文字 */
@property (nonatomic, copy) NSString *dn_placeholder;

/* 占位文字颜色 */
@property (nonatomic, strong) UIColor *dn_placeholderColor;

/* 最大文字数量 */
@property (nonatomic, assign) NSInteger dn_maxLength;

/* 最大高度，如果需要随文字改变高度的时候使用 */
@property (nonatomic, assign) CGFloat dn_maxHeight;

/* 最小高度，如果需要随文字改变高度的时候使用 */
@property (nonatomic, assign) CGFloat dn_minHeight;


@property (nonatomic, copy) textViewHeightDidChangedBlock dn_textViewHeightDidChanged;

/* 获取图片数组 */
- (NSArray *)dn_getImages;


/* 自动高度的方法，maxHeight：最大高度 */
- (void)dn_autoHeightWithMaxHeight:(CGFloat)maxHeight;


/* 自动高度的方法，maxHeight：最大高度， textHeightDidChanged：高度改变的时候调用 */
- (void)dn_autoHeightWithMaxHeight:(CGFloat)maxHeight textViewHeightDidChanged:(textViewHeightDidChangedBlock)textViewHeightDidChanged;

/* 添加一张图片 image:要添加的图片 */
- (void)dn_addImage:(UIImage *)image;


/* 添加一张图片 image:要添加的图片 size:图片大小 */
- (void)dn_addImage:(UIImage *)image size:(CGSize)size;


/* 插入一张图片 image:要添加的图片 size:图片大小 index:插入的位置 */
- (void)dn_insertImage:(UIImage *)image size:(CGSize)size index:(NSInteger)index;


/* 添加一张图片 image:要添加的图片 multiple:放大／缩小的倍数 */
- (void)dn_addImage:(UIImage *)image multiple:(CGFloat)multiple;


/* 插入一张图片 image:要添加的图片 multiple:放大／缩小的倍数 index:插入的位置 */
- (void)dn_insertImage:(UIImage *)image multiple:(CGFloat)multiple index:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
