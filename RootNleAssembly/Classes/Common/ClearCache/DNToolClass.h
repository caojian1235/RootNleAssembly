//
//  DNToolClass.h
//  Where
//
//  Created by zjs on 2020/1/10.
//  Copyright © 2020 子说. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DNToolClass : NSObject

/// 缓存大小
+ (NSString *)dn_getCachesSize;

/// 清除缓存
+ (void)dn_removeCache:(void(^)(BOOL finished, NSString *casheSize))finish;

+ (NSString *)dn_getShortVersion;
@end

NS_ASSUME_NONNULL_END
