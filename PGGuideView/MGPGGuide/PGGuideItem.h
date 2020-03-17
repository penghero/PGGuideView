//
//  PGGuideItem.h
//  
//
//  Created by pgg on 2020/3/6.
//  Copyright © 2020 Coder3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PGGuideItem : NSObject

/// 是否显示气泡中头像icon
@property (nonatomic, assign) BOOL isShowIcon;
/// 气泡颜色
@property (nonatomic, strong) UIColor *bubbleColor;
/// 气泡文字颜色
@property (nonatomic, strong) UIColor *textColor;
/// 设置>0 才有边框 不设置 不显示边框
@property (nonatomic, assign) CGFloat borderWidth;
/// 镂空的frame 一处
@property (nonatomic, assign) CGRect frame;
/// 镂空的frame 二处
@property (nonatomic, assign) CGRect frameOther;
/// 气泡中的内容
@property (nonatomic, strong) NSString *title;
/// 气泡位置 是否在镂空部分上面显示 NO在上方 YES 在下方
@property (nonatomic, assign) BOOL isTop;
/// 镂空的圆角 一处
@property (nonatomic, assign) CGFloat cornerRadius;
/// 镂空的圆角 二处
@property (nonatomic, assign) CGFloat cornerRadiusOther;
/// 是否显示镂空部分红边 默认NO
@property (nonatomic, assign) BOOL isShowRed;
/// 是否显示镂空部分闪动动画
@property (nonatomic, assign) BOOL isShowFlash;
/// 点击区域  0全屏 1镂空区域
@property (nonatomic, strong) NSString *clickType;
/// 是否有两处镂空 默认NO
@property (nonatomic, assign) BOOL isShowOtherFrame;
/// 光圈颜色
@property (nonatomic, strong) UIColor *aperturesColor;
/// 光圈宽度
@property (nonatomic, assign) CGFloat aperturesWidth;
/// 光圈距离
@property (nonatomic, assign) CGFloat aperturesMargin;
/// 光圈圆角
@property (nonatomic, assign) CGFloat aperturesRadius;

@end

NS_ASSUME_NONNULL_END
