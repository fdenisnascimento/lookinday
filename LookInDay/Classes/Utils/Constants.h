//
//  Constants.h
//  voltem
//
//  Created by Denis Nascimento on 10/6/14.
//  Copyright (c) 2014 Denis Nascimento. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

typedef enum {
    
    AddPostTypeLook = 0,
    AddPostTypeEnquete,
    AddPostTypeDica
    
}AddPostType;

typedef enum {
    
    PostTypePost = 0,
    PostTypeFavorito,
    PostTypeEnquete,
    PostTypeTop10,
    PostTypeDicas,
    PostTypeLook
    
}PostType;


@interface UIColor (UIColor_Extensions)
+ (UIColor*)colorWithHexValue:(NSString*)hexValue;
@end


#define URL_HTML_ABOUT @"http://www.lookinday.com.br/about.html"
#define URL_HTML_POLICY @"http://www.lookinday.com.br/policy.html"
#define URL_HTML_TERMS @"http://www.lookinday.com.br/terms.html"


#define UrbanElegance @"UrbanElegance"
#define UrbanEleganceItalic @"UrbanElegance-Italic"
#define UrbanEleganceBold @"UrbanElegance-Bold"


@interface Constants : NSObject

+ (NSString *)escapeUrl:(NSString*)url;
+ (NSString *)appSupportFolder;
+ (NSString *)cachesFolder;
+ (NSString *)documentsFolder;
+ (NSString *)bundleFolder;

+ (NSString *)bundlePathFor:(NSString *)filename;
+ (NSString *)cachesPathFor:(NSString *)filename;
+ (NSString *)appSupportPathFor:(NSString *)filename;

+ (NSString *)bundleFormattedPathFor:(NSString *)formatString, ...;
+ (NSString *)cachesFormattedPathFor:(NSString *)formatString, ...;
+ (NSString *)appSupportFormattedPathFor:(NSString *)formatString, ...;

+ (BOOL)iOS7;
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (BOOL)checkApplicationFirstLaunch;
+ (BOOL)cacheWithContentsOfURLString:(NSString *)urlString contents:(NSData *)_data;
+ (NSData *)dataWithContentsOfURLString:(NSString *)urlString;
+ (NSString*)createUrlImage:(NSString*)url width:(NSInteger)width height:(NSInteger)height;
+ (NSString*)currencyvalue:(double)value;
+ (NSString *)dateToString:(NSDate*)date;
+ (NSString*)dateToStringFormated:(NSDate *)date;
+ (CGFloat)widthScreen;
+ (CGFloat)heightScreen;
+ (UIImage *)backGroundImageColor:(UIColor*)color;
+ (BOOL)emailValido:(NSString *)email;
+ (void)setHeightScreen:(CGFloat)height;
+ (void)setWidthScreen:(CGFloat)with;
+ (NSString*)DictionaryToJSonString:(NSDictionary*)dictionary;
+(BOOL)checkInternet;
+(void)insertGradientInView:(UIView*)view;
+(UIColor*)color;
+(void)setColor:(UIColor*)color;
@end
