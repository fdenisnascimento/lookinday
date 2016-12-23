//
//  Rating.h
//
//  Created by Denis Nascimento on 5/26/15
//  Copyright (c) 2015 Ths Solution. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Rating : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double vote;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
