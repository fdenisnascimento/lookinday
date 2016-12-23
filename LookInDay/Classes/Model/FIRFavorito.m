//
//  FIRFavorito.m
//  LookInDay
//
//  Created by Denis Nascimento on 6/27/16.
//  Copyright © 2016 Denis Nascimento. All rights reserved.
//

#import "FIRFavorito.h"

@interface FIRFavorito()

@property(nonatomic,retain) FIRDatabaseReference *ref;
@property(nonatomic,retain) FIRStorageReference *storageRef;

@end

@implementation FIRFavorito


-(void)config{
    
    self.ref = [[FIRDatabase database] reference];
    
    FIRStorage *storage = [FIRStorage storage];
    self.storageRef = [storage referenceForURL:@"gs://look-in-day.appspot.com"];
    
}

-(void)save:(completion)completion {

    NSDictionary *childUpdates = @{
                                   [NSString stringWithFormat:@"/favorites/%@/%@",[FIRAuth auth].currentUser.uid,self.post.uid]: self.post.dictionaryRepresentation,
                                   };
            [_ref updateChildValues:childUpdates withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
                
                if (error != nil) {
                    completion(NO,nil);
                }else{
                    completion(YES,ref);
                }
                
            }];

}

@end
