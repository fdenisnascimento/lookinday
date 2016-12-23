//
//  Rating.m
//
//  Created by Denis Nascimento on 5/26/15
//  Copyright (c) 2015 Ths Solution. All rights reserved.
//

#import "Rating.h"


NSString *const kRatingVote = @"vote";


@interface Rating ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Rating

@synthesize vote = _vote;


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
            self.vote = [[self objectOrNilForKey:kRatingVote fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.vote] forKey:kRatingVote];

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

    self.vote = [aDecoder decodeDoubleForKey:kRatingVote];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_vote forKey:kRatingVote];
}

- (id)copyWithZone:(NSZone *)zone
{
    Rating *copy = [[Rating alloc] init];
    
    if (copy) {

        copy.vote = self.vote;
    }
    
    return copy;
}


@end
