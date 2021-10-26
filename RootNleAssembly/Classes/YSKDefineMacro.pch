//
//  YSKDefineMacro.pch
//  YiShangKe
//
//  Created by ssjt on 2021/6/3.
//

#ifndef YSKDefineMacro_pch
#define YSKDefineMacro_pch

//#define HOST          @"http://test.ssedr.com/api/" /// 线上服务器
//#define HOST          @"http://192.168.0.122/api/" /// 测试服务器


//#define htmlURL          @"http://192.168.0.123:8085/#/" /// 本地服务器
//#define htmlURL          @"http://h5.ssedr.com/h5/index.html#" /// 线上服务器
//#define HealthService @"https://ahcc.sd12320.gov.cn:4431/passService"//健康码相关接口ip端口

#define url(url) [HOST stringByAppendingString:url]

#define html(url) [htmlURL stringByAppendingString:url]

// 国际化
#define Localized(name) NSLocalizedString(name, nil)

#define MAINWINDOW  UIApplication.sharedApplication.keyWindow



#define USERCODE                   @"userCode"//用户code
#define CHANNELID                  @"channelID"//通道编码
#define SOCKETISCONNECT            @"socketIsConnect"//连接成功
#define RECEIVEMSGRELOADVIEW       @"receiveMsgReloadView"//接收到消息，刷新页面
#define RECEIVEMSGRELOADCHATVIEW   @"receiveMsgReloadChatView"//接收到消息，刷新页面
#define RECEIVEMSGRELOADGROUPCHATVIEW @"receiveMsgReloadGroupView"//接受到消息，刷新group numbers

#define IsReadingPath           [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/IsReading.plist"]//某个文件已读路径
#define ChatLogDir              [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:[DNBaseUserInfo shareUserInfo].memberCode] //当前人的聊天文件夹

#define kPlayerViewHeight (SCREEN_W * 9 / 16.0)

// weak 弱引用
#define DNWeak(name)      __weak typeof(name) weak##name = name;

// 图片
#define IMAGE(name)       [UIImage imageNamed:name]


#define NOTIFICENTER      [NSNotificationCenter defaultCenter]

// 颜色
#define kColorWithHex(rgbValue)  [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]
#define RGBA(r, g, b, a)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGB(r, g , b)      [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

//tabbarColor
#define TabBarCommomColor       RGB(172, 176, 183);
#define TabBarSelectedColor     RGB( 17, 200, 106);

#define COMMOM_GREEN_COLOR    RGB(17, 200 , 106)
#define COMMOM_YELLOW_COLOR   RGB(195, 159 , 98)

#define COMMOM_GRAY_COLOR          RGB(153, 153 , 153)
#define COMMOM_BLACK_COLOR         RGB(51, 51 , 51)
#define COMMOM_GRAYLIGHT_COLOR     RGB(102, 102 , 102)

#define MAIN_BLUE_COLOR    kColorWithHex(0x0095FE)
#define MAIN_YELLOW_COLOR  kColorWithHex(0xFFCC00)
#define MAIN_BLACK_COLOR_3 kColorWithHex(0x333333)
#define MAIN_BLACK_COLOR_6 kColorWithHex(0x666666)
#define MAIN_BLACK_COLOR_9 kColorWithHex(0x999999)
#define SYB_MAIN_RED_COLOR     kColorWithHex(0xFF586A)
#define SYB_MAIN_BLACK_COLOR_3 kColorWithHex(0x333333)
#define SYB_MAIN_BLACK_COLOR_6 kColorWithHex(0x666666)
#define SYB_MAIN_BLACK_COLOR_9 kColorWithHex(0x999999)
// 颜色
#define colorHex(hex) [UIColor colorWithHexString:hex]

#define backColor colorHex(@"FFFEFA")
//
#define mainColor colorHex(@"BA7A48")
//#define


// 屏幕宽高
#define SCREEN_W    [UIScreen mainScreen].bounds.size.width
#define SCREEN_H    [UIScreen mainScreen].bounds.size.height
#define SCREEN_S    (SCREEN_W/750.0)
#define REM [UIScreen mainScreen].bounds.size.width/10

#define KNOTIFICATIONNAME_PAYSUCCESS @"paySuccess"
#define KNOTIFICATIONNAME_CANCLE_ORDER @"cancleOrder"
#define KNOTIFICATIONNAME_PAY_ERROR @"payeError"

// 自适应字体大小
#define AUTO_FONT_SIZE(size)           size*(SCREEN_W/375)
#define AUTO_SYSTEM_FONT_SIZE(size)    [UIFont systemFontOfSize:AUTO_FONT_SIZE(size)]
#define mfont(size)    [UIFont systemFontOfSize:size]
#define mFontCoarse(font) [UIFont fontWithName:@"Helvetica-Bold" size:font];
#define PFM_Font(font)       [UIFont fontWithName:@"PingFangSC-Semibold" size:font];

// 自适应边距
#define AUTO_MARGIN(margin)            margin*(SCREEN_W/375)

// 刘海屏适配判断
#define iPhone_X ((UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone) && (UIApplication.sharedApplication.statusBarFrame.size.height > 20.0))

// iPhone4S
#define iPhone_4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] currentMode].size) : NO)

// 状态栏高度
#define STATUS_H          UIApplication.sharedApplication.statusBarFrame.size.height
#define STATUS_BAR_HEIGHT (iPhone_X ? 44.f : 20.f)

// 导航栏高度
#define NAV_BAR_HEIGHT        (STATUS_H + 44)
#define NAVIGATION_BAR_HEIGHT (iPhone_X ? 88.f : 64.f)


// tabBar高度
#define TAB_BAR_HEIGHT  self.tabBarController.tabBar.frame.size.height


#define kIs_iphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kIs_iPhoneX SCREEN_W >=375.0f && SCREEN_H >=812.0f&& JH_isPad ?YES: NO


#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
//判断iPhoneX
#define IS_IPHONE_X (JH_isPad ?YES: NO && SCREEN_MAX_LENGTH >= 812.0 )
//判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !JH_isPad : NO)
//判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !JH_isPad : NO)
//判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !JH_isPad : NO)

//判断iPhone12_Mini
#define IS_IPHONE_12_Mini ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1080, 2340), [[UIScreen mainScreen] currentMode].size) && !JH_isPad : NO)

//判断iPhone12 | 12Pro
#define IS_IPHONE_iPhone12 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1170, 2532), [[UIScreen mainScreen] currentMode].size) && !JH_isPad : NO)

//判断iPhone12 Pro Max
#define IS_iPhone12_ProMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1284, 2778), [[UIScreen mainScreen] currentMode].size) && !JH_isPad : NO)

#define IS_iPhoneSE ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !JH_isPad : NO)

// 判断是否是ipad
#define JH_isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

    
/*状态栏高度*/
#define kStatusBarHeight (CGFloat)(iPhone_X?(44.0):(20.0))
/*导航栏高度*/
#define kNavBarHeight (44)
/*状态栏和导航栏总高度*/
#define kNavBarAndStatusBarHeight (CGFloat)(iPhone_X?(88.0):(64.0))
/*TabBar高度*/
#define kTabBarHeight (CGFloat)(iPhone_X?(49.0 + 34.0):(49.0))
/// 底部tabbarbar 和安全区域
#define KTabBarAndBottomHeight (kTabBarHeight + kBottomSafeHeight)

/*顶部安全区域远离高度*/
#define kTopBarSafeHeight (CGFloat)(iPhone_X?(44.0):(0))
 /*底部安全区域远离高度*/
#define kBottomSafeHeight (CGFloat)(iPhone_X?(34.0):(0))
/*iPhoneX的状态栏高度差值*/
#define kTopBarDifHeight (CGFloat)(iPhone_X?(24.0):(0))
/*导航条和Tabbar总高度*/
#define kNavAndTabHeight (kNavBarAndStatusBarHeight + kTabBarHeight)




// home indicator
#define HOME_INDICATOR_HEIGHT (iPhone_X ? 34.f : 0.f)


#ifdef DEBUG
#define NSLogError(FORMAT, ...) fprintf(stderr,"[%s:%d]【❌】\t %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#define NSLogWarn(FORMAT, ...) fprintf(stderr,"[%s:%d]【⚠️】\t %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#define NSLogInfo(FORMAT, ...) fprintf(stderr,"[%s:%d]【✅】\t %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#define DNLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);

#else

#define NSLogError(...);

#define NSLogWarn(...);

#define NSLogInfo(...);

#define DNLog(...);

#endif

#define DNullStr(string) ((![string isKindOfClass:[NSString class]]) || [string isEqualToString:@""] || (string == nil) || [string isKindOfClass:[NSNull class]] || [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0 || [string isEqual:@"NULL"] ||  [string isEqual:NULL] || [[string class] isSubclassOfClass:[NSNull class]] || string == NULL || [string isEqualToString:@"<null>"] || [string isEqualToString:@"(null)"])

#ifndef weakify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
            #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
            #define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif

#ifndef strongify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
            #define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
            #define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


#define IOS11_OR_LATER_SPACE(par) \
({\
float space = 0.0;\
if (@available(iOS 11.0, *))\
space = par;\
(space);\
})

// safeArea 底部空白高度
#define SAFEAREA_BOTTOM_SPACE IOS11_OR_LATER_SPACE([[UIApplication sharedApplication].windows.firstObject safeAreaInsets].bottom)
// safeArea 状态栏高度
#define SAFEAREA_TOP_SPACE IOS11_OR_LATER_SPACE([[UIApplication sharedApplication].windows.firstObject safeAreaInsets].top)
// safeArea 状态栏增加的高度
#define SAFEAREA_TOP_ACTIVE_SPACE IOS11_OR_LATER_SPACE(MAX(0, SAFEAREA_TOP_SPACE - 20))

// 导航栏高度
#define NAVIGATION_BAR_HEIGHT (64.f + SAFEAREA_TOP_ACTIVE_SPACE)

//定义枚举类型
typedef enum _SKYState {
    oneCollectionView  = 0,
    twoCollectionView,
} tipContentViewModel;

#endif /* YSKDefineMacro_pch */
