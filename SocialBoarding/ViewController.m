//
//  ViewController.m
//  SocialBoarding
//
//  Created by Prashant Sridharan on 4/17/13.
//  Copyright (c) 2013 Prashant Sridharan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shareButtonPressed:(id)sender
{
    [FBDialogs presentOSIntegratedShareDialogModallyFrom:self initialText:@"This is actually not permitted" image:[UIImage imageNamed:@"image.jpg"] url:[NSURL URLWithString:@"http://www.cbssports.com/nfl/blog/eye-on-football/22027152/mike-shanahan-rg3-will-set-a-record-for-coming-back-from-injury"] handler:^(FBOSIntegratedShareDialogResult result, NSError *error) {
        if(error) {
            NSLog(@"Error: %@", error.description);
        }
    }];
}

@end
