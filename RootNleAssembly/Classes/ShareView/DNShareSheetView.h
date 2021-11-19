//
//  DNShareSheetView.h
//  Where
//
//  Created by zjs on 2019/12/27.
//  Copyright © 2019 子说. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DNShareSheetView : UIView

///初始化
- (void)setData:(NSDictionary *)data colNum:(NSInteger)colNumer;
///每行几个
@property (nonatomic , assign) NSInteger colNumer;

/// "image":[图片] , "title":[标题]
@property (nonatomic , strong) NSDictionary * data;
@property (nonatomic, copy) NSString *shareUrl;
@property (nonatomic, copy) NSString *pengyouquanUrl;
@property (nonatomic, copy) NSString *shareDes;
@property (nonatomic, copy) NSString *merchantName;
@property (nonatomic, strong) UIImage *shareImage;
@property (nonatomic, assign) BOOL isSaveImage;
- (void)showShareView;
@end

NS_ASSUME_NONNULL_END
