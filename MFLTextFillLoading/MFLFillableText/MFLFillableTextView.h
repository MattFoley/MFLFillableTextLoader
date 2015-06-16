//
//  MFLFillableText.h
//  MFLTextFillLoading
//
//  Created by Tj on 6/13/15.
//  Copyright (c) 2015 Tj. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 
 Note that you can also instantiate this class from a xib.
 
 */
 
@interface MFLFillableTextView : UIView

UIColor* UIColorFromRGB(unsigned int rgbValue);

/**
 *  Use this to create a loader.
 *
 *  @param str          String to display
 *  @param font         Font to use
 *  @param alignment    Alignment of the main label
 *  @param frame        Frame to set for loader
 *
 *  @return             The loader created.
 */
- (instancetype)initWithString:(NSString *)str
                          font:(UIFont *)font
                     alignment:(NSTextAlignment)alignment
                     withFrame:(CGRect)frame;


/**
 *  String used for fillable label
 */
@property (nonatomic) IBInspectable NSString *fillableString;

/**
 *  Font used for fillable label.
 */
@property (nonatomic) IBInspectable UIFont *fillableFont;

/**
 *  Text alignment used for fillable label
 */
@property (nonatomic) IBInspectable NSTextAlignment textAlignment;

/**
 *  This color will be used as the stroke and the fill color of the main label. If you don't supply colors for the progress label, it will be used there as well.
 *
 */
@property (nonatomic) IBInspectable UIColor *strokeColor;

/**
 *  Stroke size to use on fillable labels.
 */
@property (nonatomic) IBInspectable CGFloat strokeWidth;

/**
 *  This color will be used for the unfilled portion of the text as it fills.
 */
@property (nonatomic) IBInspectable UIColor *backgroundColor;

/**
 *  Subtitle to display, usually explains the loading. All aspects of the attributed string will be followed.
 */
@property (nonatomic) IBInspectable NSAttributedString *detailText;

/**
 *  Font used for displaying the progress percentage.
 */
@property (nonatomic) IBInspectable UIFont *progressFont;

/**
 *  Color used for progress label.
 */
@property (nonatomic) IBInspectable UIColor *progressColor;

/**
 *  Current progress setting, value 0.0f through 1.0f.
 */
@property (nonatomic) CGFloat progress;

@end
