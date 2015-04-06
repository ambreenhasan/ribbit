//
//  InboxTableViewController.m
//  Ribbit
//
//  Created by Ambreen Hasan on 4/2/15.
//  Copyright (c) 2015 Ambreen Hasan. All rights reserved.
//

#import "InboxTableViewController.h"
#import "ImageViewController.h"

@interface InboxTableViewController ()

@end

@implementation InboxTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.moviePlayer = [[MPMoviePlayerController alloc] init];
    
    PFUser *currentUser = [PFUser currentUser];
    
    if (currentUser) {
        NSLog(@"Current user: %@", currentUser.username);
    } else {
        [self performSegueWithIdentifier:@"showSignIn" sender:self];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Messages"];
    [query whereKey:@"recipientsIds" equalTo:[[PFUser currentUser] objectId]];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"%@, %@", error, error.userInfo);
        } else {
            self.messages = objects;
            [self.tableView reloadData];
             NSLog(@"%lu", (unsigned long)self.messages.count);
           
        }
    }];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showSignIn"]) {
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
        NSLog(@"show sign in %@", segue.identifier);
    } else if ([segue.identifier isEqualToString:@"showImage"]) {
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
        ImageViewController *imageViewController = (ImageViewController *)segue.destinationViewController;
         NSLog(@"show image %@", segue.identifier);
        imageViewController.message = self.selectedMessage;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.messages.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"inboxCell" forIndexPath:indexPath];
    
    PFObject *message = [self.messages objectAtIndex:indexPath.row];
    NSString *fileType = [message objectForKey:@"fileType"];
    cell.textLabel.text = [message objectForKey:@"username"];
    
    if ([fileType isEqualToString:@"image"]) {
        cell.imageView.image = [UIImage imageNamed:@"icon_image"];
    } else {
        cell.imageView.image = [UIImage imageNamed:@"icon_video"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     self.selectedMessage = [self.messages objectAtIndex:indexPath.row];
    NSString *fileType = [self.selectedMessage objectForKey:@"fileType"];
    
    if ([fileType isEqualToString:@"image"]) {
        [self performSegueWithIdentifier:@"showImage" sender:self];
    } else {
        PFFile *videoFile = [self.selectedMessage objectForKey:@"file"];
        NSURL *fileUrl = [NSURL URLWithString:videoFile.url];
        self.moviePlayer.contentURL = fileUrl;
        
        [self.moviePlayer prepareToPlay];
        
        AVAsset *videoThumbnail = [AVAsset assetWithURL:fileUrl];
        [AVAssetImageGenerator assetImageGeneratorWithAsset:videoThumbnail];
        
        [self.view addSubview:self.moviePlayer.view];
        [self.moviePlayer setFullscreen:YES animated:YES];
        
    }
    
    NSMutableArray *recipientsIds = [NSMutableArray arrayWithArray:[self.selectedMessage objectForKey:@"recipientsIds"]];
    NSLog(@"Recipients%@", recipientsIds);
    
    if ([recipientsIds count] == 1) {
        [self.selectedMessage deleteInBackground];
    } else {
        [recipientsIds removeObject:[[PFUser currentUser] objectId]];
        [self.selectedMessage setObject:recipientsIds forKey:@"recipientsIds"];
        [self.selectedMessage saveInBackground];
    }
    
}


- (IBAction)signOut:(id)sender {
    [PFUser logOut];
    [self performSegueWithIdentifier:@"showSignIn" sender:self];
}
@end
