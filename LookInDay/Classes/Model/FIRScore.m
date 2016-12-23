//
//  FIRScore.m
//  LookInDay
//
//  Created by Denis Nascimento on 6/28/16.
//  Copyright © 2016 Denis Nascimento. All rights reserved.
//

#import "FIRScore.h"

NSString *const firscoreRating = @"rating";


@interface FIRScore()

@property(nonatomic,retain) FIRDatabaseReference *ref;
@property(nonatomic,retain) FIRStorageReference *storageRef;

@end

@implementation FIRScore

@synthesize rating = _rating;



+(void)ratingFromPost:(NSString*)post completion:(completion)completion {

    [[FIRModel scoreReferenceForPost:post] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSInteger score = 0;
        long sum = 0;
        for (FIRDataSnapshot* childSnap in snapshot.children.allObjects) {
            long balanceString = [childSnap.value longValue];
            sum = sum + balanceString;
        }
        if (sum == 0) {
            score = arc4random() % 4 + 1 ;
        }
        else
        {
            score= sum/snapshot.children.allObjects.count;
        }
        
        completion(YES,[NSNumber numberWithInteger:score]);
 
    }];
}


-(void)config{
    
    self.ref = [[FIRDatabase database] reference];
    
    FIRStorage *storage = [FIRStorage storage];
    self.storageRef = [storage referenceForURL:@"gs://look-in-day.appspot.com"];
    
}



-(void)save:(completion)completion {
    
    
    NSDictionary *childUpdates = @{
                                   [NSString stringWithFormat:@"/score/%@",self.post.uid]: self.dictionaryRepresentation,                                   
                                   };
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
        self.rating = [self objectOrNilForKey:firscoreRating fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.rating forKey:firscoreRating];

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
    
    self.rating = [aDecoder decodeObjectForKey:firscoreRating];

    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_rating forKey:firscoreRating];
}

- (id)copyWithZone:(NSZone *)zone
{
    FIRScore *copy = [[FIRScore alloc] init];
    
    if (copy) {
        
        copy.rating = self.rating;

    }
    
    return copy;
}


@end
