//
//  PGBubbleForGuide.m
//  
//
//  Created by pgg on 2020/3/6.
//  Copyright © 2020 Coder3. All rights reserved.
//

#import "PGBubbleForGuide.h"
#import "UIView+MGExtension.h"

@interface PGBubbleForGuide ()
/// 尖角
@property (nonatomic, strong) UIView *arrowView;
/// 尖角位置
@property (nonatomic, assign) CGFloat arrowX;
/// 气泡内按钮数组
@property (nonatomic, strong) NSMutableArray *buttons;
/// 老板娘头像
@property (nonatomic, strong) UIImageView *iconImg;
/// 头像是否存在 默认不存在NO
//@property (nonatomic, assign) BOOL isIconShow;
/// 气泡内容
@property (nonatomic, strong) UILabel *label;

@end

@implementation PGBubbleForGuide


#pragma mark - cycle left
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configSubView];
    }
    return self;
}

- (void) configSubView {
    self.backgroundColor = UIColor.clearColor;
    self.isIconShow = self.isIconShow ? self.isIconShow : NO;
    self.bubbleColor = self.bubbleColor ? self.bubbleColor : kBubbleViewColor;
    self.cornerRadius = self.cornerRadius ? self.cornerRadius : kBubbleViewCornerRadius;
    self.borderWidth = self.borderWidth ? self.borderWidth : 0;
    self.textColor = self.textColor ? self.textColor : UIColor.whiteColor;
    self.buttons = NSMutableArray.new;
    [self addSubview:self.arrowView];
    [self addSubview:self.iconImg];
    [self addSubview:self.label];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    if (self.buttons.count == 0) {
        if (self.isIconShow) {
            self.iconImg.frame = CGRectMake(kPadding, (self.frame.size.height-kIconImgW)/2., kIconImgW, kIconImgW);
            
            self.label.frame = CGRectMake(kPadding*2 + kIconImgW, kPadding, self.bounds.size.width - kPadding*3 - kIconImgW, self.frame.size.height);
            self.label.centerY = self.iconImg.centerY;
            
            return;
        } else {
            self.label.frame = CGRectInset(self.bounds, kPadding * 4, 0.0);
            return;
        }
    }
    
    CGRect slice, remainder;
    CGRectDivide(CGRectInset(self.bounds, 0, kPadding), &slice, &remainder, kButtonH, CGRectMaxYEdge);
    
    if (self.isIconShow) {
        self.iconImg.frame = CGRectMake(kPadding, (remainder.size.height-kIconImgW)/2., kIconImgW, kIconImgW);
        
        self.label.frame = CGRectMake(kPadding*2 + kIconImgW, kPadding, self.bounds.size.width - kPadding*3 - kIconImgW, remainder.size.height);
        self.label.centerY = self.iconImg.centerY;
    } else {
        self.label.frame = CGRectInset(remainder, kPadding * 4, 0.0);
    }
    
    NSInteger index = 0;
    CGFloat buttonWidth = CGRectGetWidth(slice) / self.buttons.count;
    for (UIButton *button in self.buttons) {
        button.tag = index;
        button.frame = CGRectMake(index * buttonWidth, CGRectGetMinY(slice) - 8, buttonWidth, kButtonH);
        index ++;
    }
}

- (void)drawRect:(CGRect)rect {
    // background drawing
    CGRect backgroundRect = CGRectInset(rect, 0.0, 0);
    UIBezierPath *backgroundPath = [UIBezierPath bezierPathWithRoundedRect:backgroundRect cornerRadius:kBubbleViewCornerRadius];
    [self.bubbleColor setFill];
    [backgroundPath fill];

    
    
    self.arrowView.backgroundColor = self.bubbleColor;
}



#pragma mark - public
+ (instancetype)viewWithText:(NSString *)text {
    PGBubbleForGuide *bubble = [[self alloc] initWithFrame:CGRectZero];
    bubble.label.text = text ?: @"";
    return bubble;
}

+ (instancetype)viewWithText:(NSString *)text withIsIcon:(BOOL)isIcon {
    PGBubbleForGuide *bubble = [[self alloc] initWithFrame:CGRectZero];
    bubble.label.text = text ?: @"";
    bubble.isIconShow = isIcon;
    return bubble;

}

- (void)popAtFrame:(CGRect)frame {
    [self configSubView];
    
//    CGFloat frameMidY = CGRectGetMidY(frame);
//    CGFloat superviewMidY = CGRectGetMidY(self.superview.bounds);
    //frameMidY < superviewMidY;
    self.isArrowAtTop = self.isArrowAtTop ? self.isArrowAtTop : NO;
    CGFloat maxWidth = CGRectGetWidth(self.superview.bounds) * 0.8;
    if (self.isIconShow) {
        maxWidth = maxWidth - kIconImgW - kPadding;
    }
    NSDictionary *attributes = @{NSFontAttributeName: self.label.font};
    CGSize textSize = [self.label.text boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    if (textSize.height > 15) {
        self.label.textAlignment = NSTextAlignmentJustified;
    } else {
        self.label.textAlignment = NSTextAlignmentCenter;
    }
    
    CGFloat offset = 10.0;
    CGFloat viewW = MAX(textSize.width + kPadding * 2.0 + (self.isIconShow ? kIconImgW+kPadding : 0), 100);
    
    CGFloat viewH = 0;
    CGFloat viewY = 0;
    if (self.isIconShow) {
        if (textSize.height > kIconImgW) {
            viewH = textSize.height + kPadding*4 + (self.buttons.count > 0 ? kButtonH : 0.0);
            viewY = self.isArrowAtTop ? CGRectGetMaxY(frame) + offset : CGRectGetMinY(frame) - offset - viewH;
        } else {
            viewH = kIconImgW + kPadding*2 + (self.buttons.count > 0 ? kButtonH : 0.0);
            viewY = self.isArrowAtTop ? CGRectGetMaxY(frame) + offset : CGRectGetMinY(frame) - offset - viewH;
        }
    } else {
        viewH = textSize.height + kPadding*6 + (self.buttons.count > 0 ? kButtonH : 0.0);
        viewY = self.isArrowAtTop ? CGRectGetMaxY(frame) + offset : CGRectGetMinY(frame) - offset - viewH;
    }
    
    // frame的中心点在其坐标系的比例决定箭头的位置
    self.arrowX = CGRectGetMidX(frame) / CGRectGetWidth(self.superview.bounds) * viewW;
    CGFloat viewX = CGRectGetMidX(frame) - self.arrowX;
    CGRect viewFrame = CGRectMake(viewX, viewY, viewW, viewH);
    
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = viewFrame;
        
        CGFloat viewX = self.arrowX;
        CGFloat viewY = self.isArrowAtTop ? 0 : viewFrame.size.height; //-kBubbleViewTriangleH
        self.arrowView.center = CGPointMake(viewX, viewY);
        
        if (CGAffineTransformIsIdentity(self.arrowView.transform)) {
            self.arrowView.transform = CGAffineTransformMakeRotation(M_PI_4);
        }

    }];

    [self setNeedsDisplay];
}

- (void)addButton:(UIButton *)button {
    [self.buttons addObject:button];
    [self addSubview:button];
}



#pragma mark - Getter && Setter
- (UILabel *)label {
    if (!_label) {
        _label = UILabel.new;
        _label.textColor = UIColor.whiteColor;
        _label.numberOfLines = 0;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = CUSTOM_FONT(12);
    }
    return _label;
}

- (UIImageView *)iconImg {
    if (!_iconImg) {
        _iconImg = UIImageView.new;
        _iconImg.backgroundColor = UIColor.yellowColor;
        _iconImg.layer.cornerRadius = 25;
        _iconImg.hidden = YES;
    }
    return _iconImg;
}

- (UIView *)arrowView {
    if (!_arrowView) {
        _arrowView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kBubbleViewTriangleH, kBubbleViewTriangleH)];
    }
    return _arrowView;
}

- (void)setText:(NSString *)text {
    self.label.text = text;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    
    self.label.textColor = _textColor;
}

- (void)setArrowX:(CGFloat)arrowX {
    _arrowX = arrowX;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
}

- (void)setIsArrowAtTop:(BOOL)isArrowAtTop {
    _isArrowAtTop = isArrowAtTop;
}

- (void)setBubbleColor:(UIColor *)bubbleColor {
    _bubbleColor = bubbleColor;
}

- (NSString *) text {
    return self.label.text;
}

- (void)setIsIconShow:(BOOL)isIconShow {
    _isIconShow = isIconShow;
    
    if (_isIconShow) {
        _iconImg.hidden = NO;
    } else {
        _iconImg.hidden = YES;
    }
}

@end
