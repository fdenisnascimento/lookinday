  //
  //  THSViewController.m
  //  TESTE
  //
  //  Created by Denis Nascimento on 6/18/15.
  //  Copyright (c) 2015 Denis Nascimento. All rights reserved.
  //

#import "THSViewController.h"
#import "XHAmazingLoadingView.h"

@interface THSViewController ()
@property (nonatomic) CGFloat visibleOffset;
@property(nonatomic,strong) XHAmazingLoadingView *amazingLoadingView;
@end

@implementation THSViewController


- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
}

- (void)startKeyboardObserver
{
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillShow:)
                                               name:UIKeyboardWillShowNotification
                                             object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillHide:)
                                               name:UIKeyboardWillHideNotification
                                             object:nil];
  
  self.visibleMargin = 10.;
  
}


//- (UIStatusBarStyle) preferredStatusBarStyle {
// return UIStatusBarStyleDefault;
//}



-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  if (!_amazingLoadingView) {
    _amazingLoadingView = [[XHAmazingLoadingView alloc] initWithType:XHAmazingLoadingAnimationTypeSkype];
    _amazingLoadingView.loadingTintColor = [UIColor colorWithRed:0.188f green:0.278f blue:0.322f alpha:1.00f];
    _amazingLoadingView.backgroundTintColor = [UIColor whiteColor];
    _amazingLoadingView.alpha = 0.9;
    _amazingLoadingView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:_amazingLoadingView];

      _amazingLoadingView.size = 30.f;
    _amazingLoadingView.hidden = YES;
    [_amazingLoadingView stopAnimating];
  }

  
  
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setBlur:(BOOL)hidden
{
  [self.bluredView setHidden:!hidden];
}


-(void)startAnimate
{
  _amazingLoadingView.hidden = NO;
  [_amazingLoadingView startAnimating];
}

-(void)stopAnimate
{
  [_amazingLoadingView stopAnimating];
  _amazingLoadingView.hidden = YES;
  
}


+(void)insertGradientInView:(UIView*)view
{
  CAGradientLayer *gradient = [CAGradientLayer layer];
  gradient.frame = view.bounds;
  gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor], (id)[[UIColor blackColor] CGColor], nil];
  [view.layer insertSublayer:gradient atIndex:0];
  
}


#pragma keyboard height

- (void) keyboardWillShow:(NSNotification *)note
{
  CGRect keyboardBounds;
  [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
  NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
  NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
  
  keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
  CGRect frame = self.view.frame;
  CGFloat visibleHeight = frame.size.height - keyboardBounds.size.height ;
  CGFloat lastVisiblePointY = self.lastVisibleView.frame.origin.y + self.lastVisibleView.frame.size.height;
  if (self.lastVisibleView && self.visibleOffset == 0 && (lastVisiblePointY + self.visibleMargin ) > visibleHeight) {
    self.visibleOffset = lastVisiblePointY - visibleHeight + self.visibleMargin ;
    frame.origin.y -= self.visibleOffset;
  }
  
  [UIView beginAnimations:nil context:NULL];
  [UIView setAnimationBeginsFromCurrentState:YES];
  [UIView setAnimationDuration:[duration doubleValue]];
  [UIView setAnimationCurve:[curve intValue]];
  
  self.view.frame = frame;
  
  [UIView commitAnimations];
}


- (void) keyboardWillHide:(NSNotification *)note
{
  NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
  NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
  
  CGRect frame = self.view.frame;
  frame.origin.y += self.visibleOffset;
  self.visibleOffset = 0;
  
  [UIView beginAnimations:nil context:NULL];
  [UIView setAnimationBeginsFromCurrentState:YES];
  [UIView setAnimationDuration:[duration doubleValue]];
  [UIView setAnimationCurve:[curve intValue]];
  
  self.view.frame = frame;
  
  [UIView commitAnimations];
}


-(void)alertViewWithMessage:(NSString*)message title:(NSString*)tittle button:(NSString*)button
{
    if (!tittle)
        tittle = @"Look In Day";
    if(!button)
        button = @"Ok";
    
    [[[UIAlertView alloc]initWithTitle:tittle  message:message delegate:nil cancelButtonTitle:button otherButtonTitles:nil, nil]show];
}

@end

