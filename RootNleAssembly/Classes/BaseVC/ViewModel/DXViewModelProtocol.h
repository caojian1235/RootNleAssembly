//
//  DXViewModelProtocol.h
//  LaiDianXiu
//
//  Created by ssjt on 2021/12/7.
//

typedef enum : NSUInteger {
    LSHeaderRefresh_HasMoreData = 1,
    LSHeaderRefresh_HasNoMoreData,
    LSFooterRefresh_HasMoreData,
    LSFooterRefresh_HasNoMoreData,
    LSRefreshError,
    LSRefreshUI,
} LSRefreshDataStatus;

@protocol DXViewModelProtocol <NSObject>

@optional

- (instancetype)initWithModel:(id)model;


- (void)yd_initialize;


 


@end


