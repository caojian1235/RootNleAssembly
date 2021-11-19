//
//  DNShareSheetView.m
//  Where
//
//  Created by zjs on 2019/12/27.
//  Copyright © 2019 子说. All rights reserved.
//

#import "DNShareSheetView.h"
#import "YSKDefineMacro.pch"
#import "Masonry.h"
#import "UIButton+Extra.h"
#import "Toast.h"
#import "WXApi.h"
#import "YYKit.h"
@interface DNShareSheetView ()

@property (nonatomic, strong) UIView   *contentView;
@property (nonatomic, strong) UIView   *lineView;
@property (nonatomic, strong) UIView   *operationView;

@property (nonatomic, strong) UIButton *friendBtn;
@property (nonatomic, strong) UIButton *circleBtn;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *saveImageBtn;
@end

@implementation DNShareSheetView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupSubviews];
        [self setupConstraints];
    }
    return self;
}

- (void)setupSubviews {
    
    self.contentView = [[UIView alloc] init];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideShareView)]];
    
    self.lineView    = [[UIView alloc] init];
    self.lineView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
    
    self.operationView = [[UIView alloc] init];
    self.operationView.backgroundColor     = UIColor.whiteColor;
    self.operationView.layer.cornerRadius  = 5.f;
    self.operationView.layer.masksToBounds = YES;
    
    self.cancelBtn = [[UIButton alloc] init];
    self.cancelBtn.titleLabel.font     = AUTO_SYSTEM_FONT_SIZE(15);
    self.cancelBtn.backgroundColor     = UIColor.whiteColor;
    self.cancelBtn.layer.cornerRadius  = 5.f;
    self.cancelBtn.layer.masksToBounds = YES;
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:MAIN_BLACK_COLOR_3 forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(hideShareView) forControlEvents:UIControlEventTouchUpInside];
    
    self.friendBtn = [[UIButton alloc] init];
    self.friendBtn.tag = 10086;
    self.friendBtn.titleLabel.font     = AUTO_SYSTEM_FONT_SIZE(14);
    [self.friendBtn setTitle:@"微信" forState:UIControlStateNormal];
    [self.friendBtn setImage:IMAGE(@"mine_share_wechat") forState:UIControlStateNormal];
    [self.friendBtn setTitleColor:MAIN_BLACK_COLOR_3 forState:UIControlStateNormal];
//    [self.friendBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    
    [self.friendBtn addTarget:self action:@selector(shareWechatAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.circleBtn = [[UIButton alloc] init];
    self.circleBtn.tag = 10087;
    self.circleBtn.titleLabel.font     = AUTO_SYSTEM_FONT_SIZE(14);
    [self.circleBtn setTitle:@"朋友圈" forState:UIControlStateNormal];
   
    [self.circleBtn setImage:IMAGE(@"mine_share_circle") forState:UIControlStateNormal];
    [self.circleBtn setTitleColor:MAIN_BLACK_COLOR_3 forState:UIControlStateNormal];
   
    [self.circleBtn addTarget:self action:@selector(shareWechatAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.saveImageBtn = UIButton.new;
    self.saveImageBtn.tag = 10088;
    self.saveImageBtn.titleLabel.font     = AUTO_SYSTEM_FONT_SIZE(14);
    [self.saveImageBtn setTitle:@"保存图片" forState:UIControlStateNormal];
   
    [self.saveImageBtn setImage:IMAGE(@"mine_share_circle") forState:UIControlStateNormal];
    [self.saveImageBtn setTitleColor:MAIN_BLACK_COLOR_3 forState:UIControlStateNormal];
   
    [self.saveImageBtn addTarget:self action:@selector(shareWechatAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setupConstraints {
    
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.leading.bottom.trailing.mas_equalTo(self);
    }];
    
    [self.contentView addSubview:self.cancelBtn];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.trailing.mas_equalTo(self.contentView).inset(AUTO_MARGIN(12));
        make.height.mas_offset(SCREEN_W * 0.12);
        if (@available(iOS 11.0, *)) {
            if (iPhone_X) {
                make.bottom.mas_equalTo(self.contentView.mas_safeAreaLayoutGuideBottom);
            } else {
                make.bottom.mas_equalTo(self.contentView.mas_bottom).inset(AUTO_MARGIN(20));
            }
        } else {
            make.bottom.mas_equalTo(self.contentView.mas_bottom).inset(AUTO_MARGIN(20));
        }
    }];
    
    [self.contentView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.mas_equalTo(self.cancelBtn.mas_top);
        make.leading.trailing.mas_equalTo(self.contentView).inset(AUTO_MARGIN(17));
        make.height.mas_offset(1);
    }];
    
    [self.contentView addSubview:self.operationView];
    [self.operationView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.mas_equalTo(self.lineView.mas_top);
        make.leading.trailing.mas_equalTo(self.cancelBtn);
        make.top.mas_equalTo(self.contentView.mas_top);
    }];
    
//    [self.operationView addSubview:self.friendBtn];
//    [self.friendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.leading.bottom.inset(AUTO_MARGIN(10));
//        make.height.mas_offset(SCREEN_W * 0.2);
//    }];
//
//
//        self.saveImageBtn.hidden = YES;
//        [self.operationView addSubview:self.circleBtn];
//        [self.circleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
////            make.top.bottom.inset(AUTO_MARGIN(10));
////            make.leading.mas_equalTo(self.friendBtn.mas_trailing).mas_offset(AUTO_MARGIN(10));
//            make.top.width.mas_equalTo(self.friendBtn);
//            make.trailing.mas_equalTo(self.operationView.mas_trailing).inset(AUTO_MARGIN(10));
//            make.leading.mas_equalTo(self.friendBtn.mas_trailing).mas_offset(AUTO_MARGIN(10));
//            make.bottom.mas_equalTo(-10);
//
//    //        make.top.width.mas_equalTo(self.friendBtn);
//    //        make.trailing.mas_equalTo(self.operationView.mas_trailing).inset(AUTO_MARGIN(10));
//    //        make.leading.mas_equalTo(self.saveImageBtn.mas_trailing).mas_offset(AUTO_MARGIN(10));
//    //        make.bottom.mas_equalTo(-10);
//        }];
        
//        [self.operationView addSubview:self.saveImageBtn];
//        [self.saveImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//    //        make.top.bottom.inset(AUTO_MARGIN(10));
//    //        make.leading.mas_equalTo(self.friendBtn.mas_trailing).mas_offset(AUTO_MARGIN(10));
//    //        make.height.mas_offset(SCREEN_W * 0.2);
//            make.top.width.mas_equalTo(self.friendBtn);
//            make.trailing.mas_equalTo(self.operationView.mas_trailing).inset(AUTO_MARGIN(10));
//            make.leading.mas_equalTo(self.circleBtn.mas_trailing).mas_offset(AUTO_MARGIN(10));
//            make.bottom.mas_equalTo(-10);
//        }];
       

}

- (void)setData:(NSDictionary *)data colNum:(NSInteger)colNumer{
    
    _data = data;
    
    
    self.colNumer = colNumer;
    if (data == nil) {
        return;
    }
    
    
    
    NSArray * imageData = data[@"image"];
    NSArray * titleData = data[@"title"];
    int row = 0;
    int col = 0;
    CGFloat x = 0.0 ;
    
    
    CGFloat width = (self.frame.size.width - AUTO_MARGIN(24)) / self.colNumer;
    for (int i = 0; i < imageData.count; i++) {
    
        col = i % self.colNumer;
        
        row = i / self.colNumer;
        
        x = x + (col * width);
        
        UIButton * btn = UIButton.new;
        btn.titleLabel.font     = AUTO_SYSTEM_FONT_SIZE(14);
        [btn setTitleColor:MAIN_BLACK_COLOR_3 forState:UIControlStateNormal];
        [btn setImage:IMAGE(imageData[i]) forState:UIControlStateNormal];
        [btn setTitle:titleData[i] forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.operationView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(x);
            make.top.mas_equalTo(row * SCREEN_W *0.2);
            make.height.mas_equalTo(SCREEN_W *0.2);
            make.width.mas_equalTo(width);
        }];
        [btn layoutIfNeeded];
        [btn dn_layoutButtonEdgeInset:DNEdgeInsetStyleTop space:7];
     
        
    }
    
    
    
}

- (void)btnClick:(UIButton *)sender{
    
}

- (void)setIsSaveImage:(BOOL)isSaveImage{
    
    _isSaveImage = isSaveImage;
    
    if (_isSaveImage == YES) {
        self.saveImageBtn.hidden = NO;
    }else{
        self.saveImageBtn.hidden = YES;
    }
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
//    [self.friendBtn layoutIfNeeded];
//    [self.friendBtn dn_layoutButtonEdgeInset:DNEdgeInsetStyleTop space:7];
//
//    [self.circleBtn layoutIfNeeded];
//    [self.circleBtn dn_layoutButtonEdgeInset:DNEdgeInsetStyleTop space:7];
//    [self.saveImageBtn layoutIfNeeded];
//    [self.saveImageBtn dn_layoutButtonEdgeInset:DNEdgeInsetStyleTop space:7];
}

- (void)showShareView {
    
    self.frame = UIScreen.mainScreen.bounds;
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
    [UIApplication.sharedApplication.keyWindow addSubview:self];
    
    self.contentView.transform = CGAffineTransformMakeTranslation(0, SCREEN_H);
    [UIView animateWithDuration:0.35 animations:^{
        
        self.contentView.transform = CGAffineTransformIdentity;
    }];
}


- (void)hideShareView {
    
    [UIView animateWithDuration:0.35 animations:^{
        
        self.contentView.transform = CGAffineTransformMakeTranslation(0, SCREEN_H);
        
    } completion:^(BOOL finished) {
       
        [self removeFromSuperview];
    }];
}

- (void)shareWechatAction:(UIButton *)sender {
    
    if (![WXApi isWXAppInstalled]) {
        [self makeToast:@"当前设备未安装微信" duration:2.0 position:CSToastPositionCenter];
        return;
    }
    
   
//    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
//    [shareParams SSDKSetupShareParamsByText:self.shareDes
//                                         images:[IMAGE(@"mine_aboutUs_logo") dn_compressImage]
//                                            url:[NSURL URLWithString: self.shareUrl]
//                                          title:@"在哪儿"
//                                           type:SSDKContentTypeAuto];
//    SSDKPlatformType type;
//    if (sender.tag == 10087) {
//        NSLog(@"微信朋友圈");
//        type = SSDKPlatformSubTypeWechatTimeline;
//    } else {
//        NSLog(@"微信好友");
//        type = SSDKPlatformSubTypeWechatSession;
//    }
//
//    [ShareSDK share:type
//         parameters:shareParams
//     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
//        switch (state) {
//                   case SSDKResponseStateUpload:
//                       // 分享视频的时候上传回调，进度信息在 userData
//                       break;
//            case SSDKResponseStateSuccess:{
//                [MAINWINDOW makeToast:@"分享成功" duration:2.0 position:CSToastPositionCenter];
//                [self hideShareView];
//            }
//                       //成功
//                       break;
//                   case SSDKResponseStateFail:
//                  {
//                    NSLog(@"--%@",error.description);
//                       [MAINWINDOW makeToast:@"分享失败" duration:2.0 position:CSToastPositionCenter];
//                       //失败
//
//                  }
//                break;
//            case SSDKResponseStateCancel:{
//                 [MAINWINDOW makeToast:@"取消成功" duration:2.0 position:CSToastPositionCenter];
//                [self hideShareView];
//            }
//                       //取消
//                       break;
//
//                   default:
//                       break;
//               }
//    }];
    
    if (self.isSaveImage) {
        
        NSData *imageData = UIImageJPEGRepresentation(self.shareImage, 1);
         
        //1.创建多媒体消息结构体
        WXMediaMessage *mediaMsg = [WXMediaMessage message];
        //2.创建多媒体消息中包含的图片数据对象
        WXImageObject *imgObj = [WXImageObject object];
        //图片真实数据
        imgObj.imageData = imageData;
        //多媒体数据对象
        mediaMsg.mediaObject = imgObj;
        
        //3.创建发送消息至微信终端程序的消息结构体
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        //多媒体消息的内容
        req.message = mediaMsg;
        //指定为发送多媒体消息（不能同时发送文本和多媒体消息，两者只能选其一）
        req.bText = NO;
        //指定发送到会话(聊天界面)
        req.scene   = (sender.tag == 10087);
        //发送请求到微信,等待微信返回onResp
        [WXApi sendReq:req completion:^(BOOL success) {
            [self hideShareView];
        }];
           
        
        return;
    }
    
     
    if (sender.tag == 10087) {
        //朋友圈
         WXWebpageObject *webpageObject = [WXWebpageObject object];
         
             webpageObject.webpageUrl = self.shareUrl;
             WXMediaMessage *message = [WXMediaMessage message];
             message.title       = self.merchantName?:@"医上门";
             message.description = self.shareDes;
             [message setThumbImage:IMAGE(@"60")];
             message.mediaObject = webpageObject;

             SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
             req.bText   = NO;
             req.message = message;
             // 0 好友列表----1 朋友圈-----2 收藏
             req.scene   = (sender.tag == 10087);
             [WXApi sendReq:req completion:^(BOOL success) {

                 [self hideShareView];
             }];
    }else{
        
        //创建多媒体消息结构体
         WXMediaMessage *urlMessage = [WXMediaMessage message];
         urlMessage.title = self.merchantName?:@"医上门";//标题
         urlMessage.description = self.shareDes;//描述
         [urlMessage setThumbImage:[UIImage imageNamed:@"60"]];//设置预览图

         //创建网页数据对象
         WXWebpageObject *webObj = [WXWebpageObject object];
         webObj.webpageUrl = self.shareUrl;//链接
         urlMessage.mediaObject = webObj;

         SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
         sendReq.bText = NO;//不使用文本信息
         sendReq.message = urlMessage;
         sendReq.scene = WXSceneSession;//分享到好友会话

         [WXApi sendReq:sendReq completion:^(BOOL success) {
            NSLog(@"发起分享:%@", success ? @"成功" : @"失败");
         }];
//        //微信
//        WXMiniProgramObject * webpageObject = [WXMiniProgramObject object];
//        webpageObject.webpageUrl = self.shareUrl;//兼容低版本网页链接
////        webpageObject.path       = self.shareUrl;
//        WXMediaMessage *message = [WXMediaMessage message];
//        message.title       = self.merchantName?:@"医上客";
//        message.description = self.shareDes;
////        [message setThumbImage:[IMAGE(@"mine_aboutUs_logo") dn_compressImage]];
//        message.mediaObject = webpageObject;
//        
//        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
//        req.bText   = NO;
//        req.message = message;
//        // 0 好友列表----1 朋友圈-----2 收藏
//        req.scene   = (sender.tag == 10087);
//        [WXApi sendReq:req completion:^(BOOL success) {
//            
//            [self hideShareView];
//        }];
        
    }
   //小程序页面路径
//    webpageObject.hdImageData= @"";//小程序节点高清大图，小于128k
    
   
   
}

- (void)setShareUrl:(NSString *)shareUrl {
    _shareUrl = shareUrl;
}

- (void)setShareDes:(NSString *)shareDes {
    _shareDes = shareDes;
}
@end
