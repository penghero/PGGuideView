# PGGuideView
# PGGCrypto
  鹏哥哥引导-新手引导 支持各种样式 支持自定义
  该引导大致思路以协议思想做的封装，同时进行了拆分，分为蒙版部分和气泡部分两部分组成。
  如果对您有所帮助 请点进下面GitHub链接 送一颗宝贵的星星给我<br>
  GitHub地址  https://github.com/penghero/PGGuideView.git
# 演示GIF
![image](https://github.com/penghero/PGGuideView/blob/master/guide.gif)
# 部分讲解
1.开源属性
```
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
```
2.引导代理
```
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
```
3.使用用例
3.1添加头文件
```
#import "PGGuideView.h"
#import "PGGuideItem.h"
#import "PGBubbleForGuide.h"
```
3.2 遵守协议 PGGuideViewDelegate
3.3初始化
```
    /// 初始化方式2
    self.pgGuideView = [[PGGuideView alloc] initWithFrame:self.view.bounds];
    self.pgGuideView.delegate = self;
    [self.pgGuideView showGuideAtIndex:0];
    /// 加到控制器view上
    [self.view addSubview:self.pgGuideView];
 ```
3.4 实现协议
```
#pragma mark - 新版引导
- (NSInteger)numberOfGuidesInGuideView:(PGGuideView *)guideView {
    NSLog(@"---鹏哥哥引导---一共的引导数量");
    return self.guideItems.count;
}

- (void)guideViewDidSelect:(PGGuideView *)guideView AtIndex:(NSUInteger)index {
    NSLog(@"---鹏哥哥引导---点击某一个引导响应");
}

- (void)guideViewEnd:(PGGuideView *)guideView {
    NSLog(@"---鹏哥哥引导结束---");
}

- (PGGuideItem *)guideView:(PGGuideView *)guideView itemForGuideAtIndex:(NSUInteger)index {
    NSLog(@"---鹏哥哥引导---每个引导的frame");

    CGRect frame = CGRectZero;
    CGFloat cornerRadius = 0.0;
    
    PGGuideItem *item = self.guideItems[index];
    if (index == 0) {
        frame = self.tap1.frame;
        cornerRadius = 5.0;
        item.isShowOtherFrame = NO;
    } else if (index == 1) {
        frame = self.tap2.frame;
        cornerRadius = 10.0;
        item.isShowOtherFrame = NO;
    } else if (index == 2) {
        frame = self.tap3.frame;
        cornerRadius = 25.0;
        item.isShowOtherFrame = NO;
    }else if (index == 3) {
        frame = self.tap4.frame;
        cornerRadius = 5.0;
        item.isShowOtherFrame = YES;
        item.frameOther = self.tap2.frame;
        item.cornerRadiusOther = 0;
    }else if (index == 4) {
        frame = self.tap5.frame;
        cornerRadius = 10.0;
        item.isShowOtherFrame = NO;
    }else if (index == 5) {
        frame = CGRectMake((SCREEN_W-200)/2., 200, 200, 100);
        cornerRadius = 10.0;
        item.isShowOtherFrame = NO;
    }
    
    item.frame = frame;
    item.cornerRadius = cornerRadius;
    return item;
}

- (NSArray *) guideItems {
    PGGuideItem *item0 = PGGuideItem.new;
    item0.title = @"鹏哥引导第一步 带头像 没有特殊效果的情况";
    item0.isShowIcon = YES;
    item0.isTop = YES;
    item0.isShowRed = NO;
    item0.clickType = @"0";

    PGGuideItem *item1 = PGGuideItem.new;
    item1.title = @"鹏哥引导第二步 带头像 镂空部分带有雷达特效的情况 必须点击镂空区域才能进行下一步";
    item1.isShowIcon = YES;
    item1.isTop = NO;
    item1.isShowRed = NO;
    item1.isShowFlash = YES;
    item1.clickType = @"1";
    
    PGGuideItem *item2 = PGGuideItem.new;
    item2.title = @"鹏哥引导第三步 带头像 镂空区域带有描边的情况";
    item2.isShowIcon = YES;
    item2.isTop = NO;
    item2.isShowRed = YES;
    item2.clickType = @"0";

    PGGuideItem *item3 = PGGuideItem.new;
    item3.title = @"鹏哥引导第四步 带头像 没有特殊效果的 带有多个镂空区域的情况";
    item3.isShowIcon = YES;
    item3.isTop = YES;
    item3.isShowRed = NO;
    item3.clickType = @"0";

    PGGuideItem *item4 = PGGuideItem.new;
    item4.title = @"鹏哥引导第五步 感谢各位支持该组件 转发请不要删除标注 请尊重原作者 关注鹏哥哥的github和简书 大家一起进步";
    item4.isShowIcon = YES;
    item4.isTop = YES;
    item4.isShowRed = NO;
    item4.isShowFlash = YES;
    item4.clickType = @"1";

    PGGuideItem *item5 = PGGuideItem.new;
    item5.title = @"致谢-> 感谢各位支持该组件 转发请不要删除标注 请尊重原作者 关注鹏哥哥的github和简书 大家一起进步 ";
    item5.isShowIcon = NO;
    item5.isTop = NO;
    item5.isShowRed = NO;
    item5.clickType = @"0";
    
    return @[item0, item1, item2, item3, item4, item5];
}
```


