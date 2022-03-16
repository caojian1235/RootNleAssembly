//
//  YJLoadingView.m
//  YiJiYou
//
//  Created by 灵恩 on 2021/3/3.
//

#import "YJLoadingView.h"
#import "Masonry.h"
#import "YSKDefineMacro.h"
@implementation YJLoadingView

- (CGSize)intrinsicContentSize {
    CGFloat height = AUTO_MARGIN(150);
    CGFloat width = AUTO_MARGIN(150);
    return CGSizeMake(width, height);
}



@end
