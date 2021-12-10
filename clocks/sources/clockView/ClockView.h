//
//  ClockView.h
//  clocks
//
//  Created by iOS Fathers on 10.12.2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ClockView : UIView
@property (strong, nonatomic) UIColor *fillColor;
@property (strong, nonatomic) UIColor *strokeColor;
@property (assign) CGFloat radius;

- (void)setHour:(NSInteger)hours minute:(NSInteger)minutes seconds:(NSInteger)seconds animated:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
