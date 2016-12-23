//
//  NSString+Trim.m
//  MedSoft
//
//  Created by Toshiro Sugii on 2/18/14.
//  Copyright (c) 2014 MEDGRUPO Participações. All rights reserved.
//

#import "NSString+Trim.h"

@implementation NSString (Trim)

- (NSString *)trim
{
  return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)isEmpty
{
  return [[self trim] isEqualToString:@""];
}

@end
