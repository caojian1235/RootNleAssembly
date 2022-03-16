//
//  DXTableViewCell.m
//  LaiDianXiu
//
//  Created by ssjt on 2021/12/8.
//

#import "DXTableViewCell.h"
#import "DXViewModel.h"
#import "YKBaseViewController.h"
@implementation DXTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withModel:(id<DXViewModelProtocol>)viewModel{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self yd_setupViews];
       
    }
    return self;
}


- (void)yd_setupViews{}
@end
