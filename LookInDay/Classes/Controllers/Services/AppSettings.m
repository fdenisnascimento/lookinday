//
//  AppSettings.m
//
//  Created by Denis Nascimento on 5/25/15
//  Copyright (c) 2015 Ths Solution. All rights reserved.
//

#import "AppSettings.h"


NSString *const kAppSettingsUpdate = @"update";


@interface AppSettings ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation AppSettings

@synthesize update = _update;


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
            self.update = [[self objectOrNilForKey:kAppSettingsUpdate fromDictionary:dict] boolValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithBool:self.update] forKey:kAppSettingsUpdate];

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

    self.update = [aDecoder decodeBoolForKey:kAppSettingsUpdate];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeBool:_update forKey:kAppSettingsUpdate];
}

- (id)copyWithZone:(NSZone *)zone
{
    AppSettings *copy = [[AppSettings alloc] init];
    
    if (copy) {

        copy.update = self.update;
    }
    
    return copy;
}


@end
