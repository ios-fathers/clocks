//
//  ClockFace.m
//  clocks
//
//  Created by iOS Fathers on 10.12.2021.
//

#import "ClockFace.h"

@implementation ClockFace

- (void)drawInContext:(CGContextRef)ctx {
    CGFloat size = MIN(self.bounds.size.width - self.lineWidth * 2, self.bounds.size.height - self.lineWidth * 2);
    CGRect rect = CGRectMake((self.bounds.size.width - size) * 0.5, (self.bounds.size.height - size) * 0.5, size, size);
    CGContextSetFillColorWithColor(ctx, self.fillColor);
    CGContextSetStrokeColorWithColor(ctx, self.strokeColor);
    CGContextSetLineWidth(ctx, self.lineWidth);
    CGContextFillEllipseInRect(ctx, rect);
    CGContextStrokeEllipseInRect(ctx, rect);
    
    int segmentsCount = 60;
    CGFloat normalLength = rect.size.width * 0.1;
    CGFloat smallLength = rect.size.width * 0.1 * 0.6;
    CGContextSetFillColorWithColor(ctx, self.strokeColor);

    for (int i = 0; i < segmentsCount; ++i) {
        CGContextSaveGState(ctx);
        
        CGContextTranslateCTM(ctx, self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
        CGContextRotateCTM(ctx, -M_PI_2);
        CGContextRotateCTM(ctx, M_PI * 2 / segmentsCount * i);
        
        CGFloat length = i % 5 ? smallLength : normalLength;
        CGFloat width = i % 5 ? self.lineWidth : self.lineWidth * 2;
        CGContextFillRect(ctx, CGRectMake(size * 0.5 - length, -width * 0.5, length, width));
        
        CGContextRestoreGState(ctx);
    }
}

@end
