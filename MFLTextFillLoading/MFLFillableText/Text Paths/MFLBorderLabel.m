//
//  MFLBorderLabel.m
//  MFLTextFillLoading
//
//  Created by Tj on 6/13/15.
//  Copyright (c) 2015 Tj. All rights reserved.
//

#import "MFLBorderLabel.h"

@implementation MFLBorderLabel

- (void)drawTextInRect:(CGRect)rect {

    CGSize shadowOffset = self.shadowOffset;
    UIColor *textColor = self.textColor;

    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(c, self.strokeWidth);
    CGContextSetLineJoin(c, kCGLineJoinMiter);

    CGContextSetTextDrawingMode(c, kCGTextStroke);
    self.textColor = self.strokeColor;
    [super drawTextInRect:rect];

    CGContextSetTextDrawingMode(c, kCGTextFill);
    self.textColor = textColor;
    self.shadowOffset = CGSizeMake(0, 0);
    [super drawTextInRect:rect];

    self.shadowOffset = shadowOffset;
}


@end
