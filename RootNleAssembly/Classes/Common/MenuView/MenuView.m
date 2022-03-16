//
//  MenuView.m
//  YiShangKe
//
//  Created by ssjt on 2021/6/25.
//

#import "MenuView.h"
#import "XHPageControl.h"
#import "YSKDefineMacro.h"
#import "YYKit.h"
#import "Masonry.h"
#import "SDWebImage.h"
@interface MenuView ()<UIScrollViewDelegate,XHPageControlDelegate>

@property (strong ,nonatomic)UIScrollView *scrollView;

@property (strong ,nonatomic)XHPageControl *pageControl;

@property (assign ,nonatomic)BOOL isUrl;

@end

@implementation MenuView


- (instancetype)initWithRowNumber:(NSInteger)rowNumber colNumber:(NSInteger)colNumber frame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.rowNumber = rowNumber;
        self.colNumber = colNumber;
    }
    return self;
}


- (void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    if ([dataDic[@"image"] count] == 0) {
        return;
    }
    if ([dataDic[@"image"][0] rangeOfString:@"http:"].location != NSNotFound || [dataDic[@"image"][0] rangeOfString:@"https:"].location != NSNotFound) {
        self.isUrl = YES;
    }else{
        self.isUrl = NO;
    }
    [self setUI];
}


- (void)setUI{
    
    
    [self.scrollView removeAllSubviews];
    if (self.rowNumber == 0) {
        return;
    }
    
    NSInteger contSizeX = 0;
    NSArray * imageArray = _dataDic[@"image"];
    NSArray * titleArray = _dataDic[@"title"];
    if (imageArray.count != titleArray.count) {
        return ;
    }else if (imageArray == nil || titleArray == nil){
        return;
    }
//    CGFloat count = imageArray.count;
//    CGFloat rowNumber = self.rowNumber;
//    if (count  / rowNumber > (imageArray.count / self.rowNumber)) {
//         contSizeX = (imageArray.count / self.rowNumber)+1 ;
//    }else{
//         contSizeX = (imageArray.count / self.rowNumber);
//    }
    contSizeX = imageArray.count / (self.rowNumber * self.colNumber);
    
    if (contSizeX >= 2){
        self.scrollView.contentSize = CGSizeMake(self.frame.size.width * contSizeX, self.frame.size.height - AUTO_MARGIN(20) );
       
    }else{
        self.scrollView.contentSize = CGSizeMake(self.frame.size.width * contSizeX, self.frame.size.height );
       
    }
    
     self.pageControl.numberOfPages = contSizeX;
    CGFloat width = self.frame.size.width / self.rowNumber;
    CGFloat height;
    if(contSizeX == 1 && self.colNumber == 1){
        height = self.frame.size.height - AUTO_MARGIN(20) ;
        self.pageControl.hidden = YES;
        self.scrollView.scrollEnabled = NO;
    }else{
         height = ((self.frame.size.height - AUTO_MARGIN(20) ) / self.colNumber);
        
        if (contSizeX == 1) {
            self.pageControl.hidden = YES;
            self.scrollView.scrollEnabled = NO;
        }else{
            self.scrollView.scrollEnabled = YES;
            self.pageControl.hidden = NO;
        }
    }
   
    CGFloat y = 0;
    int row = 0;
    int col = 0;
    NSInteger plusNum = 1;
    NSInteger colRow = 1;
    for (int i = 0; i < imageArray.count; i++) {
        CGFloat x = 0;
        col = i % self.rowNumber;
        
        row = i / self.rowNumber;
        if(self.colNumber == 1){
            
            if (row >= 1) {
                if ( i % self.rowNumber == 0) {
                    plusNum +=1;
                    colRow = colRow *2;
                    
                }
                row = 0;
                x += self.frame.size.width * (plusNum-1);
            }
            
        }
        
        if(self.colNumber > 1){
            if(row >= 2){
                if (row  %2 == 0 && row >= colRow *2) {
                    plusNum +=1;
                    colRow = colRow *2;
                }
                row = row%2;
                x += self.frame.size.width * (plusNum-1);
            }
        }
        
        y = row * height;
        x = x + (col * width);
        
        
        UIButton * btn = UIButton.new;
        btn.tag = i;
        [self.scrollView addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(x);
            make.top.mas_equalTo(y);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(height);
        }];
        
        UIImageView * image = UIImageView.new;
        
        if (self.isMask) {
            image.layer.masksToBounds = YES;
            image.layer.cornerRadius = (self.ImageHeight?: AUTO_MARGIN(76))/2;
            
        }
        
        
        if (self.isUrl) {
            image.clipsToBounds = YES;
            image.contentMode = UIViewContentModeScaleAspectFill;
            [image sd_setImageWithURL:imageArray[i]  placeholderImage:IMAGE(@"noImage")];
            
        }else{
            image.image = [UIImage imageNamed:imageArray[i]]? :[UIImage imageNamed:@"m_empty"];
        }
       
       
        [btn addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(self.topImage ?:AUTO_MARGIN(18));
            make.width.mas_equalTo(self.ImageWidth?: AUTO_MARGIN(76));
            make.height.mas_equalTo(self.ImageHeight?: AUTO_MARGIN(76));
        }];
        
        UILabel * titleLabel = UILabel.new;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = titleArray[i];
        titleLabel.font = self.titleFont?:AUTO_SYSTEM_FONT_SIZE(24);
        titleLabel.textColor = self.titleColor?:UIColor.blackColor;
        [btn addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo (0);
            make.left.right.inset(AUTO_MARGIN(10));
            make.top.mas_equalTo(image.mas_bottom).offset(self.topTitle?:AUTO_MARGIN(12));
        }];
    }
    
}
- (void)setDatas:(NSArray *)datas{
    
    _datas = datas;
    
}

-(void)xh_PageControlClick:(XHPageControl*)pageControl index:(NSInteger)clickIndex{
    
    
    
    
}



- (XHPageControl *)pageControl{
    
    if (_pageControl == nil) {
        
        [self.scrollView.superview layoutIfNeeded];
        
        _pageControl = [[XHPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) - AUTO_MARGIN(20), SCREEN_W, AUTO_MARGIN(20))];
        //设置点的总个数
        _pageControl.numberOfPages = 4;
        //设置非选中点的宽度是高度的倍数(设置长条形状)
        _pageControl.otherMultiple = 2;
        //设置选中点的宽度是高度的倍数(设置长条形状)
        _pageControl.currentMultiple = 4;
        //设置样式.默认居中显示
        _pageControl.type = PageControlMiddle;
        //非选中点的颜色
        _pageControl.otherColor = [COMMOM_GREEN_COLOR colorWithAlphaComponent:0.22];
        //选中点的颜色
        _pageControl.currentColor = COMMOM_GREEN_COLOR;
        //代理
        _pageControl.delegate = self;
        //标记
        _pageControl.tag = 902;
        [self addSubview:_pageControl];
        
    }
    return _pageControl;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    _pageControl.currentPage = offset.x / (self.bounds.size.width);
}


- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.layer.masksToBounds = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator  = NO;
        _scrollView.alwaysBounceHorizontal = YES;
        _scrollView.alwaysBounceVertical  = NO;
        [self addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.top.mas_equalTo(0);
         
        }];
    }
    return _scrollView;
}

- (void)btnClick:(UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(btnShopLaterClick:)]) {
        [self.delegate btnShopLaterClick:sender.tag];
    }
    
}



@end
