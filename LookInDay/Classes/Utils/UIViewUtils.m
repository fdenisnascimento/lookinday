//
//  UIImage+.m
//  Recursos
//
//  Created by Denis Nascimento on 5/18/15.
//  Copyright (c) 2015 Denis Nascimento. All rights reserved.
//

#import "UIViewUtils.h"

@implementation UIViewUtils

+(UIImage*)resizableImageWithCapInsets:(NSString*)image UIEdgeInsets:(UIEdgeInsets)edgeInsets
{
  return [[UIImage imageNamed:image] resizableImageWithCapInsets:edgeInsets];
}

+(UIImage*)resizableImageCenter:(NSString*)image
{//UIKIT_STATIC_INLINE UIEdgeInsets UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
  return [[UIImage imageNamed:image] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0,15)];
}

+ (UIView*)putView:(UIView*)view insideShadowWithColor:(CGColorRef)color
         andRadius:(CGFloat)shadowRadius
         andOffset:(CGSize)shadowOffset
        andOpacity:(CGFloat)shadowOpacity
{
    // Must have same position like "view"
  UIView *shadow = [[UIView alloc] initWithFrame:view.frame];
  
  shadow.layer.contentsScale = [UIScreen mainScreen].scale;
  shadow.userInteractionEnabled = YES; // Modify this if needed
  shadow.layer.shadowColor = color;
  shadow.layer.shadowOffset = shadowOffset;
  shadow.layer.shadowRadius = shadowRadius;
  shadow.layer.masksToBounds = NO;
  shadow.clipsToBounds = NO;
  shadow.layer.shadowOpacity = shadowOpacity;
  shadow.layer.rasterizationScale = [UIScreen mainScreen].scale;
  shadow.layer.shouldRasterize = YES;
  
  [view.superview insertSubview:shadow belowSubview:view];
  [shadow addSubview:view];
  
    // Move view to the top left corner inside the shadowview
    // ---> Buttons etc are working again :)
  view.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
  
  return shadow;
}

+ (void)addTopBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth inView:(UIView*)view{
  CALayer *border = [CALayer layer];
  border.backgroundColor = color.CGColor;
  
  border.frame = CGRectMake(0, 0, view.frame.size.width, borderWidth);
  [view.layer addSublayer:border];
}

+ (void)addBottomBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth inView:(UIView*)view
{
  CALayer *border = [CALayer layer];
  border.backgroundColor = color.CGColor;
  
  border.frame = CGRectMake(0, view.frame.size.height - borderWidth, view.frame.size.width, borderWidth);
  [view.layer addSublayer:border];
}

+ (void)addLeftBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth inView:(UIView*)view{
  CALayer *border = [CALayer layer];
  border.backgroundColor = color.CGColor;
  
  border.frame = CGRectMake(0, 0, borderWidth, view.frame.size.height);
  [view.layer addSublayer:border];
}

+ (void)addRightBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth inView:(UIView*)view{
  CALayer *border = [CALayer layer];
  border.backgroundColor = color.CGColor;
  
  border.frame = CGRectMake(view.frame.size.width - borderWidth, 0, borderWidth, view.frame.size.height);
  [view.layer addSublayer:border];
}


@end
