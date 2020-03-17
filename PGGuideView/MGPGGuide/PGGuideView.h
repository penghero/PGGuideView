//
//  PGGuideVC.h
//  
//
//  Created by pgg on 2020/3/6.
//  Copyright © 2020 Coder3. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PGGuideItem;
NS_ASSUME_NONNULL_BEGIN


@class PGGuideView;
/// 引导代理
@protocol PGGuideViewDelegate <NSObject>

/// 引导数据个数
/// @param guideView guideView description
- (NSInteger)numberOfGuidesInGuideView:(PGGuideView *)guideView;

/// 每个引导数据的显示的详细内容
/// @param guideView guideView description
/// @param index index description
- (PGGuideItem *)guideView:(PGGuideView *)guideView itemForGuideAtIndex:(NSUInteger)index;

/// 点击事件
/// @param guideView guideView description
/// @param index index description
- (void)guideViewDidSelect:(PGGuideView *)guideView AtIndex:(NSUInteger)index;

/// 引导结束
/// @param guideView  guideView description
- (void)guideViewEnd:(PGGuideView *)guideView;

@end

/// pgg引导管理类
@interface PGGuideView : UIView

/// 代理
@property(nonatomic, weak) id<PGGuideViewDelegate> delegate;
/// 初始化
+ (void)showsInViewController:(UIViewController<PGGuideViewDelegate> *)viewController;
/// 显示方法
- (void)showGuideAtIndex:(NSInteger)index;
/// 当前位置
@property(nonatomic, assign) NSInteger currentIndex;

@end

NS_ASSUME_NONNULL_END
