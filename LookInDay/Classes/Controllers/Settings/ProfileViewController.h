//
//  ProfileViewController.h
//  LookInDay
//
//  Created by Denis Nascimento on 11/3/15.
//  Copyright © 2015 Denis Nascimento. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ProfileViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *viewHeader;
@property (strong, nonatomic) IBOutlet UIView *viewSegment;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControll;

- (IBAction)tapSegmentControll:(UISegmentedControl*)sender;
@end
