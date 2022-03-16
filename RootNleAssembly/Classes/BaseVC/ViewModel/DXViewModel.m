//
//  DXViewModel.m
//  LaiDianXiu
//
//  Created by ssjt on 2021/12/7.
//

#import "DXViewModel.h"
@implementation DXViewModel

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    
    DXViewModel *viewModel = [super allocWithZone:zone];
    
    if (viewModel) {
        
        [viewModel yd_initialize];
    }
    return viewModel;
}

- (instancetype)initWithModel:(id)model {
    
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)yd_initialize{
    
    
}

- (RACSubject *)refreshUISubject{
    
    if (!_refreshUISubject) {
        _refreshUISubject = [RACSubject new];
    }
    return _refreshUISubject;
    
}

- (RACSubject *)refreshRequestSubeject{
    
    if (!_refreshRequestSubeject) {
        _refreshRequestSubeject = RACSubject.new;
    }
    return _refreshRequestSubeject;
    
}





@end
