//
//  FIRComments.m
//  LookInDay
//
//  Created by Denis Nascimento on 6/27/16.
//  Copyright © 2016 Denis Nascimento. All rights reserved.
//

#import "FIRComments.h"

NSString *const commentComment = @"comment";
NSString *const commentUserName = @"user_name";
NSString *const commentUserPhoto = @"user_photo";


@interface FIRComments()

@property(nonatomic,retain) FIRDatabaseReference *ref;
@property(nonatomic,retain) FIRStorageReference *storageRef;

@end

@implementation FIRComments

@synthesize userName = _userName;
@synthesize userPhoto = _userPhoto;
@synthesize comment = _comment;


-(void)config{
  
  self.ref = [[FIRDatabase database] reference];
  
  FIRStorage *storage = [FIRStorage storage];
  self.storageRef = [storage referenceForURL:@"gs://look-in-day.appspot.com"];
  
}

-(void)save:(completion)completion {
  
  NSString *key = [[_ref child:@"comments"] childByAutoId].key;
 
  NSDictionary *childUpdates = @{[NSString stringWithFormat:@"/comments/%@/%@",self.post.uid,key]: self.dictionaryRepresentation };
  [_ref updateChildValues:childUpdates withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
    
    if (error != nil) {
      completion(NO,nil);
    }else{
      completion(YES,ref);
    }
    
  }];
  
}

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
  return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
  self = [super init];
  
  if(self && [dict isKindOfClass:[NSDictionary class]]) {
    self.userName = [self objectOrNilForKey:commentUserName fromDictionary:dict];
    self.comment = [self objectOrNilForKey:commentComment fromDictionary:dict];
    self.userPhoto = [self objectOrNilForKey:commentUserPhoto fromDictionary:dict];

    
  }
  
  return self;
  
}

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
  [mutableDict setValue:self.userName forKey:commentUserName];
  [mutableDict setValue:self.comment forKey:commentComment];
  [mutableDict setValue:self.userPhoto forKey:commentUserPhoto];

  
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

  self.userName = [aDecoder decodeObjectForKey:commentUserName];
  self.comment = [aDecoder decodeObjectForKey:commentComment];
  self.userPhoto = [aDecoder decodeObjectForKey:commentUserPhoto];

  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

  [aCoder encodeObject:_userName forKey:commentUserName];
  [aCoder encodeObject:_comment forKey:commentComment];
  [aCoder encodeObject:_userPhoto forKey:commentUserPhoto];

}

- (id)copyWithZone:(NSZone *)zone
{
  FIRComments *copy = [[FIRComments alloc] init];
  
  if (copy) {

    copy.comment = [self.comment copyWithZone:zone];
    copy.userPhoto = [self.userPhoto copyWithZone:zone];
    copy.userName = [self.userName copyWithZone:zone];
  }
  
  return copy;
}



@end
