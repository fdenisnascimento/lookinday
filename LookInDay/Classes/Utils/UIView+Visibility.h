//
//  UIView+Visibility.h
//  MedSoft
//
//  Created by Toshiro Sugii on 8/6/13.
//  Copyright (c) 2013 MEDGRUPO Participações. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Visibility)

- (void)fadeOut;
- (void)fadeIn;
- (void)fadeOutWithCompletion:(void (^)(UIView *view))completion;
- (void)fadeInWithCompletion:(void (^)(UIView *view))completion;
- (void)fade;

- (void)setHidden:(BOOL)hidden animated:(BOOL)animated;
- (void)setHidden:(BOOL)hidden animated:(BOOL)animated completion:(void (^)(UIView *view))completion;

@end
