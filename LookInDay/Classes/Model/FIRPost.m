//
//  FIRPost.m
//  LookInDay
//
//  Created by Denis Nascimento on 6/27/16.
//  Copyright © 2016 Denis Nascimento. All rights reserved.
//

#import "FIRPost.h"

NSString *const kKLHOaEanT8ycKL9wtqGPhoto1 = @"photo1";
NSString *const kKLHOaEanT8ycKL9wtqGUid = @"uid";
NSString *const kKLHOaEanT8ycKL9wtqGPhoto2 = @"photo2";
NSString *const kKLHOaEanT8ycKL9wtqGPostType = @"postType";
NSString *const kKLHOaEanT8ycKL9wtqGScoreimage2 = @"scoreimage2";
NSString *const kKLHOaEanT8ycKL9wtqGUserName = @"user_name";
NSString *const kKLHOaEanT8ycKL9wtqGDescription = @"description";
NSString *const kKLHOaEanT8ycKL9wtqGUserPhoto = @"user_photo";
NSString *const kKLHOaEanT8ycKL9wtqGScoreimage1 = @"scoreimage1";
NSString *const kKLHOaEanT8ycKL9wtqGuserUID = @"userUID";
NSString *const kKLHOaEanT8ycKL9wtqGCreated = @"created";

@interface FIRPost()

@property(nonatomic,retain) FIRDatabaseReference *ref;
@property(nonatomic,retain) FIRStorageReference *storageRef;

@end

@implementation FIRPost

@synthesize photo1 = _photo1;
@synthesize uid = _uid;
@synthesize photo2 = _photo2;
@synthesize postType = _postType;
@synthesize scoreimage2 = _scoreimage2;
@synthesize userName = _userName;
@synthesize userPhoto = _userPhoto;
@synthesize scoreimage1 = _scoreimage1;
@synthesize descriptionValue = _descriptionValue;
@synthesize userUID = _userUID;
@synthesize created = _created;


+(void)updatePost:(FIRPost*)post completion:(completion)completion {
    
    NSDictionary *childUpdates = @{[@"/posts/" stringByAppendingString:post.uid]: post.dictionaryRepresentation,
                                   [NSString stringWithFormat:@"/user-posts/%@/%@/", [FIRAuth auth].currentUser.uid, post.uid]: post.dictionaryRepresentation};
    [[[FIRDatabase database] reference] updateChildValues:childUpdates withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
        if (error != nil) {
            completion(NO,nil);
        }else{
            completion(YES,ref);
        }
    }];
    
}


-(void)config{
    
    self.ref = [[FIRDatabase database] reference];
    
    FIRStorage *storage = [FIRStorage storage];
    self.storageRef = [storage referenceForURL:@"gs://look-in-day.appspot.com"];
    
}




-(void)savePost:(completion)completion {
    
    
    // no caso de existirem as duas imagens, eu envio a uma e depois a outra
    if (self.image2 != nil) {
        
        FIRStorageReference *riversRef = [_storageRef child:[FIRModel imageName]];
        [riversRef putData:self.image1 metadata:nil completion:^(FIRStorageMetadata *metadata, NSError *error) {
            if (error != nil) {
                NSLog(@"error:%@",error.description);
            } else {
                self.photo1 = metadata.downloadURL.absoluteString;
                
                // enviado a segunda imagem
                FIRStorageReference *imageS = [_storageRef child:[FIRModel imageName]];
                [imageS putData:self.image2 metadata:nil completion:^(FIRStorageMetadata *metadata, NSError *error) {
                    if (error != nil) {
                        NSLog(@"error:%@",error.description);
                    } else {
                        self.photo2 = metadata.downloadURL.absoluteString;
                        
                        NSString *key = [[_ref child:@"posts"] childByAutoId].key;
                        self.uid = key;
                        self.userUID = [FIRAuth auth].currentUser.uid;
                        self.created = [NSNumber numberWithDouble:[NSDate timeIntervalSinceReferenceDate]];
                        NSDictionary *childUpdates = @{[@"/posts/" stringByAppendingString:key]: self.dictionaryRepresentation,
                                                       [NSString stringWithFormat:@"/user-posts/%@/%@/", [FIRAuth auth].currentUser.uid, key]: self.dictionaryRepresentation};
                        [_ref updateChildValues:childUpdates withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
                            
                            if (error != nil) {
                                completion(NO,nil);
                            }else{
                                completion(YES,ref);
                            }
                            
                        }];
                        
                    }
                }];
                
            }
        }];
        
        
    }else{
        
        FIRStorageReference *riversRef = [_storageRef child:[FIRModel imageName]];
        [riversRef putData:self.image1 metadata:nil completion:^(FIRStorageMetadata *metadata, NSError *error) {
            if (error != nil) {
                NSLog(@"error:%@",error.description);
            } else {
                
                NSString *key = [[_ref child:@"posts"] childByAutoId].key;
                self.photo1 = metadata.downloadURL.absoluteString;
                self.uid = key;
                self.userUID = [FIRAuth auth].currentUser.uid;
                self.created = [NSNumber numberWithDouble:[NSDate timeIntervalSinceReferenceDate]];
                NSDictionary *childUpdates = @{[@"/posts/" stringByAppendingString:key]: self.dictionaryRepresentation,
                                               [NSString stringWithFormat:@"/user-posts/%@/%@/", [FIRAuth auth].currentUser.uid, key]: self.dictionaryRepresentation};
                [_ref updateChildValues:childUpdates withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
                    
                    if (error != nil) {
                        completion(NO,nil);
                    }else{
                        completion(YES,ref);
                    }
                    
                }];
                
            }
        }];
    }

}

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];

    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.photo1 = [self objectOrNilForKey:kKLHOaEanT8ycKL9wtqGPhoto1 fromDictionary:dict];
        self.uid = [self objectOrNilForKey:kKLHOaEanT8ycKL9wtqGUid fromDictionary:dict];
        self.photo2 = [self objectOrNilForKey:kKLHOaEanT8ycKL9wtqGPhoto2 fromDictionary:dict];
        self.postType = [[self objectOrNilForKey:kKLHOaEanT8ycKL9wtqGPostType fromDictionary:dict] doubleValue];
        self.scoreimage2 = [self objectOrNilForKey:kKLHOaEanT8ycKL9wtqGScoreimage2 fromDictionary:dict];
        self.userName = [self objectOrNilForKey:kKLHOaEanT8ycKL9wtqGUserName fromDictionary:dict];
        self.descriptionValue = [self objectOrNilForKey:kKLHOaEanT8ycKL9wtqGDescription fromDictionary:dict];
        self.userPhoto = [self objectOrNilForKey:kKLHOaEanT8ycKL9wtqGUserPhoto fromDictionary:dict];
        self.scoreimage1 = [self objectOrNilForKey:kKLHOaEanT8ycKL9wtqGScoreimage1 fromDictionary:dict];
        self.userUID = [self objectOrNilForKey:kKLHOaEanT8ycKL9wtqGuserUID fromDictionary:dict];
        self.created = [self objectOrNilForKey:kKLHOaEanT8ycKL9wtqGCreated fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.photo1 forKey:kKLHOaEanT8ycKL9wtqGPhoto1];
    [mutableDict setValue:self.uid forKey:kKLHOaEanT8ycKL9wtqGUid];
    [mutableDict setValue:self.photo2 forKey:kKLHOaEanT8ycKL9wtqGPhoto2];
    [mutableDict setValue:[NSNumber numberWithDouble:self.postType] forKey:kKLHOaEanT8ycKL9wtqGPostType];
    [mutableDict setValue:self.scoreimage2 forKey:kKLHOaEanT8ycKL9wtqGScoreimage2];
    [mutableDict setValue:self.userName forKey:kKLHOaEanT8ycKL9wtqGUserName];
    [mutableDict setValue:self.descriptionValue forKey:kKLHOaEanT8ycKL9wtqGDescription];
    [mutableDict setValue:self.userPhoto forKey:kKLHOaEanT8ycKL9wtqGUserPhoto];
    [mutableDict setValue:self.scoreimage1 forKey:kKLHOaEanT8ycKL9wtqGScoreimage1];
    [mutableDict setValue:self.userUID forKey:kKLHOaEanT8ycKL9wtqGuserUID];
    [mutableDict setValue:self.created forKey:kKLHOaEanT8ycKL9wtqGCreated];
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
    
    self.photo1 = [aDecoder decodeObjectForKey:kKLHOaEanT8ycKL9wtqGPhoto1];
    self.uid = [aDecoder decodeObjectForKey:kKLHOaEanT8ycKL9wtqGUid];
    self.userUID = [aDecoder decodeObjectForKey:kKLHOaEanT8ycKL9wtqGuserUID];
    self.photo2 = [aDecoder decodeObjectForKey:kKLHOaEanT8ycKL9wtqGPhoto2];
    self.postType = [aDecoder decodeDoubleForKey:kKLHOaEanT8ycKL9wtqGPostType];
    self.scoreimage2 = [aDecoder decodeObjectForKey:kKLHOaEanT8ycKL9wtqGScoreimage2];
    self.userName = [aDecoder decodeObjectForKey:kKLHOaEanT8ycKL9wtqGUserName];
    self.descriptionValue = [aDecoder decodeObjectForKey:kKLHOaEanT8ycKL9wtqGDescription];
    self.userPhoto = [aDecoder decodeObjectForKey:kKLHOaEanT8ycKL9wtqGUserPhoto];
    self.scoreimage1 = [aDecoder decodeObjectForKey:kKLHOaEanT8ycKL9wtqGScoreimage1];
    self.created = [aDecoder decodeObjectForKey:kKLHOaEanT8ycKL9wtqGCreated];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_photo1 forKey:kKLHOaEanT8ycKL9wtqGPhoto1];
    [aCoder encodeObject:_uid forKey:kKLHOaEanT8ycKL9wtqGUid];
    [aCoder encodeObject:_userUID forKey:kKLHOaEanT8ycKL9wtqGuserUID];
    [aCoder encodeObject:_photo2 forKey:kKLHOaEanT8ycKL9wtqGPhoto2];
    [aCoder encodeDouble:_postType forKey:kKLHOaEanT8ycKL9wtqGPostType];
    [aCoder encodeObject:_scoreimage2 forKey:kKLHOaEanT8ycKL9wtqGScoreimage2];
    [aCoder encodeObject:_userName forKey:kKLHOaEanT8ycKL9wtqGUserName];
    [aCoder encodeObject:_descriptionValue forKey:kKLHOaEanT8ycKL9wtqGDescription];
    [aCoder encodeObject:_userPhoto forKey:kKLHOaEanT8ycKL9wtqGUserPhoto];
    [aCoder encodeObject:_scoreimage1 forKey:kKLHOaEanT8ycKL9wtqGScoreimage1];
    [aCoder encodeObject:_created forKey:kKLHOaEanT8ycKL9wtqGCreated];
}

- (id)copyWithZone:(NSZone *)zone
{
    FIRPost *copy = [[FIRPost alloc] init];
    
    if (copy) {
        
        copy.photo1 = [self.photo1 copyWithZone:zone];
        copy.uid = [self.uid copyWithZone:zone];
        copy.userUID = [self.userUID copyWithZone:zone];
        copy.photo2 = [self.photo2 copyWithZone:zone];
        copy.postType = self.postType;
        copy.scoreimage2 = self.scoreimage2; //[self.scoreimage2 copyWithZone:zone];
        copy.userName = [self.userName copyWithZone:zone];
        copy.descriptionValue = [self.descriptionValue copyWithZone:zone];
        copy.userPhoto = [self.userPhoto copyWithZone:zone];
        copy.scoreimage1 = self.scoreimage1;// [self.scoreimage1 copyWithZone:zone];
        copy.created = [self.created copyWithZone:zone];
    }
    
    return copy;
}



@end
