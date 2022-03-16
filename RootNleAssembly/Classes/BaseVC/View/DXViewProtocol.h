//
//  DXViewProtocol.h
//  LaiDianXiu
//
//  Created by ssjt on 2021/12/7.
//


@protocol DXViewModelProtocol;

@protocol DXViewProtocol <NSObject>

@optional

- (instancetype)initWithViewModel:(id <DXViewModelProtocol>)viewModel;

- (void)yd_bindViewModel;
- (void)yd_setupViews;

@end
