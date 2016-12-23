//
//  UIImage+.h
//  Recursos
//
//  Created by Denis Nascimento on 5/18/15.
//  Copyright (c) 2015 Denis Nascimento. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewUtils : NSObject

+(UIImage*)resizableImageCenter:(NSString*)image;
+(UIImage*)resizableImageWithCapInsets:(NSString*)image UIEdgeInsets:(UIEdgeInsets)edgeInsets;
+ (UIView*)putView:(UIView*)view insideShadowWithColor:(CGColorRef)color
         andRadius:(CGFloat)shadowRadius
         andOffset:(CGSize)shadowOffset
        andOpacity:(CGFloat)shadowOpacity;

+ (void)addTopBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth inView:(UIView*)view;
+ (void)addBottomBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth inView:(UIView*)view;
+ (void)addLeftBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth inView:(UIView*)view;
+ (void)addRightBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth inView:(UIView*)view;
@end
