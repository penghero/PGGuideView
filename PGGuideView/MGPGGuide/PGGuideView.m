//
//  PGGuideVC.m
//  
//
//  Created by pgg on 2020/3/6.
//  Copyright © 2020 Coder3. All rights reserved.
//  请务 删除
//  作者github地址： https://github.com/penghero/PGGuideView
#import "PGGuideView.h"
#import "PGBubbleForGuide.h"
#import "PGGuideItem.h"
#import <pthread.h>


@interface PGGuideView ()

@property(nonatomic, strong) CAShapeLayer *maskLayer;
@property(nonatomic, strong) PGBubbleForGuide *bubbleView;

@property(nonatomic, assign) NSInteger AllItemCount;
/// 光圈view
@property(nonatomic, strong) UIView *apertureView;
/// 红边view
@property(nonatomic, strong) UIView *redView;
/// 当前镂空的view1
@property(nonatomic, strong) UIButton *ecrireView;
/// 全屏下一步点击手势
@property(nonatomic, strong) UITapGestureRecognizer *singleTap;
/// 雷达部分点击手势
@property(nonatomic, strong) UITapGestureRecognizer *singleTapOther;


@end

@implementation PGGuideView

#pragma mark - cyle left
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configSubview];
    }
    return self;

}


#pragma mark - private
- (void) configSubview {
    self.userInteractionEnabled = YES;
    
    self.backgroundColor = COLOR(0, 0, 0, 0.7);
    self.currentIndex = 0;
    self.AllItemCount = 0;
    
    dispatch_async_on_main_queue(^{
        [self addSubview:self.bubbleView];
    });

}

//添加光圈
- (void)addAperture:(UIView *)contentView withItem: (PGGuideItem *) item {
    CGRect apertureRect = item.frame;
    NSMutableArray *views = [NSMutableArray array];
    
    for (int i = 2; i >= 0 ; i --) {
        CGFloat margin = Point414(1);
        if (item.aperturesMargin) {
            margin = item.aperturesMargin;
        }
        self.apertureView = UIView.new;
        self.apertureView.userInteractionEnabled = YES;

        self.apertureView.frame = CGRectMake(apertureRect.origin.x+margin*i - margin*i*3 - margin ,apertureRect.origin.y+margin*i - margin*i*3 - margin, apertureRect.size.width-margin*i*2 + margin*i*6 + margin*2, apertureRect.size.height-margin*i*2 + margin*i*6 + margin*2);
        self.apertureView.backgroundColor = UIColor.clearColor;
        self.apertureView.tag = i+10000;
        if (item.aperturesColor) {
            self.apertureView.layer.borderColor = item.aperturesColor.CGColor;
        }else{
            self.apertureView.layer.borderColor = UIColor.yellowColor.CGColor;
        }
        if (item.aperturesWidth) {
            self.apertureView.layer.borderWidth = item.aperturesWidth;
        }else{
            self.apertureView.layer.borderWidth = Point414(1.0);
        }
        if (item.aperturesRadius) {
            self.apertureView.layer.cornerRadius = item.aperturesRadius;
        }else{
            self.apertureView.layer.cornerRadius = Point414(10);
        }
        self.apertureView.clipsToBounds = YES;
        
        if (i == 2) {
            self.apertureView.alpha = .3;
        }else if(i == 1){
            self.apertureView.alpha = .6;
        }else if(i == 0){
            self.apertureView.alpha = 1;
        }
        
        [self.apertureView addGestureRecognizer:self.singleTapOther];
        [contentView addSubview:self.apertureView];
        [views addObject:self.apertureView];
    }
    [self showViews:views];
}

- (void)showViews:(NSArray *)views {
    CGFloat showTime = 0.;
    CGFloat durationTime = 0.3;

    for (int i = 0; i < views.count; i++) {
       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((showTime + durationTime) * i * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           UIView *view = views[i];
           view.alpha = 0;
         
           [UIView animateWithDuration:durationTime animations:^{
               view.hidden = NO;
               if (i == 0) {
                   view.alpha = .3;
               }else if(i == 1){
                   view.alpha = .6;
               }else if(i == 2){
                   view.alpha = 1;
               }
                 
           }completion:^(BOOL finished) {
               if (finished) {
                   if (i == views.count-1) {
                      [self hideViews:views];
                   }
               }
           }];
       });
    }
    
}

- (void)hideViews:(NSArray *)views {
    CGFloat hideTime = 0.;
    CGFloat durationTime = 0.15;

    for (int i = 0; i < views.count; i++) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((hideTime + durationTime) * i * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIView *view = views[i];
            
            if (i == 0) {
                 view.alpha = .3;
             }else if(i == 1){
                 view.alpha = .6;
             }else if(i == 2){
                 view.alpha = 1;
             }
            
            [UIView animateWithDuration:durationTime animations:^{
                view.hidden = YES;
                view.alpha = 0;
            }completion:^(BOOL finished) {
                if (finished) {
                    if (i == views.count-1) {
                        [self showViews:views];
                    }
                }
            }];
        });
    }
}


#pragma mark - public
+ (void)showsInViewController:(UIViewController<PGGuideViewDelegate> *)viewController {
    PGGuideView *guideVC = [[PGGuideView alloc] initWithFrame:kMainWindow.frame];
    [guideVC showsInViewController:viewController];
}

- (void)showsInViewController:(UIViewController<PGGuideViewDelegate> *)viewController {
    self.delegate = viewController;
    [viewController.view addSubview:self];
    [self showGuideAtIndex:self.currentIndex];
}

- (void)showGuideAtIndex:(NSInteger)index {
    if (index < 0) {
        self.currentIndex = 0;
        return;
    }
    
    NSInteger count = 0;
    if ([self.delegate respondsToSelector:@selector(numberOfGuidesInGuideView:)]) {
        count = [self.delegate numberOfGuidesInGuideView:self];
        self.AllItemCount = count;
    }
    
    if (index >= count) {
        if ([self.delegate respondsToSelector:@selector(guideViewEnd:)]) {
            [self.delegate guideViewEnd:self];
        }
        [self.maskLayer removeFromSuperlayer];
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
        return;
    }
    
    CGPathRef fromPath = self.maskLayer.path;
    PGGuideItem *item = nil;
    if ([self.delegate respondsToSelector:@selector(guideView:itemForGuideAtIndex:)]) {
        item = [self.delegate guideView:self itemForGuideAtIndex:index];
    }

    UIBezierPath *visualPath = [UIBezierPath bezierPathWithRoundedRect:item.frame cornerRadius:item.cornerRadius];
    UIBezierPath *toPath = [UIBezierPath bezierPathWithRect:self.bounds];
    [toPath appendPath:visualPath];

    /// 是否需要镂空雷达效果
    if (item.isShowFlash) {
        [self addAperture:self withItem:item];
    }
    
    if ([item.clickType isEqualToString:@"1"]) { // 镂空区域点击事件
        self.ecrireView.frame = item.frame;
        [self addSubview:self.ecrireView];
        [self removeGestureRecognizer:self.singleTap];
    } else { // 全屏下一步
        [self addGestureRecognizer:self.singleTap];
    }
    
    /// 是否显示镂空区域 二处
    if (item.isShowOtherFrame) {
        UIBezierPath *otherPath = [UIBezierPath bezierPathWithRoundedRect:item.frameOther cornerRadius:item.cornerRadiusOther];
        [toPath appendPath:otherPath];
    }

    /// 遮罩的路径
    self.maskLayer.path = toPath.CGPath;
    self.layer.mask = self.maskLayer;

    /// 是否需要镂空红边
    if (item.isShowRed) {
        self.redView.frame = CGRectMake(item.frame.origin.x-Point414(2.0),item.frame.origin.y-Point414(2.0), item.frame.size.width+Point414(4.0), item.frame.size.height+Point414(4.0));
        self.redView.backgroundColor = UIColor.clearColor;
        self.redView.layer.borderColor = UIColor.redColor.CGColor;
        self.redView.layer.borderWidth = Point414(2.0);
        self.redView.layer.cornerRadius = item.cornerRadius;
        self.redView.clipsToBounds = YES;
//        self.redView.layer.zPosition = CGFLOAT_MAX;// 最上层 不好用？？？
        [self addSubview:self.redView];
    }

    /// 开始移动动画
    if (fromPath && toPath) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
        animation.duration = 0.2;
        animation.fromValue = (__bridge id _Nullable)(fromPath);
        animation.toValue = (__bridge id _Nullable)(toPath.CGPath);
        [self.maskLayer addAnimation:animation forKey:nil];
    }

    /// 气泡
    self.bubbleView.text = item.title;
    self.bubbleView.isIconShow = item.isShowIcon;
    self.bubbleView.isArrowAtTop = item.isTop;
    self.bubbleView.bubbleColor = item.bubbleColor;
    self.bubbleView.borderWidth = item.borderWidth;
    self.bubbleView.cornerRadius = item.cornerRadius;
    [self.bubbleView popAtFrame:item.frame];
}

- (void) cilckActionOther {
    
    if (self.currentIndex >= self.AllItemCount) {
        [self removeFromSuperview];

    } else {
        if ([self.delegate respondsToSelector:@selector(guideViewDidSelect:AtIndex:)]) {
            [self.delegate guideViewDidSelect:self AtIndex:self.currentIndex];
        }
        /// 移除上一次光圈
        UIView *view1 = (UIView *)[self viewWithTag:10000];
        UIView *view2 = (UIView *)[self viewWithTag:10001];
        UIView *view3 = (UIView *)[self viewWithTag:10002];
        [view1 removeFromSuperview];
        [view2 removeFromSuperview];
        [view3 removeFromSuperview];
        /// 移除上一次红边
        [self.redView removeFromSuperview];
        /// 移除当前镂空部分view
        [self.ecrireView removeFromSuperview];
        
        [self showGuideAtIndex:++self.currentIndex];
    }
}


/// 点击方法
- (void) cilckAction {
    
    if (self.currentIndex >= self.AllItemCount) {
        [self removeFromSuperview];

    } else {
        if ([self.delegate respondsToSelector:@selector(guideViewDidSelect:AtIndex:)]) {
            [self.delegate guideViewDidSelect:self AtIndex:self.currentIndex];
        }
        /// 移除上一次光圈
        UIView *view1 = (UIView *)[self viewWithTag:10000];
        UIView *view2 = (UIView *)[self viewWithTag:10001];
        UIView *view3 = (UIView *)[self viewWithTag:10002];
        [view1 removeFromSuperview];
        [view2 removeFromSuperview];
        [view3 removeFromSuperview];
        /// 移除上一次红边
        [self.redView removeFromSuperview];
        /// 移除当前镂空部分view
        [self showGuideAtIndex:++self.currentIndex];
    }
}


#pragma mark - get/set
- (CAShapeLayer *)maskLayer {
    if (!_maskLayer) {
        _maskLayer = CAShapeLayer.new;
        _maskLayer.fillRule = kCAFillRuleEvenOdd;
    }
    return _maskLayer;
}

- (PGBubbleForGuide *)bubbleView {
    if (!_bubbleView) {
        _bubbleView = [PGBubbleForGuide viewWithText:nil];
    }
    return _bubbleView;
}

- (UIView *)redView {
    if (!_redView) {
        _redView = UIView.new;
        _redView.userInteractionEnabled = YES;
    }
    return _redView;
}

- (UIButton *) ecrireView {
    if (!_ecrireView) {
        _ecrireView = UIButton.new;
        _ecrireView.backgroundColor = UIColor.clearColor;
        [_ecrireView addTarget:self action:@selector(cilckActionOther) forControlEvents:UIControlEventTouchUpInside];
    }
    return _ecrireView;
}

- (UITapGestureRecognizer *)singleTap
{
    if (!_singleTap) {
        _singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cilckAction)];
    }
    return _singleTap;
}

- (UITapGestureRecognizer *)singleTapOther
{
    if (!_singleTapOther) {
        _singleTapOther = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cilckActionOther)];
    }
    return _singleTapOther;
}

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitView = [super hitTest:point withEvent:event];
    if(hitView == self.apertureView){
        return self.ecrireView;
    }
    return hitView;
}

static inline void dispatch_async_on_main_queue(void(^block)(void)) {
    if (pthread_main_np()) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

static inline CGFloat Point414(CGFloat value) {
    return (value * SCREEN_W / 414.f);
}

@end
