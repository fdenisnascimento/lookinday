//
//  AppSettings.h
//
//  Created by Denis Nascimento on 5/25/15
//  Copyright (c) 2015 Ths Solution. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface AppSettings : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) BOOL update;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
