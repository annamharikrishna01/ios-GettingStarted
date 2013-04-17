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
    
    // add these two lines of code to support the FBLoginView
    self.loginView.readPermissions = @[@"email", @"user_likes"];
    self.loginView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// FBLoginViewDelegate
-(void)loginView:(FBLoginView *)loginView handleError:(NSError *)error
{
    NSLog(@"There was an error! %@", error.description);
}

-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user
{
    NSLog(@"Fetched the user");
    
    NSString *greetingText = @"Greetings";
    NSString *userName = user.first_name;
    
    self.greetingLabel.text = [NSString stringWithFormat:@"%@ %@", greetingText, userName];
    self.profilePictureView.profileID = user.id;
    
    // see if the user has specified any languages
    // then iterate over the languages and see if they speak Klingon
    if ([user objectForKey:@"languages"]) {
        NSArray *languages = [user objectForKey:@"languages"];
        for (int i = 0; i < [languages count]; i++) {
            if([[[languages objectAtIndex:i] objectForKey:@"name"]
                isEqualToString:@"Klingon"]) {
                self.greetingLabel.text = @"Heghlu'meH QaQ jajvam!";
            }
        }
    }
}

-(void)loginViewShowingLoggedInUser:(FBLoginView *)loginView
{
    NSLog(@"A user is logged in");
}

-(void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView
{
    NSLog(@"There is no logged in user");
    self.greetingLabel.text = @"Login for a special greeting";
    self.profilePictureView.profileID = nil;
}

// actions for buttons
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

- (IBAction)placePickerButtonPressed:(id)sender
{
    FBPlacePickerViewController * placePickerController = [[FBPlacePickerViewController alloc] init];
    placePickerController.title = @"Pick a Place in Whistler";
    placePickerController.locationCoordinate = CLLocationCoordinate2DMake(50.1244,-122.9600);
    [placePickerController loadData];
    
    [placePickerController presentModallyFromViewController:self animated:YES handler:^(FBViewController *sender, BOOL donePressed) {
        NSString *placeName = placePickerController.selection.name;
        if(!placeName) {
            placeName = @"No Place Selected";
        }
        self.greetingLabel.text = [NSString stringWithFormat:@"Hope You Enjoy %@", placeName];
    }];
}

@end
