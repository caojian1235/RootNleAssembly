//
//  DXViewModel.h
//  LaiDianXiu
//
//  Created by ssjt on 2021/12/7.
//

#import <Foundation/Foundation.h>
#import "DXViewModelProtocol.h"
#import "ReactiveObjC.h"
NS_ASSUME_NONNULL_BEGIN

@interface DXViewModel : NSObject <DXViewModelProtocol>

@property (nonatomic , strong) NSString * showMessage;
///加载
@property (nonatomic , assign) BOOL       isLoading;

@property (nonatomic , assign) BOOL       isRefresh;

@property (nonatomic , strong) UIColor * loadingColor;

@property (nonatomic , strong) RACSubject *refreshUISubject;

@property (nonatomic , strong) RACSubject *refreshRequestSubeject;





@end

NS_ASSUME_NONNULL_END
