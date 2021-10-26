//
//  UITextView+Extra.m
//  CashierChoke
//
//  Created by zjs on 2019/8/20.
//  Copyright © 2019 zjs. All rights reserved.
//

#import "UITextView+Extra.h"
#import <objc/runtime.h>

// 占位文字
static const void *DNPlaceholderViewKey = &DNPlaceholderViewKey;
// 占位文字颜色
static const void *DNPlaceholderColorKey = &DNPlaceholderColorKey;
// 最大长度
static const void *DNTextViewMaxLengthKey = &DNTextViewMaxLengthKey;
static const void *DNTextViewMaxLengthLabelKey = &DNTextViewMaxLengthLabelKey;
// 最大高度
static const void *DNTextViewMaxHeightKey = &DNTextViewMaxHeightKey;
// 最小高度
static const void *DNTextViewMinHeightKey = &DNTextViewMinHeightKey;
// 高度变化的block
static const void *DNTextViewHeightDidChangedBlockKey = &DNTextViewHeightDidChangedBlockKey;
// 存储添加的图片
static const void *DNTextViewImageArrayKey = &DNTextViewImageArrayKey;
// 存储最后一次改变高度后的值
static const void *DNTextViewLastHeightKey = &DNTextViewLastHeightKey;

@interface UITextView ()

@property (nonatomic, strong) UILabel *maxLengthLabel;
// 存储添加的图片
@property (nonatomic, strong) NSMutableArray *dn_imageArray;
// 存储最后一次改变高度后的值
@property (nonatomic, assign) CGFloat lastHeight;
@end


@implementation UITextView (Extra)

+ (void)load {
    
    // 获取类方法   class_getClassMethod
    // 获取对象方法  class_getInstanceMethod
    Method setFontMethod = class_getInstanceMethod(self, @selector(setFont:));
    Method was_setFontMethod =class_getInstanceMethod(self, @selector(was_setFont:));
    // 交换方法的实现
    method_exchangeImplementations(setFontMethod, was_setFontMethod);
    
    // 交换dealoc
    Method dealoc = class_getInstanceMethod(self.class, NSSelectorFromString(@"dealloc"));
    Method myDealloc = class_getInstanceMethod(self.class, @selector(myDealloc));
    method_exchangeImplementations(dealoc, myDealloc);
}

- (void)myDealloc {
    // 移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    UITextView *placeholderView = objc_getAssociatedObject(self, DNPlaceholderViewKey);
    // 如果有值才去调用，这步很重要
    if (placeholderView) {
        NSArray *propertys = @[@"frame", @"bounds", @"font", @"text", @"textAlignment", @"textContainerInset"];
        for (NSString *property in propertys) {
            @try {
                [self removeObserver:self forKeyPath:property];
            } @catch (NSException *exception) {}
        }
    }
    [self myDealloc];
}

- (void)dn_setPlaceholder:(NSString *)placeholder placeholderColor:(UIColor *)color {
    //多余 强指针换了指向以后label自动销毁
    //防止重复设置 cell复用等问题
//    for (UIView *view in self.subviews) {
//        if ([view isKindOfClass:[UILabel class]]) {
//            [view removeFromSuperview];
//        }
//    }
    //设置占位label
    UILabel * placeholderLabel = [[UILabel alloc] init];
    placeholderLabel.text = placeholder;
    placeholderLabel.font = self.font;
    placeholderLabel.textColor = color;
    placeholderLabel.numberOfLines = 0;
    [self addSubview:placeholderLabel];
    [self setValue:placeholderLabel forKey:@"_placeholderLabel"];
}

- (void)was_setFont:(UIFont *)font{
    //调用原方法 setFont:
    [self was_setFont:font];
    //设置占位字符串的font
    UILabel *label = [self valueForKey:@"_placeholderLabel"];
    label.font = font;
}

- (void)dn_limitMaxLength:(NSInteger)maxLength {
    
    NSString * string = self.text;
    UITextInputMode * currentMode = [[UITextInputMode activeInputModes] firstObject];
    // 输入的内容是否为中文
    if ([currentMode.primaryLanguage isEqualToString:@"zh-Hans"]) {
        
        UITextRange * selectRange = [self markedTextRange];
        UITextPosition * position = [self positionFromPosition:selectRange.start offset:0];
        
        if (!position) {
            if (string.length > maxLength) {
                self.text = [string substringToIndex:maxLength];
            }
        }
    }
    else {
        if (string.length > maxLength) {
            self.text = [string substringToIndex:maxLength];
        }
    }
}

- (UITextView *)dn_placeholderView {
    // 为了让占位文字和textView的实际文字位置能够完全一致，这里用UITextView
    UITextView *placeholderView = objc_getAssociatedObject(self, DNPlaceholderViewKey);
    
    if (!placeholderView) {
        // 初始化数组
        self.dn_imageArray = [NSMutableArray array];
        
        placeholderView = [[UITextView alloc] init];
        // 动态添加属性的本质是: 让对象的某个属性与值产生关联
        objc_setAssociatedObject(self, DNPlaceholderViewKey, placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        placeholderView = placeholderView;
        
        // 设置基本属性
        placeholderView.scrollEnabled = placeholderView.userInteractionEnabled = NO;
        //        self.scrollEnabled = placeholderView.scrollEnabled = placeholderView.showsHorizontalScrollIndicator = placeholderView.showsVerticalScrollIndicator = placeholderView.userInteractionEnabled = NO;
        placeholderView.textColor = [UIColor lightGrayColor];
        placeholderView.backgroundColor = [UIColor clearColor];
        [self refreshPlaceholderView];
        [self addSubview:placeholderView];
        
        // 监听文字改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextChange) name:UITextViewTextDidChangeNotification object:self];
        
        // 这些属性改变时，都要作出一定的改变，尽管已经监听了TextDidChange的通知，也要监听text属性，因为通知监听不到setText：
        NSArray *propertys = @[@"frame", @"bounds", @"font", @"text", @"textAlignment", @"textContainerInset"];
        
        // 监听属性
        for (NSString *property in propertys) {
            [self addObserver:self forKeyPath:property options:NSKeyValueObservingOptionNew context:nil];
        }
    }
    return placeholderView;
}


- (void)setDn_placeholder:(NSString *)dn_placeholder {
    
    // 为placeholder赋值
    [self dn_placeholderView].text = dn_placeholder;
}
- (NSString *)dn_placeholder {
    // 如果有placeholder值才去调用，这步很重要
    if (self.placeholderExist) {
        return [self dn_placeholderView].text;
    }
    return nil;
}

- (void)setDn_placeholderColor:(UIColor *)dn_placeholderColor {
    
    // 如果有placeholder值才去调用，这步很重要
    if (!self.placeholderExist) {
        NSLog(@"请先设置placeholder值！");
    } else {
        self.dn_placeholderView.textColor = dn_placeholderColor;
        // 动态添加属性的本质是: 让对象的某个属性与值产生关联
        objc_setAssociatedObject(self, DNPlaceholderColorKey, dn_placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (UIColor *)dn_placeholderColor {
    
    return objc_getAssociatedObject(self, DNPlaceholderColorKey);
}

- (void)setDn_maxHeight:(CGFloat)dn_maxHeight {
    
    CGFloat max = dn_maxHeight;
    
    // 如果传入的最大高度小于textView本身的高度，则让最大高度等于本身高度
    if (dn_maxHeight < self.frame.size.height) {
        max = self.frame.size.height;
    }
    
    objc_setAssociatedObject(self, DNTextViewMaxHeightKey, [NSString stringWithFormat:@"%lf", max], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGFloat)dn_maxHeight {
    
    return [objc_getAssociatedObject(self, DNTextViewMaxHeightKey) doubleValue];
}

- (void)setDn_minHeight:(CGFloat)dn_minHeight {
    
    objc_setAssociatedObject(self, DNTextViewMinHeightKey, [NSString stringWithFormat:@"%lf", dn_minHeight], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGFloat)dn_minHeight {
    return [objc_getAssociatedObject(self, DNTextViewMinHeightKey) doubleValue];
}

- (void)setDn_textViewHeightDidChanged:(textViewHeightDidChangedBlock)dn_textViewHeightDidChanged {
    
    objc_setAssociatedObject(self, DNTextViewHeightDidChangedBlockKey, dn_textViewHeightDidChanged, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (textViewHeightDidChangedBlock)dn_textViewHeightDidChanged {
    
    void(^textViewHeightDidChanged)(CGFloat currentHeight) = objc_getAssociatedObject(self, DNTextViewHeightDidChangedBlockKey);
    return textViewHeightDidChanged;
}

- (NSArray *)dn_getImages {
    
    return self.dn_imageArray;
}

- (void)setLastHeight:(CGFloat)lastHeight {
    
    objc_setAssociatedObject(self, DNTextViewLastHeightKey, [NSString stringWithFormat:@"%lf", lastHeight], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGFloat)lastHeight {
    
    return [objc_getAssociatedObject(self, DNTextViewLastHeightKey) doubleValue];
}

- (void)setDn_imageArray:(NSMutableArray *)dn_imageArray {
    
    objc_setAssociatedObject(self, DNTextViewImageArrayKey, dn_imageArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)dn_imageArray {
    
    return objc_getAssociatedObject(self, DNTextViewImageArrayKey);
}

- (void)setDn_maxLength:(NSInteger)dn_maxLength {
    
    NSNumber *number = [NSNumber numberWithInteger:dn_maxLength];
    objc_setAssociatedObject(self, DNTextViewMaxLengthKey, number, OBJC_ASSOCIATION_ASSIGN);
    
    self.maxLengthLabel.text = [NSString stringWithFormat:@"0/%ld", dn_maxLength];
}

- (NSInteger)dn_maxLength {
    
    NSNumber *number = objc_getAssociatedObject(self, DNTextViewMaxLengthKey);
    return number.integerValue;
}

- (UILabel *)maxLengthLabel {
    
    UILabel *dn_maxLengthLabel = objc_getAssociatedObject(self, DNTextViewMaxLengthLabelKey);
    if (!dn_maxLengthLabel) {
        dn_maxLengthLabel = [[UILabel alloc] init];
        dn_maxLengthLabel.font = self.font;
        dn_maxLengthLabel.textColor = UIColor.redColor;
        dn_maxLengthLabel.textAlignment = 2;
        
        dn_maxLengthLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:dn_maxLengthLabel];
        [NSLayoutConstraint activateConstraints:@[[NSLayoutConstraint constraintWithItem:dn_maxLengthLabel
                                                                               attribute:NSLayoutAttributeBottom
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self
                                                                               attribute:NSLayoutAttributeBottom
                                                                              multiplier:1.0
                                                                                constant:-12],
                                                  [NSLayoutConstraint constraintWithItem:dn_maxLengthLabel
                                                                               attribute:NSLayoutAttributeTrailing
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self
                                                                               attribute:NSLayoutAttributeTrailing
                                                                              multiplier:1.0
                                                                                constant:-12]]];
        
        objc_setAssociatedObject(self, DNTextViewMaxLengthLabelKey, dn_maxLengthLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dn_maxLengthLabel;
}

- (void)dn_autoHeightWithMaxHeight:(CGFloat)maxHeight {
    
    [self dn_autoHeightWithMaxHeight:maxHeight textViewHeightDidChanged:^(CGFloat currentTextViewHeight) {
        
    }];
}


#pragma mark - addImage
/* 添加一张图片 */
- (void)dn_addImage:(UIImage *)image {
    
    [self dn_addImage:image size:CGSizeZero];
}

/* 添加一张图片 image:要添加的图片 size:图片大小 */
- (void)dn_addImage:(UIImage *)image size:(CGSize)size {
    
    [self dn_insertImage:image size:size index:self.attributedText.length > 0 ? self.attributedText.length : 0];
}

/* 插入一张图片 image:要添加的图片 size:图片大小 index:插入的位置 */
- (void)dn_insertImage:(UIImage *)image size:(CGSize)size index:(NSInteger)index {
    
    [self dn_addImage:image size:size index:index multiple:-1];
}

/* 添加一张图片 image:要添加的图片 multiple:放大／缩小的倍数 */
- (void)dn_addImage:(UIImage *)image multiple:(CGFloat)multiple {
    
    [self dn_addImage:image size:CGSizeZero index:self.attributedText.length > 0 ? self.attributedText.length : 0 multiple:multiple];
}

/* 插入一张图片 image:要添加的图片 multiple:放大／缩小的倍数 index:插入的位置 */
- (void)dn_insertImage:(UIImage *)image multiple:(CGFloat)multiple index:(NSInteger)index {
    
    [self dn_addImage:image size:CGSizeZero index:index multiple:multiple];
}

/* 插入一张图片 image:要添加的图片 size:图片大小 index:插入的位置 multiple:放大／缩小的倍数 */
- (void)dn_addImage:(UIImage *)image size:(CGSize)size index:(NSInteger)index multiple:(CGFloat)multiple {
    if (image) [self.dn_imageArray addObject:image];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = image;
    CGRect bounds = textAttachment.bounds;
    if (!CGSizeEqualToSize(size, CGSizeZero)) {
        bounds.size = size;
        textAttachment.bounds = bounds;
    } else if (multiple <= 0) {
        CGFloat oldWidth = textAttachment.image.size.width;
        CGFloat scaleFactor = oldWidth / (self.frame.size.width - 10);
        textAttachment.image = [UIImage imageWithCGImage:textAttachment.image.CGImage scale:scaleFactor orientation:UIImageOrientationUp];
    } else {
        bounds.size = image.size;
        textAttachment.bounds = bounds;
    }
    
    NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [attributedString replaceCharactersInRange:NSMakeRange(index, 0) withAttributedString:attrStringWithImage];
    self.attributedText = attributedString;
    [self textViewTextChange];
    [self refreshPlaceholderView];
}

#pragma mark - KVO监听属性改变
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    [self refreshPlaceholderView];
    if ([keyPath isEqualToString:@"text"]) [self textViewTextChange];
}

// 刷新PlaceholderView
- (void)refreshPlaceholderView {
    
    UITextView *placeholderView = objc_getAssociatedObject(self, DNPlaceholderViewKey);
    // 如果有值才去调用，这步很重要
    if (placeholderView) {
        CGRect frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        self.dn_placeholderView.frame = frame;
        if (self.dn_maxHeight < self.bounds.size.height) self.dn_maxHeight = self.bounds.size.height;
        self.dn_placeholderView.font = self.font;
        self.dn_placeholderView.textAlignment = self.textAlignment;
        self.dn_placeholderView.textContainerInset = self.textContainerInset;
        self.dn_placeholderView.hidden = (self.text.length > 0 && self.text);
    }
}

// 是否启用自动高度，默认为NO
static bool autoHeight = NO;

- (void)dn_autoHeightWithMaxHeight:(CGFloat)maxHeight textViewHeightDidChanged:(textViewHeightDidChangedBlock)textViewHeightDidChanged {
    autoHeight = YES;
    [self dn_placeholderView];
    self.dn_maxHeight = maxHeight;
    if (textViewHeightDidChanged) self.dn_textViewHeightDidChanged = textViewHeightDidChanged;
}

// 处理文字改变
- (void)textViewTextChange {
    UITextView *placeholderView = objc_getAssociatedObject(self, DNPlaceholderViewKey);
    
    // 如果有值才去调用，这步很重要
    if (placeholderView) {
        self.dn_placeholderView.hidden = (self.text.length > 0 && self.text);
    }
    // 如果没有启用自动高度，不执行以下方法
    if (!autoHeight) return;
    if (self.dn_maxHeight >= self.bounds.size.height) {
        // 计算高度
        NSInteger currentHeight = ceil([self sizeThatFits:CGSizeMake(self.bounds.size.width, MAXFLOAT)].height);
        
        // 如果高度有变化，调用block
        if (currentHeight != self.lastHeight) {
            // 是否可以滚动
            self.scrollEnabled = currentHeight >= self.dn_maxHeight;
            CGFloat currentTextViewHeight = currentHeight >= self.dn_maxHeight ? self.dn_maxHeight : currentHeight;
            // 改变textView的高度
            if (currentTextViewHeight >= self.dn_minHeight) {
                CGRect frame = self.frame;
                frame.size.height = currentTextViewHeight;
                self.frame = frame;
                // 调用block
                if (self.dn_textViewHeightDidChanged) self.dn_textViewHeightDidChanged(currentTextViewHeight);
                // 记录当前高度
                self.lastHeight = currentTextViewHeight;
            }
        }
    }
    if (!self.isFirstResponder) [self becomeFirstResponder];
}

// 判断是否有placeholder值，这步很重要
- (BOOL)placeholderExist {
    // 获取对应属性的值
    UITextView *placeholderView = objc_getAssociatedObject(self, DNPlaceholderViewKey);
    // 如果有placeholder值
    if (placeholderView) return YES;
    
    return NO;
}
@end
