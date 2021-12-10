//
//  ClockFace.h
//  clocks
//
//  Created by iOS Fathers on 10.12.2021.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface ClockFace : CALayer
@property (assign, nonatomic) CGFloat lineWidth;
@property (assign, nonatomic) CGColorRef strokeColor;
@property (assign, nonatomic) CGColorRef fillColor;
@end

NS_ASSUME_NONNULL_END
