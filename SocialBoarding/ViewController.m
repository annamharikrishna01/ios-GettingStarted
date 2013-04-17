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

- (IBAction)nativeShareButtonPressed:(id)sender
{
    // temporary line of code required
    // this will only work in debug mode
    // you cannot ship this code
    [FBSettings enableBetaFeature:FBBetaFeaturesShareDialog];
    
    [FBDialogs presentShareDialogWithLink:[NSURL URLWithString:@"http://hollywoodlife.com/2013/04/06/celebrity-pets-justin-bieber-monkey-pics/"] handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
        if(error) {
            NSLog(@"Error: %@", error.description);
        }
    }];
}

- (IBAction)nativeOGShareButtonPressed:(id)sender
{
    NSMutableDictionary<FBOpenGraphObject> *run = [FBGraphObject openGraphObjectForPost];
    run[@"type"] = @"snsocialboarding:run";
    run[@"title"] = @"Dave Murray Downhill";
    run[@"description"] = @"Site of the 2010 Men's Olympic Downhill";
    run[@"data"] = @{ @"location": @{@"latitude": @"48.515414",
                                     @"longitude": @"-120.707605",
                                     } };
    run.provisionedForPost = YES;
    
    id<FBGraphPlace> place = (id<FBGraphPlace>)[FBGraphObject graphObject];
    [place setId:@"11092928401"];
    
    id<FBOpenGraphAction> action = (id<FBOpenGraphAction>)[FBGraphObject openGraphActionForPost];
    [action setObject:run forKey:@"run"]; // object tag
    [action setPlace:place]; // place tag
    [action setTags:@[@"1683794025"]]; // user tags
    
    // temporary line of code required
    // this will only work in debug mode
    // you cannot ship this code yet
    [FBSettings enableBetaFeature:FBBetaFeaturesOpenGraphShareDialog];
    
    [FBDialogs presentShareDialogWithOpenGraphAction:action
                                          actionType:@"snsocialboarding:ride"
                                 previewPropertyName:@"run"
                                             handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                                 if(error) {
                                                     NSLog(@"Error: %@", error.description);
                                                 }
                                             }];
}

@end
