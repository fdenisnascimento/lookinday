//
//  UIView+Visibility.m
//  MedSoft
//
//  Created by Toshiro Sugii on 8/6/13.
//  Copyright (c) 2013 MEDGRUPO Participações. All rights reserved.
//

#import "UIView+Visibility.h"

@implementation UIView (Visibility)

- (void)fadeOutWithCompletion:(void (^)(UIView *view))completion
{
  [self setHidden:YES animated:YES completion:completion];
}

- (void)fadeInWithCompletion:(void (^)(UIView *view))completion
{
  [self setHidden:NO animated:YES completion:completion];
}

- (void)fadeOut
{
  [self setHidden:YES animated:YES completion:nil];
}

- (void)fadeIn
{
  [self setHidden:NO animated:YES completion:nil];
}

- (void)fade
{
  if (self.hidden)
    [self fadeIn];
  else
    [self fadeOut];
}

- (void)setHidden:(BOOL)hidden animated:(BOOL)animated
{
  return [self setHidden:hidden animated:animated completion:nil];
}

- (void)setHidden:(BOOL)hidden animated:(BOOL)animated completion:(void (^)(UIView *))completion
{
  __block UIView *__weak selfObj = self;
  CGFloat alpha = hidden ? 0.f : 1.f;
  if (self.hidden == hidden)
  {
    self.alpha = alpha;
    if (completion)
      completion(selfObj);
    return;
  }

  if (animated)
  {
    if (!hidden) self.hidden = NO;
    [UIView animateWithDuration:0.2f animations:^{
      self.alpha = alpha;
    } completion:^(BOOL finished) {
      if (finished)
      {
        if (hidden) self.hidden = YES;
        if (completion)
          completion(selfObj);
      }
    }];
  }
  else
  {
    self.alpha = alpha;
    self.hidden = hidden;
    if (completion)
      completion(selfObj);
  }
}

@end
