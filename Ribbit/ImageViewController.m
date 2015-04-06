//
//  ImageViewController.m
//  Ribbit
//
//  Created by Ambreen Hasan on 4/3/15.
//  Copyright (c) 2015 Ambreen Hasan. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PFFile *imageFile = [self.message objectForKey:@"file"];
    
    NSURL *imageFileUrl = [[NSURL alloc] initWithString:imageFile.url];
    
    NSData *imageData = [NSData dataWithContentsOfURL:imageFileUrl];
    
    self.imageView.image = [UIImage imageWithData:imageData];
    
    NSString *senderName = [self.message objectForKey:@"username"];
    self.navigationItem.title = [NSString stringWithFormat:@"Sent from %@", senderName];
    
    // Do any additional setup after loading the view.
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    if ([self respondsToSelector:@selector(timeOut)]) {
        [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(timeOut) userInfo:nil repeats:NO];
    } else {
        NSLog(@"Error:selector missing");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper Methods

- (void) timeOut {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
