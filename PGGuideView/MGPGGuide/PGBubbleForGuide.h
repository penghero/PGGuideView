//
//  PGBubbleForGuide.h
//  
//
//  Created by pgg on 2020/3/6.
//  Copyright © 2020 Coder3. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_W                 [UIScreen mainScreen].bounds.size.width
#define SCREEN_H                 [UIScreen mainScreen].bounds.size.height
#define kMainWindow              [UIApplication sharedApplication].keyWindow
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define CUSTOM_FONT(float) [UIFont systemFontOfSize:float]

/// 边距
#define kPadding                  5
/// 默认背景色
#define kBubbleViewColor          COLOR(132, 73, 239, 1)
/// 默认边框颜色
#define kBorderColor              COLOR(0, 0, 0, 0)
/// 默认圆角
#define kBubbleViewCornerRadius   10
/// 默认三角形高
#define kBubbleViewTriangleH      12
/// 预留 气泡按钮高
#define kButtonH                  20
/// 老板娘头像宽高
#define kIconImgW                 55


NS_ASSUME_NONNULL_BEGIN

/// pgg引导气泡
@interface PGBubbleForGuide : UIView

/// 气泡颜色
@property (nonatomic, strong) UIColor *bubbleColor;
/// 气泡文字内容
@property (nonatomic, strong) NSString *text;
/// 文字颜色
@property (nonatomic, strong) UIColor *textColor;
/// 设置>0 才有边框 不设置 不显示边框
@property (nonatomic, assign) CGFloat borderWidth;
/// 圆角
@property (nonatomic, assign) CGFloat cornerRadius;
/// 尖角方向
@property (nonatomic, assign) BOOL isArrowAtTop;
/// 头像是否存在 默认不存在NO
@property (nonatomic, assign) BOOL isIconShow;

/// 带老板娘icon的初始化 isIcon YES 有 NO 无
+ (instancetype)viewWithText:(nullable NSString *) text withIsIcon: (BOOL) isIcon;
/// 只有文字的初始化
+ (instancetype)viewWithText:(nullable NSString *) text;
/// 预留 气泡中添加按钮
- (void)addButton:(UIButton *) button;
/// 出现位置
- (void)popAtFrame:(CGRect) frame;

@end

NS_ASSUME_NONNULL_END
