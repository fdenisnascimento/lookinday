//
//  NSString+Trim.h
//  MedSoft
//
//  Created by Toshiro Sugii on 2/18/14.
//  Copyright (c) 2014 MEDGRUPO Participações. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Trim)

- (NSString *)trim;
- (BOOL)isEmpty; // trim + !equal @"" +!nil

@end
