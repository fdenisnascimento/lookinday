//
//  Categories.h
//
//  Created by Denis Nascimento on 5/21/15
//  Copyright (c) 2015 Ths Solution. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Categories : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double categoriesIdentifier;
@property (nonatomic, strong) NSArray *subcategories;
@property (nonatomic, strong) NSString *categoriesDescription;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
