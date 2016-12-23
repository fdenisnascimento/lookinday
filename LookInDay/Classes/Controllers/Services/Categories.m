//
//  Categories.m
//
//  Created by Denis Nascimento on 5/21/15
//  Copyright (c) 2015 Ths Solution. All rights reserved.
//

#import "Categories.h"
#import "Subcategories.h"


NSString *const kCategoriesId = @"id";
NSString *const kCategoriesSubcategories = @"Subcategories";
NSString *const kCategoriesCategoriesDescription = @"categories_description";


@interface Categories ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Categories

@synthesize categoriesIdentifier = _categoriesIdentifier;
@synthesize subcategories = _subcategories;
@synthesize categoriesDescription = _categoriesDescription;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.categoriesIdentifier = [[self objectOrNilForKey:kCategoriesId fromDictionary:dict] doubleValue];
    NSObject *receivedSubcategories = [dict objectForKey:kCategoriesSubcategories];
    NSMutableArray *parsedSubcategories = [NSMutableArray array];
    if ([receivedSubcategories isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedSubcategories) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedSubcategories addObject:[Subcategories modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedSubcategories isKindOfClass:[NSDictionary class]]) {
       [parsedSubcategories addObject:[Subcategories modelObjectWithDictionary:(NSDictionary *)receivedSubcategories]];
    }

    self.subcategories = [NSArray arrayWithArray:parsedSubcategories];
            self.categoriesDescription = [self objectOrNilForKey:kCategoriesCategoriesDescription fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.categoriesIdentifier] forKey:kCategoriesId];
    NSMutableArray *tempArrayForSubcategories = [NSMutableArray array];
    for (NSObject *subArrayObject in self.subcategories) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForSubcategories addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForSubcategories addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForSubcategories] forKey:kCategoriesSubcategories];
    [mutableDict setValue:self.categoriesDescription forKey:kCategoriesCategoriesDescription];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.categoriesIdentifier = [aDecoder decodeDoubleForKey:kCategoriesId];
    self.subcategories = [aDecoder decodeObjectForKey:kCategoriesSubcategories];
    self.categoriesDescription = [aDecoder decodeObjectForKey:kCategoriesCategoriesDescription];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_categoriesIdentifier forKey:kCategoriesId];
    [aCoder encodeObject:_subcategories forKey:kCategoriesSubcategories];
    [aCoder encodeObject:_categoriesDescription forKey:kCategoriesCategoriesDescription];
}

- (id)copyWithZone:(NSZone *)zone
{
    Categories *copy = [[Categories alloc] init];
    
    if (copy) {

        copy.categoriesIdentifier = self.categoriesIdentifier;
        copy.subcategories = [self.subcategories copyWithZone:zone];
        copy.categoriesDescription = [self.categoriesDescription copyWithZone:zone];
    }
    
    return copy;
}


@end
