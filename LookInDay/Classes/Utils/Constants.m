//
//  Constants.m
//  voltem
//
//  Created by Denis Nascimento on 10/6/14.
//  Copyright (c) 2014 Denis Nascimento. All rights reserved.
//

#import "Constants.h"
#import "NSString+MD5.h"
#import "Reachability.h"

static NSString *APPSUPORT_FOLDER = nil;
static NSString *DOCUMENTS_FOLDER = nil;
static NSString *BUNDLE_FOLDER = nil;
static NSString *CACHES_FOLDER = nil;

static CGFloat WIDTH_SCREEN = 0.0F;
static CGFloat HEIGHT_SCREEN = 0.0F;


@implementation UIColor (UIColor_Extensions)

+ (UIColor*)colorWithHexValue:(NSString*)hexValue
{
    //Default
    UIColor *defaultResult = [UIColor blackColor];
    
    //Strip prefixed # hash
    if ([hexValue hasPrefix:@"#"] && [hexValue length] > 1)
    {
        hexValue = [hexValue substringFromIndex:1];
    }
    
    //Determine if 3 or 6 digits
    NSUInteger componentLength = 0;
    if ([hexValue length] == 3)
    {
        componentLength = 1;
    }
    else if ([hexValue length] == 6)
    {
        componentLength = 2;
    }
    else
    {
        return defaultResult;
    }
    
    BOOL isValid = YES;
    CGFloat components[3];
    
    //Seperate the R,G,B values
    for (NSUInteger i = 0; i < 3; i++) {
        NSString *component = [hexValue substringWithRange:NSMakeRange(componentLength * i, componentLength)];
        if (componentLength == 1) {
            component = [component stringByAppendingString:component];
        }
        
        NSScanner *scanner = [NSScanner scannerWithString:component];
        unsigned int value;
        isValid &= [scanner scanHexInt:&value];
        components[i] = (CGFloat)value / 255.0f;
    }
    
    if (!isValid) {
        return defaultResult;
    }
    
    return [UIColor colorWithRed:components[0]
                           green:components[1]
                            blue:components[2]
                           alpha:1.0];
}

@end





@implementation Constants


+ (NSString *)documentsFolder
{
    if (!DOCUMENTS_FOLDER)
        DOCUMENTS_FOLDER = [[NSString alloc] initWithString:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]];
    return DOCUMENTS_FOLDER;
}

+ (NSString *)cachesFolder
{
    if (!CACHES_FOLDER)
    {
        NSArray *pathList = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        CACHES_FOLDER = [pathList objectAtIndex:0];
    }
    return CACHES_FOLDER;
}

+ (NSString *)appSupportFolder
{
    if (!APPSUPORT_FOLDER)
    {
        NSArray *pathList = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
        APPSUPORT_FOLDER = [pathList objectAtIndex:0];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:APPSUPORT_FOLDER] )
            [[NSFileManager defaultManager] createDirectoryAtPath:APPSUPORT_FOLDER withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return APPSUPORT_FOLDER;
}


+ (NSString *)plistBundleFolder
{
  if (!BUNDLE_FOLDER)
    BUNDLE_FOLDER = [[NSString alloc] initWithString:[[NSBundle mainBundle] resourcePath]];
  return BUNDLE_FOLDER;
}

+ (NSString *)bundleFolder
{
    if (!BUNDLE_FOLDER)
        BUNDLE_FOLDER = [[NSString alloc] initWithString:[[NSBundle mainBundle] resourcePath]];
    return BUNDLE_FOLDER;
}

+ (NSString *)bundlePathFor:(NSString *)filename
{
  NSString *filePath = [[NSBundle mainBundle] pathForResource:[filename stringByDeletingPathExtension] ofType:[filename pathExtension]];
  
  return filePath;
}

+ (NSString *)cachesPathFor:(NSString *)filename
{
  return [[Constants cachesFolder] stringByAppendingPathComponent:filename];
}

+ (NSString *)appSupportPathFor:(NSString *)filename
{
  return [[Constants appSupportFolder] stringByAppendingPathComponent:filename];
}

+ (NSString *)bundleFormattedPathFor:(NSString *)formatString, ...
{
  va_list args;
  va_start(args, formatString);
  NSString *contents = [[NSString alloc] initWithFormat:formatString arguments:args];
  va_end(args);
  
  NSString *filePath = [[NSBundle mainBundle] pathForResource:[contents stringByDeletingPathExtension] ofType:[contents pathExtension]];
  
  return filePath;
}

+ (NSString *)cachesFormattedPathFor:(NSString *)formatString, ...
{
  va_list args;
  va_start(args, formatString);
  NSString *contents = [[NSString alloc] initWithFormat:formatString arguments:args];
  va_end(args);
  
  return [[Constants cachesFolder] stringByAppendingPathComponent:contents];
}

+ (NSString *)appSupportFormattedPathFor:(NSString *)formatString, ...
{
  va_list args;
  va_start(args, formatString);
  NSString *contents = [[NSString alloc] initWithFormat:formatString arguments:args];
  va_end(args);
  
  return [[Constants appSupportFolder] stringByAppendingPathComponent:contents];
}

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    BOOL success = YES;
    if ([[NSFileManager defaultManager] fileExistsAtPath: [URL path]])
    {
        NSError *error = nil;
        success = [URL setResourceValue: [NSNumber numberWithBool: YES] forKey: NSURLIsExcludedFromBackupKey error: &error];
        
        if (!success)
            NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}

+ (BOOL)iOS7
{
    return ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.f);
}

+(NSString*)escapeUrl:(NSString*)url
{
    return   CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)url, NULL, CFSTR("!*'();:@&=+$,/?%#[]"), kCFStringEncodingUTF8));
}


+ (UIImage *)imageWithColor:(UIColor *)color
{
  CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
  UIGraphicsBeginImageContext(rect.size);
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  CGContextSetFillColorWithColor(context, [color CGColor]);
  CGContextFillRect(context, rect);
  
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return image;
}

+(BOOL)checkApplicationFirstLaunch
{
  BOOL hasBeenStarted = [[NSUserDefaults standardUserDefaults] boolForKey:@"hasBeenStarted"];
  if (!hasBeenStarted)
  {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasBeenStarted"];
    return YES;
  }
  return NO;
}



+ (BOOL)removeAllFilesFromiCloud
{
  NSArray *pathList = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
  NSString *libraryDirectory = [pathList objectAtIndex:0];
  
  NSFileManager *fm = [NSFileManager defaultManager];
  NSDirectoryEnumerator *dirEnum = [fm enumeratorAtPath:libraryDirectory];
  
  BOOL result = YES;
  NSString *file;
  while (file = [dirEnum nextObject])
  {
    if (![file hasPrefix:@"Preferences"])
    {
      file = [libraryDirectory stringByAppendingPathComponent:file];
      result = [Constants addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:file]];
    }
    
    if (!result)
      return result;
  }
  
  return result;
  
}


+ (BOOL)cacheWithContentsOfURLString:(NSString *)urlString contents:(NSData *)_data
{
  NSError *error = nil;
  NSFileManager *fm = [NSFileManager defaultManager];
  NSString *newFilename = [[Constants appSupportFolder] stringByAppendingPathComponent:[urlString MD5]];
  
  NSString *newDir = [newFilename stringByDeletingLastPathComponent];

  if ([fm fileExistsAtPath:newFilename])
  {
    [fm removeItemAtPath:newFilename error:&error];
    if (error)
      NSLog(@"Error: Cannot remove file: %@ (%@)", newFilename, [error localizedDescription]);
  }
  
  if (![fm fileExistsAtPath:newFilename])
  {
    [fm createDirectoryAtPath:newDir withIntermediateDirectories:YES attributes:nil error:&error];
    if ([_data writeToFile:newFilename atomically:YES])
    {
      [Constants removeAllFilesFromiCloud];
      return YES;
    }
    else
      return NO;
  }
  return NO;
}

+ (NSData *)dataWithContentsOfURLString:(NSString *)urlString
{
  NSString *filePath = [[Constants appSupportFolder] stringByAppendingPathComponent:[urlString MD5]];
  if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    return [NSData dataWithContentsOfFile:filePath];
  
  return nil;
}

+ (NSString*)createUrlImage:(NSString*)url width:(NSInteger)width height:(NSInteger)height
{
  url = [url stringByReplacingOccurrencesOfString:@"{WIDTH}" withString:[NSString stringWithFormat:@"%ld",(long)width]];
  url = [url stringByReplacingOccurrencesOfString:@"{HEIGHT}" withString:[NSString stringWithFormat:@"%ld",(long)height]];
  return url;
  
}


+ (NSString*)currencyvalue:(double)value
{
  NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
  formatter.locale = [NSLocale currentLocale];
  formatter.numberStyle = NSNumberFormatterCurrencyStyle;
  
  return [formatter stringFromNumber:[NSNumber numberWithDouble:value]];
  
}

+ (NSString *)dateToString:(NSDate*)date
{
  return [NSDateFormatter localizedStringFromDate:date
                                        dateStyle:NSDateFormatterMediumStyle
                                        timeStyle:NSDateFormatterNoStyle];
}


+(NSString*)dateToStringFormated:(NSDate *)date
{
  NSDateFormatter *dateFormated = [[NSDateFormatter alloc] init];
  [dateFormated setDateFormat:@"yyyy/MM/dd"];
  return  [dateFormated stringFromDate:date];
}


+(CGFloat)widthScreen
{
  if (!WIDTH_SCREEN)
    WIDTH_SCREEN = [[UIScreen mainScreen]bounds].size.width;
  return WIDTH_SCREEN;
}


+(CGFloat)heightScreen
{
  if (!HEIGHT_SCREEN)
    HEIGHT_SCREEN = [[UIScreen mainScreen]bounds].size.height;
  return HEIGHT_SCREEN;
}


+(void)setWidthScreen:(CGFloat)with
{
  WIDTH_SCREEN = with;
}


+(void)setHeightScreen:(CGFloat)height
{
    HEIGHT_SCREEN = height;
}

#pragma mark - UIButton BackGroundImage

+ (UIImage *)backGroundImageColor:(UIColor*)color
{
  
  CGRect rect = CGRectMake(0, 0, 1, 1);
  UIGraphicsBeginImageContext(rect.size);
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetFillColorWithColor(context, [color CGColor]);
  CGContextFillRect(context, rect);
  UIImage *backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return backgroundImage;
}

+ (BOOL)emailValido:(NSString *)email {
  BOOL stricterFilter = NO;
  
  NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
  NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
  NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
  NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
  
  return [emailTest evaluateWithObject:email];
}

+(NSString*)DictionaryToJSonString:(NSDictionary*)dictionary
{
  NSError *error;
  NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                     options:NSJSONWritingPrettyPrinted
                                                       error:&error];
  
  if (! jsonData)
    return nil;
  else
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+(void)setVoz:(NSInteger)voz
{
  [[NSUserDefaults standardUserDefaults] setInteger:voz forKey:@"mdvoz"];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSInteger)voz
{
  return  [[NSUserDefaults standardUserDefaults] integerForKey:@"mdvoz"];
}

+(NSString*)vozStr
{
   if([[NSUserDefaults standardUserDefaults] integerForKey:@"mdvoz"] ==  1000)
   {
     return @"F";
   }
  return @"M";
}


+(BOOL)checkInternet
{
  Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
  NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
  if (networkStatus == NotReachable)
    return NO;
  else
    return YES;
  
}


+(void)insertGradientInView:(UIView*)view
{
  CGRect frame = view.bounds;
  frame.size.width = CGRectGetWidth([UIScreen mainScreen].bounds);
  
  CAGradientLayer *gradient = [CAGradientLayer layer];
  gradient.frame = frame;
  gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor], (id)[[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0] CGColor], nil];
  [view.layer insertSublayer:gradient atIndex:0];
  
}

+(void)setColor:(UIColor*)color
{
  
  NSData *colorData = [NSKeyedArchiver archivedDataWithRootObject:color];
  [[NSUserDefaults standardUserDefaults] setObject:colorData forKey:@"LKDAYCOLOR"];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

+(UIColor*)color
{
  NSData *colorData = [[NSUserDefaults standardUserDefaults] objectForKey:@"LKDAYCOLOR"];
  UIColor *color = [NSKeyedUnarchiver unarchiveObjectWithData:colorData];
  return  color;
}


@end
