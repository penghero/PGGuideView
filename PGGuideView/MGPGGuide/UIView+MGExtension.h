
#import <UIKit/UIKit.h>

@interface UIView (MGExtension)

@property (nonatomic, assign) CGFloat x;           ///< Shortcut for frame.origin.x
@property (nonatomic, assign) CGFloat y;           ///< Shortcut for frame.origin.y
@property (nonatomic, assign) CGFloat left;        ///< Shortcut for frame.origin.x
@property (nonatomic, assign) CGFloat top;         ///< Shortcut for frame.origin.y
@property (nonatomic, assign) CGFloat right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic, assign) CGFloat bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic, assign) CGFloat width;       ///< Shortcut for frame.size.width
@property (nonatomic, assign) CGFloat height;      ///< Shortcut for frame.size.height
@property (nonatomic, assign) CGFloat centerX;     ///< Shortcut for center.x
@property (nonatomic, assign) CGFloat centerY;     ///< Shortcut for center.y
@property (nonatomic, assign) CGPoint origin;      ///< Shortcut for frame.origin
@property (nonatomic, assign) CGSize  size;        ///< Shortcut for frame.size

@end

