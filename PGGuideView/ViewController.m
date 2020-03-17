//
//  ViewController.m
//  PGGuideView
//
//  Created by pgg on 2020/3/17.
//  Copyright © 2020 pgg. All rights reserved.
//

#import "ViewController.h"
#import "PGGuideView.h"
#import "PGGuideItem.h"
#import "PGBubbleForGuide.h"

@interface ViewController ()<PGGuideViewDelegate>

@property (nonatomic,strong) PGGuideView *pgGuideView;
@property (weak, nonatomic) IBOutlet UIButton *tap1;
@property (weak, nonatomic) IBOutlet UIButton *tap2;
@property (weak, nonatomic) IBOutlet UIButton *tap3;
@property (weak, nonatomic) IBOutlet UIButton *tap4;
@property (weak, nonatomic) IBOutlet UIButton *tap5;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configSubview];
    
}

- (IBAction)showNextGuide:(UIButton *)sender {
    [self configSubview];
}

- (void) configSubview {
    /// 初始化方式2
    self.pgGuideView = [[PGGuideView alloc] initWithFrame:self.view.bounds];
    self.pgGuideView.delegate = self;
    [self.pgGuideView showGuideAtIndex:0];
    /// 加到控制器view上
    [self.view addSubview:self.pgGuideView];

}

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


@end
