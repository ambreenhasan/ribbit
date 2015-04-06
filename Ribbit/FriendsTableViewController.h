//
//  FriendsTableViewController.h
//  Ribbit
//
//  Created by Ambreen Hasan on 4/3/15.
//  Copyright (c) 2015 Ambreen Hasan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface FriendsTableViewController : UITableViewController
@property (nonatomic, strong) PFRelation *friendsRelation;
@property (nonatomic, strong) NSArray *friends;
@end
