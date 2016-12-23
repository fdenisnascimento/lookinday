//
//  FIRModel.h
//  LookInDay
//
//  Created by Denis Nascimento on 6/27/16.
//  Copyright © 2016 Denis Nascimento. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"


@import Firebase;
@import FirebaseAuth;
@import FirebaseDatabase;
@import FirebaseStorage;

typedef void(^completion)(BOOL success, id result);

@interface FIRModel : NSObject

+(NSString*)imageName;
+(FIRDatabaseReference*)postReference;
+(FIRDatabaseReference*)commentsReferenceForPost:(NSString*)post;
+(FIRDatabaseReference*)scoreReferenceForPost:(NSString*)post;
+(FIRDatabaseReference*)favoritesReference;
+(FIRDatabaseReference*)postReferenceForUser;

@end
