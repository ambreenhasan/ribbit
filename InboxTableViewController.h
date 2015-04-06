//
//  InboxTableViewController.h
//  Ribbit
//
//  Created by Ambreen Hasan on 4/2/15.
//  Copyright (c) 2015 Ambreen Hasan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface InboxTableViewController : UITableViewController


@property (nonatomic, strong) NSArray *messages;
@property (nonatomic, strong) PFObject *selectedMessage;
@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;
- (IBAction)signOut:(id)sender;

@end
