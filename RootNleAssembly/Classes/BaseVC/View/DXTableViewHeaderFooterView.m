//
//  DXTableViewHeaderFooterView.m
//  LaiDianXiu
//
//  Created by ssjt on 2021/12/8.
//

#import "DXTableViewHeaderFooterView.h"

@implementation DXTableViewHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self yd_setupViews];
        [self yd_bindViewModel];
    }
    return self;
}

- (void)yd_setupViews{}

- (void)yd_bindViewModel{
    
}


@end
