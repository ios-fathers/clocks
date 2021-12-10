//
//  ClockView.m
//  clocks
//
//  Created by iOS Fathers on 10.12.2021.
//

#import "ClockView.h"
#import "ClockFace.h"

typedef enum {
    kClockViewPointerAnimationNone,
    kClockViewPointerAnimationDefault,
    kClockViewPointerAnimationBounce,
} ClockViewPointerAnimationType;

@interface ClockView ()
@property (strong, nonatomic) ClockFace *face;
@property (strong, nonatomic) CAShapeLayer *secondsPointer;
@property (strong, nonatomic) CAShapeLayer *minutesPointer;
@property (strong, nonatomic) CAShapeLayer *hoursPointer;
@end

@implementation ClockView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configure];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self configure];
    }
    return self;
}

- (void)configure {
    self.fillColor = [UIColor whiteColor];
    self.strokeColor = [UIColor blackColor];
    
    self.face = [[ClockFace alloc] init];
    self.face.contentsScale = [UIScreen mainScreen].scale;
    self.face.lineWidth = 2;
    self.face.fillColor = self.fillColor.CGColor;
    self.face.strokeColor = self.strokeColor.CGColor;
    [self.layer addSublayer:self.face];

    self.secondsPointer = [[CAShapeLayer alloc] init];
    self.secondsPointer.fillColor = self.strokeColor.CGColor;
    [self.layer addSublayer:self.secondsPointer];
    
    self.minutesPointer = [[CAShapeLayer alloc] init];
    self.minutesPointer.fillColor = self.strokeColor.CGColor;
    [self.layer addSublayer:self.minutesPointer];
    
    self.hoursPointer = [[CAShapeLayer alloc] init];
    self.hoursPointer.fillColor = self.strokeColor.CGColor;
    [self.layer addSublayer:self.hoursPointer];
    
    [self setHour:0 minute:0 seconds:0 animated:NO];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.face.frame = self.layer.bounds;
    [self.face setNeedsDisplay];
    
    CGFloat size = MIN(self.bounds.size.width, self.bounds.size.height);

    CGFloat secondsPointerWidth = 2;
    self.secondsPointer.path = CGPathCreateWithRect(CGRectMake(-size * 0.05, -secondsPointerWidth * 0.5, size * 0.5, secondsPointerWidth), NULL);
    self.secondsPointer.position = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    
    CGFloat minutesPointerWidth = 4;
    self.minutesPointer.path = CGPathCreateWithRect(CGRectMake(-size * 0.05, -minutesPointerWidth * 0.5, size * 0.4, minutesPointerWidth), NULL);
    self.minutesPointer.position = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    
    CGFloat hoursPointerWidth = 6;
    self.hoursPointer.path = CGPathCreateWithRect(CGRectMake(-size * 0.05, -hoursPointerWidth * 0.5, size * 0.3, hoursPointerWidth), NULL);
    self.hoursPointer.position = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
}

- (void)movePointer:(CALayer *)layer toAngle:(CGFloat)angle animation:(ClockViewPointerAnimationType)animation {
    if (animation == kClockViewPointerAnimationBounce) {
        [CATransaction begin];
        [CATransaction setAnimationDuration:0.1];
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
        [CATransaction setCompletionBlock:^{
            [CATransaction begin];
            [CATransaction setAnimationDuration:0.05];
            layer.transform = CATransform3DMakeRotation(angle - M_PI_2, 0, 0, 1);
            [CATransaction commit];
        }];
        layer.transform = CATransform3DMakeRotation(angle + 0.03 - M_PI_2, 0, 0, 1);
        [CATransaction commit];
    } else if (animation == kClockViewPointerAnimationDefault) {
        [CATransaction begin];
        [CATransaction setAnimationDuration:0.15];
        layer.transform = CATransform3DMakeRotation(angle + 0.03 - M_PI_2, 0, 0, 1);
        [CATransaction commit];
    } else {
        [CATransaction begin];
        [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
        layer.transform = CATransform3DMakeRotation(angle - M_PI_2, 0, 0, 1);
        [CATransaction commit];
    }
}

- (void)setHour:(NSInteger)hours minute:(NSInteger)minutes seconds:(NSInteger)seconds animated:(BOOL)animated {
    [self movePointer:self.secondsPointer toAngle:M_PI * 2 / 60 * seconds animation:animated ? kClockViewPointerAnimationBounce : kClockViewPointerAnimationNone];
    [self movePointer:self.minutesPointer toAngle:M_PI * 2 / 60 / 60 * (minutes * 60 + seconds) animation:animated ? kClockViewPointerAnimationDefault : kClockViewPointerAnimationNone];
    [self movePointer:self.hoursPointer toAngle:M_PI * 2 / 12 / 60 * ((hours % 12) * 60 + minutes) animation:animated ? kClockViewPointerAnimationDefault : kClockViewPointerAnimationNone];
}

- (void)setFillColor:(UIColor *)fillColor {
    _fillColor = fillColor;
    self.face.fillColor = fillColor.CGColor;
    [self.face setNeedsDisplay];
}

- (void)setStrokeColor:(UIColor *)strokeColor {
    _strokeColor = strokeColor;
    self.face.strokeColor = strokeColor.CGColor;
    [self.face setNeedsDisplay];
    self.secondsPointer.fillColor = strokeColor.CGColor;
    self.minutesPointer.fillColor = strokeColor.CGColor;
    self.hoursPointer.fillColor = strokeColor.CGColor;
}

@end
