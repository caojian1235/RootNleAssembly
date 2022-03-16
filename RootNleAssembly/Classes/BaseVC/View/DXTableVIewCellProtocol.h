//
//  TableVIewCellProtocol.h
//  LaiDianXiu
//
//  Created by ssjt on 2021/12/8.
//
@protocol DXViewModelProtocol;
@protocol DXTableVIewCellProtocol <NSObject>
@optional

//- (instancetype)initWithViewModel:(id <DXViewModelProtocol>)viewModel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withModel:(id <DXViewModelProtocol>)viewModel;
- (void)yd_setupViews;

@end
