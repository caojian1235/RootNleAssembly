//
//  DXView.m
//  LaiDianXiu
//
//  Created by ssjt on 2021/12/7.
//

#import "DXView.h"

@implementation DXView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self yd_setupViews];
        [self yd_bindViewModel];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self yd_setupViews];
        [self yd_bindViewModel];
    }
    return self;
}

- (instancetype)initWithViewModel:(id<DXViewModelProtocol>)viewModel {
    
    self = [super init];
    if (self) {
        
     
    }
    return self;
}

- (void)yd_bindViewModel {
}

- (void)yd_setupViews {
}

@end
