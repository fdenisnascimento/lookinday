//
//  THSParseModel.m
//  LookInDay
//
//  Created by Denis Nascimento on 6/29/15.
//  Copyright (c) 2015 Denis Nascimento. All rights reserved.
//

#import "THSModel.h"
#import "FIRPost.h"
#import "FIRComments.h"

@implementation THSModel


+(void)hasFavorite:(NSString*)post completion:(completion)completion {
    
    [[[FIRModel favoritesReference]child:post ] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        completion(YES,snapshot);
    }];
}


+(void)removeFavorite:(NSString*)post completion:(completion)completion {
    
    [[[FIRModel favoritesReference]child:post ] removeValue];
}

+(void)countFromPost:(NSString*)post completion:(completion)completion {
    
    [[FIRModel commentsReferenceForPost:post] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        completion(YES,[NSNumber numberWithInteger:snapshot.children.allObjects.count]);
    }];
}

+(void)allPosts:(completion)completion {

[[FIRModel postReference] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
    NSMutableArray *mute = [NSMutableArray array];
    for (FIRDataSnapshot* childSnap in snapshot.children.allObjects) {
        [mute addObject:[FIRPost modelObjectWithDictionary:childSnap.value]];
    }
    completion(YES,[[mute reverseObjectEnumerator] allObjects]);
}];

}


+(void)favoties:(completion)completion {
    
    [[FIRModel favoritesReference] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSMutableArray *mute = [NSMutableArray array];
        for (FIRDataSnapshot* childSnap in snapshot.children.allObjects) {
            [mute addObject:[FIRPost modelObjectWithDictionary:childSnap.value]];
        }
        completion(YES,[[mute reverseObjectEnumerator] allObjects]);
    }];
}

+(void)dicas:(completion)completion {
    
    [[FIRModel postReference]
     observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
         NSMutableArray *mute = [NSMutableArray array];
         for (FIRDataSnapshot* childSnap in snapshot.children.allObjects) {
             if ([[childSnap.value valueForKey:@"postType"] integerValue] == 2 ){
                 [mute addObject:[FIRPost modelObjectWithDictionary:childSnap.value]];
             }
         }
         completion(YES,[[mute reverseObjectEnumerator] allObjects]);
     }];
}


+(void)enquetes:(completion)completion {
    
    [[FIRModel postReference]
     observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
         NSMutableArray *mute = [NSMutableArray array];
         for (FIRDataSnapshot* childSnap in snapshot.children.allObjects) {
             if ([[childSnap.value valueForKey:@"postType"] integerValue] == 1 ){
                 [mute addObject:[FIRPost modelObjectWithDictionary:childSnap.value]];
             }
         }
         completion(YES,[[mute reverseObjectEnumerator] allObjects]);
     }];
}

+(void)looks:(completion)completion {
    
    [[FIRModel postReference]
     observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
         NSMutableArray *mute = [NSMutableArray array];
         for (FIRDataSnapshot* childSnap in snapshot.children.allObjects) {
             if ([[childSnap.value valueForKey:@"postType"] integerValue] == 0 ){
                 [mute addObject:[FIRPost modelObjectWithDictionary:childSnap.value]];
             }
         }
         completion(YES,[[mute reverseObjectEnumerator] allObjects]);
     }];
}



+(void)myDicas:(completion)completion {
    
    [[FIRModel postReferenceForUser]
     observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
         NSMutableArray *mute = [NSMutableArray array];
         for (FIRDataSnapshot* childSnap in snapshot.children.allObjects) {
             if ([[childSnap.value valueForKey:@"postType"] integerValue] == 2 ){
                 [mute addObject:[FIRPost modelObjectWithDictionary:childSnap.value]];
             }
         }
         completion(YES,[[mute reverseObjectEnumerator] allObjects]);
     }];
}


+(void)myEnquetes:(completion)completion {
    
    [[FIRModel postReferenceForUser]
     observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
         NSMutableArray *mute = [NSMutableArray array];
         for (FIRDataSnapshot* childSnap in snapshot.children.allObjects) {
             if ([[childSnap.value valueForKey:@"postType"] integerValue] == 1 ){
                 [mute addObject:[FIRPost modelObjectWithDictionary:childSnap.value]];
             }
         }
         completion(YES,[[mute reverseObjectEnumerator] allObjects]);
     }];
}

+(void)myLooks:(completion)completion {
    
    [[FIRModel postReferenceForUser]
     observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
         NSMutableArray *mute = [NSMutableArray array];
         for (FIRDataSnapshot* childSnap in snapshot.children.allObjects) {
             if ([[childSnap.value valueForKey:@"postType"] integerValue] == 0 ){
                 [mute addObject:[FIRPost modelObjectWithDictionary:childSnap.value]];
             }
         }
         completion(YES,[[mute reverseObjectEnumerator] allObjects]);
     }];
}


+(void)comments:(NSString*)post completion:(completion)completion {
    
    [[FIRModel commentsReferenceForPost:post] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSMutableArray *mute = [NSMutableArray array];
        for (FIRDataSnapshot* childSnap in snapshot.children.allObjects) {
            [mute addObject:[FIRComments modelObjectWithDictionary:childSnap.value]];
        }
        completion(YES,[[mute reverseObjectEnumerator] allObjects]);
    }];
}




+(void)sendPush:(NSString*)message channel:(NSString*)channel
{
    if (!channel)
        channel = @"lookinday";

    NSString *messageID = [NSString stringWithFormat:@"%@-%@",[FIRAuth auth].currentUser.uid,[NSDate dateWithTimeIntervalSinceNow:0]];
    [[FIRMessaging messaging]sendMessage:@{@"body":message} to:channel withMessageID:messageID timeToLive:3333];

}

+(void)subscribeToChannelInBackground
{
    if([FIRAuth auth].currentUser.uid )
    {
        [[FIRMessaging messaging]subscribeToTopic:[FIRAuth auth].currentUser.uid];
    }
}

+(void)removePost:(NSString*)post completion:(completion)completion {
    
    [[[FIRModel postReferenceForUser]child:post ] removeValue];
    [[[FIRModel postReference]child:post ] removeValue];
}

+(void)logout
{
    NSError *error;
    [[FIRAuth auth] signOut:&error];
    if (!error) {

    }
}

@end
