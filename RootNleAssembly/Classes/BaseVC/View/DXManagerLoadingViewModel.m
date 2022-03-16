//
//  DXManagerLoadingViewModel.m
//  LaiDianXiu
//
//  Created by ssjt on 2021/12/9.
//

#import "DXManagerLoadingViewModel.h"


static DXManagerLoadingViewModel *loading = nil;
@implementation DXManagerLoadingViewModel

+ (instancetype)shareInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!loading) {
            loading = [[self alloc] init];
        }
    });
    return loading;
}







@end
