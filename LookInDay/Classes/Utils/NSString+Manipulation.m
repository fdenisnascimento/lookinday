//
//  NSString+Manipulation.m
//  voltem
//
//  Created by Toshiro Sugii on 11/21/14.
//  Copyright (c) 2014 Denis Nascimento. All rights reserved.
//

#import "NSString+Manipulation.h"

@implementation NSString (Manipulation)

- (NSString *)camelCaseToUndescoreString
{
  NSMutableString *output = [NSMutableString string];
  NSCharacterSet *uppercase = [NSCharacterSet uppercaseLetterCharacterSet];
  for (NSInteger idx = 0; idx < [self length]; idx += 1) {
    unichar c = [self characterAtIndex:idx];
    if ([uppercase characterIsMember:c]) {
      [output appendFormat:@"_%@", [[NSString stringWithCharacters:&c length:1] lowercaseString]];
    } else {
      [output appendFormat:@"%C", c];
    }
  }
  return output;
}

- (NSString *)underscodeToCamelCaseString
{
  NSMutableString *output = [NSMutableString string];
  BOOL makeNextCharacterUpperCase = NO;
  for (NSInteger idx = 0; idx < [self length]; idx += 1) {
    unichar c = [self characterAtIndex:idx];
    if (c == '_') {
      makeNextCharacterUpperCase = YES;
    } else if (makeNextCharacterUpperCase) {
      [output appendString:[[NSString stringWithCharacters:&c length:1] uppercaseString]];
      makeNextCharacterUpperCase = NO;
    } else {
      [output appendFormat:@"%C", c];
    }
  }
  return output;
}

@end
