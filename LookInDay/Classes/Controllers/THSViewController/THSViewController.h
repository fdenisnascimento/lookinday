//
//  THSViewController.h
//  TESTE
//
//  Created by Denis Nascimento on 6/18/15.
//  Copyright (c) 2015 Denis Nascimento. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UCZProgressView.h"

typedef void(^THSCallback)(BOOL success, id result);



@interface THSViewController : UIViewController

@property(nonatomic,strong) UCZProgressView *progressView;


@property (nonatomic, strong) UIView *lastVisibleView;
@property (nonatomic) CGFloat visibleMargin;

@property  (nonatomic,retain)NSString *directoryPath;
@property  (nonatomic,retain)UIImage *placeHolder;
@property (nonatomic, strong) UIVisualEffectView *bluredView;

-(void)setBlur:(BOOL)hidden;
- (void)stopAnimate;
- (void)startAnimate;
- (void)startKeyboardObserver;



+(void)insertGradientInView:(UIView*)view;
-(void)alertViewWithMessage:(NSString*)message title:(NSString*)tittle button:(NSString*)button;

@end


