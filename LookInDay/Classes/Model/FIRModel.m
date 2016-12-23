//
//  FIRModel.m
//  LookInDay
//
//  Created by Denis Nascimento on 6/27/16.
//  Copyright © 2016 Denis Nascimento. All rights reserved.
//

#import "FIRModel.h"


@implementation FIRModel


+(NSString*)imageName{
    return [NSString stringWithFormat:@"images/%@",[NSDate dateWithTimeIntervalSinceNow:0]];
}

+(FIRDatabaseReference*)postReference{
    
    return   [[[FIRDatabase database] reference] child:@"posts"];
}

+(FIRDatabaseReference*)commentsReferenceForPost:(NSString*)post {
  return   [[[[FIRDatabase database] reference] child:@"comments"] child:post];
}

+(FIRDatabaseReference*)scoreReferenceForPost:(NSString*)post{
  return   [[[[FIRDatabase database] reference] child:@"score"] child:post];
}

+(FIRDatabaseReference*)favoritesReference{
    return   [[[[FIRDatabase database] reference] child:@"favorites"] child:[FIRAuth auth].currentUser.uid];
}

+(FIRDatabaseReference*)postReferenceForUser{    
    return   [[[[FIRDatabase database] reference] child:@"user-posts"]child:[FIRAuth auth].currentUser.uid];
}

@end
