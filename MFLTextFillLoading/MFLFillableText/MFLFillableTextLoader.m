//
//  MFLFillableText.m
//  MFLTextFillLoading
//
//  Created by Tj on 6/13/15.
//  Copyright (c) 2015 Tj. All rights reserved.
//

#import "MFLFillableTextLoader.h"
#import "MFLBorderLabel.h"

// These two Enum types are currently not used at all. Will only fill left to right for now, and will only fill flatly.
typedef NS_ENUM(NSInteger, MFLTextFillStyle)
{
    kFillStyleFlat,
    kFillStyleSine
};

typedef NS_ENUM(NSInteger, MFLTextFillDirection)
{
    kFillStyleLeft,
    kFillStyleRight,
    kFillStyleUp,
    kFillStyleDown,
};


@interface MFLFillableTextLoader ()

@property MFLTextFillStyle fillStyle;
@property MFLTextFillDirection fillDirection;

@property (weak) IBOutlet UIView *nibView;

@property (weak) IBOutlet MFLBorderLabel *fillLabel;
@property (weak) IBOutlet UIView *fillLabelContainer;
@property (weak) IBOutlet NSLayoutConstraint *fillLabelContainerWidth;

@property (weak) IBOutlet MFLBorderLabel *strokeLabel;
@property (weak) IBOutlet NSLayoutConstraint *strokeTextWidth;
@property (weak) IBOutlet NSLayoutConstraint *strokeTextHeight;

@property (weak) IBOutlet UILabel *detailLabel;
@property (weak) IBOutlet UILabel *percentLabel;

@end

@implementation MFLFillableTextLoader

UIColor* UIColorFromRGB(unsigned int rgbValue) {
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0
                           green:((float)((rgbValue & 0xFF00) >> 8))/255.0
                            blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];
}

- (instancetype)initWithString:(NSString *)str
                          font:(UIFont *)font
                     alignment:(NSTextAlignment)alignment
                     withFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
        _fillableString = str;
        _fillableFont = font;
        _textAlignment = alignment;

        [self sharedInit];
    }

    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];

    if (self) {
        [self sharedInit];
    }

    return self;
}

- (void)sharedInit
{
    _progress = 0;
    [self unwrapNib];
    [self updateLabels];
}

- (void)unwrapNib
{
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                  owner:self
                                options:nil];

    [self.nibView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];

    [self addSubview:self.nibView];
    [self.nibView setFrame:self.bounds];
    [self.nibView setBackgroundColor:[UIColor clearColor]];
    [self setBackgroundColor:[UIColor clearColor]];

    NSDictionary *views = NSDictionaryOfVariableBindings(_nibView);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_nibView]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_nibView]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
}

- (void)updateLabels
{
    [self.strokeLabel setStrokeColor:self.strokeColor];
    [self.strokeLabel setStrokeWidth:self.strokeWidth];
    [self.strokeLabel setTextColor:self.unfilledTextColor];
    [self.strokeLabel setFont:self.fillableFont];
    [self.strokeLabel setTextAlignment:self.textAlignment];
    [self.strokeLabel setText:self.fillableString];

    [self.fillLabel setTextColor:self.strokeColor];
    [self.fillLabel setStrokeWidth:self.strokeWidth];
    [self.fillLabel setStrokeColor:self.strokeColor];

    [self.fillLabel setText:self.fillableString];
    [self.fillLabel setTextAlignment:self.textAlignment];
    [self.fillLabel setFont:self.fillableFont];

    [self.percentLabel setTextColor:self.strokeColor];

    [self.strokeTextHeight setConstant:0];
    [self.strokeTextWidth setConstant:0];

    [self setNeedsUpdateConstraints];
    [self layoutIfNeeded];

    [self.strokeTextHeight setConstant:CGRectGetHeight(self.strokeLabel.frame) + 30];
    [self.strokeTextWidth setConstant:CGRectGetWidth(self.strokeLabel.frame) + 30];

    [self setNeedsUpdateConstraints];
    [self layoutIfNeeded];
}

- (void)setDetailText:(NSAttributedString *)text
{
    _detailText = text;

    [self.detailLabel setAttributedText:text];
    [self setNeedsUpdateConstraints];
    [self layoutIfNeeded];
}

- (void)setProgressFont:(UIFont *)font
{
    _progressFont = font;
    [self.percentLabel setFont:font];
}

- (void)setProgressColor:(UIColor *)color
{
    _progressColor = color;
    [self.percentLabel setTextColor:color];
}

- (void)setFillableFont:(UIFont *)fillableFont
{
    _fillableFont = fillableFont;
    [self updateLabels];
}

- (void)setFillableString:(NSString *)fillableString
{
    _fillableString = fillableString;
    [self updateLabels];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    _textAlignment = textAlignment;
    [self updateLabels];
}

- (void)setStrokeColor:(UIColor *)strokeColor
{
    _strokeColor = strokeColor;
    [self updateLabels];
}

- (void)setStrokeWidth:(CGFloat)strokeWidth
{
    _strokeWidth = strokeWidth;
    [self updateLabels];
}

- (void)setProgress:(CGFloat)progress
{
    dispatch_async(dispatch_get_main_queue(), ^{
        _progress = MIN(progress, 1.0f);
        [self.percentLabel setText:[NSString stringWithFormat:@"%.2f%%", self.progress * 100]];

        [UIView animateWithDuration:.1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            [self.fillLabelContainerWidth setConstant:CGRectGetWidth(self.fillLabelContainer.superview.frame) * (self.progress * .7)];
            [self setNeedsUpdateConstraints];
            [self layoutIfNeeded];
        } completion:nil];
    });
}

@end
