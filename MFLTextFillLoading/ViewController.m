//
//  ViewController.m
//  MFLTextFillLoading
//
//  Created by Tj on 6/13/15.
//  Copyright (c) 2015 Tj. All rights reserved.
//

#import "ViewController.h"
#import "MFLFillableTextLoader.h"

@interface ViewController ()

@property MFLFillableTextLoader *loader;
@property (weak) IBOutlet MFLFillableTextLoader *ibLoader;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    [para setAlignment:NSTextAlignmentCenter];

    NSAttributedString *details = [[NSAttributedString alloc] initWithString:@"Never tell me the odds."
                                                                  attributes:@{NSFontAttributeName : [UIFont fontWithName:@"Franklin Gothic Book" size:18],
                                                                               NSForegroundColorAttributeName : UIColorFromRGB(0x4bd5ee),
                                                                               NSParagraphStyleAttributeName : para}];

    self.loader = [[MFLFillableTextLoader alloc] initWithString:@"CRawL\nCreatoR"
                                                         font:[UIFont fontWithName:@"StarJedi" size:28]
                                                    alignment:NSTextAlignmentCenter
                                                    withFrame:CGRectMake(0, 0, 320, 400)];

    [self.loader setDetailText:details];
    [self.loader setProgressFont:[UIFont fontWithName:@"SW Crawl Body" size:18]];
    [self.loader setStrokeColor:UIColorFromRGB(0xe5b13a)];
    [self.loader setBackgroundColor:[UIColor blackColor]];
    [self.loader setStrokeWidth:4];

    [self.view addSubview:self.loader];

    NSDictionary *views = NSDictionaryOfVariableBindings(_loader);

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_loader]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.loader
                                                           attribute:NSLayoutAttributeBottom
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.view
                                                           attribute:NSLayoutAttributeBottom
                                                          multiplier:1.0f
                                                            constant:0.f]];

    [self.loader addConstraint:[NSLayoutConstraint constraintWithItem:self.loader
                                                            attribute:NSLayoutAttributeHeight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:nil
                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                           multiplier:1.0
                                                             constant:280]];


    [self.ibLoader setDetailText:details];
    [self.ibLoader setProgressFont:[UIFont fontWithName:@"SW Crawl Body" size:18]];
    [self.ibLoader setFillableFont:[UIFont fontWithName:@"StarJedi" size:28]];
    [self.ibLoader setTextAlignment:NSTextAlignmentCenter];
    [self.ibLoader setStrokeColor:UIColorFromRGB(0xe5b13a)];
    [self.ibLoader setBackgroundColor:[UIColor blackColor]];

    [self updateProgress];
    [self panLoaderInFromBelow];
}

- (void)updateProgress
{
    if (self.loader.progress == 1.0f) {
        [self.loader setProgress:0.0];
    }

    [self.loader setProgress:self.loader.progress + ((arc4random() % 10) / 1000.0f)];
    [self.ibLoader setProgress:self.loader.progress];

    [self performSelector:@selector(updateProgress) withObject:nil afterDelay:.2];
}

- (void)panLoaderInFromBelow
{
    CATransform3D spinBlowInStart = CATransform3DIdentity;
    spinBlowInStart.m34 = 1.0 / -700;
    spinBlowInStart = CATransform3DScale(spinBlowInStart, 0.01, 0.01, -1.11);
    spinBlowInStart = CATransform3DTranslate(spinBlowInStart, 0, 300, 3000);
    spinBlowInStart = CATransform3DRotate(spinBlowInStart,
                                          90.0f * M_PI / 155.0f, 1.0f, 0.0f, 0.0f);

    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath: @"transform"];
    transformAnimation.fromValue = [NSValue valueWithCATransform3D:spinBlowInStart];
    transformAnimation.toValue =[NSValue valueWithCATransform3D:CATransform3DIdentity];
    transformAnimation.duration = 2;
    [self.loader.layer addAnimation:transformAnimation forKey:@"transform"];
    [self.loader.layer setZPosition:1000];
    [self.loader.layer setTransform:CATransform3DIdentity];

    [self.ibLoader.layer addAnimation:transformAnimation forKey:@"transform"];
    [self.ibLoader.layer setZPosition:1000];
    [self.ibLoader.layer setTransform:CATransform3DIdentity];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self blowLoaderOut];
    });
}

- (void)blowLoaderOut
{
    CATransform3D blowOutTransform = CATransform3DIdentity;
    blowOutTransform.m34 = 1.0 / -700;
    blowOutTransform = CATransform3DScale(blowOutTransform, 1, 0.01, 1.0);
    blowOutTransform = CATransform3DTranslate(blowOutTransform, 0, 300, 3000);
    blowOutTransform = CATransform3DRotate(blowOutTransform,
                                           90.0f * M_PI / 155.0f, 1.0f, 0.0f, 0.0f);

    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath: @"transform"];
    transformAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    transformAnimation.toValue = [NSValue valueWithCATransform3D:blowOutTransform];
    transformAnimation.duration = 1;
    [self.loader.layer addAnimation:transformAnimation forKey:@"transform"];
    [self.loader.layer setZPosition:1000];
    [self.ibLoader.layer addAnimation:transformAnimation forKey:@"transform"];
    [self.ibLoader.layer setZPosition:1000];


    //Set transform

    CATransform3D spinBlowInStart = CATransform3DIdentity;
    spinBlowInStart.m34 = 1.0 / -700;
    spinBlowInStart = CATransform3DScale(spinBlowInStart, 0.01, 0.01, -1.11);
    spinBlowInStart = CATransform3DTranslate(spinBlowInStart, 0, 300, 3000);
    spinBlowInStart = CATransform3DRotate(spinBlowInStart,
                                          90.0f * M_PI / 155.0f, 1.0f, 0.0f, 0.0f);
    [self.loader.layer setTransform:spinBlowInStart];
    [self.ibLoader.layer setTransform:spinBlowInStart];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self panLoaderInFromBelow];
    });
}


@end
