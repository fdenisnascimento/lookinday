//
//  Messages.m
//
//  Created by Denis Nascimento on 5/21/15
//  Copyright (c) 2015 Ths Solution. All rights reserved.
//

#import "Messages.h"


NSString *const kMessagesMessagesGender = @"messages_gender";
NSString *const kMessagesId = @"id";
NSString *const kMessagesMessagesPath = @"messages_path";
NSString *const kMessagesMessagesFilename = @"messages_filename";
NSString *const kMessagesMessagesName = @"messages_name";


@interface Messages ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Messages

@synthesize messagesGender = _messagesGender;
@synthesize messagesIdentifier = _messagesIdentifier;
@synthesize messagesPath = _messagesPath;
@synthesize messagesFilename = _messagesFilename;
@synthesize messagesName = _messagesName;


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
            self.messagesGender = [self objectOrNilForKey:kMessagesMessagesGender fromDictionary:dict];
            self.messagesIdentifier = [[self objectOrNilForKey:kMessagesId fromDictionary:dict] doubleValue];
            self.messagesPath = [self objectOrNilForKey:kMessagesMessagesPath fromDictionary:dict];
            self.messagesFilename = [self objectOrNilForKey:kMessagesMessagesFilename fromDictionary:dict];
            self.messagesName = [self objectOrNilForKey:kMessagesMessagesName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.messagesGender forKey:kMessagesMessagesGender];
    [mutableDict setValue:[NSNumber numberWithDouble:self.messagesIdentifier] forKey:kMessagesId];
    [mutableDict setValue:self.messagesPath forKey:kMessagesMessagesPath];
    [mutableDict setValue:self.messagesFilename forKey:kMessagesMessagesFilename];
    [mutableDict setValue:self.messagesName forKey:kMessagesMessagesName];

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

    self.messagesGender = [aDecoder decodeObjectForKey:kMessagesMessagesGender];
    self.messagesIdentifier = [aDecoder decodeDoubleForKey:kMessagesId];
    self.messagesPath = [aDecoder decodeObjectForKey:kMessagesMessagesPath];
    self.messagesFilename = [aDecoder decodeObjectForKey:kMessagesMessagesFilename];
    self.messagesName = [aDecoder decodeObjectForKey:kMessagesMessagesName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_messagesGender forKey:kMessagesMessagesGender];
    [aCoder encodeDouble:_messagesIdentifier forKey:kMessagesId];
    [aCoder encodeObject:_messagesPath forKey:kMessagesMessagesPath];
    [aCoder encodeObject:_messagesFilename forKey:kMessagesMessagesFilename];
    [aCoder encodeObject:_messagesName forKey:kMessagesMessagesName];
}

- (id)copyWithZone:(NSZone *)zone
{
    Messages *copy = [[Messages alloc] init];
    
    if (copy) {

        copy.messagesGender = [self.messagesGender copyWithZone:zone];
        copy.messagesIdentifier = self.messagesIdentifier;
        copy.messagesPath = [self.messagesPath copyWithZone:zone];
        copy.messagesFilename = [self.messagesFilename copyWithZone:zone];
        copy.messagesName = [self.messagesName copyWithZone:zone];
    }
    
    return copy;
}


@end
