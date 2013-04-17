//
//  ViewController.h
//  SocialBoarding
//
//  Created by Prashant Sridharan on 4/17/13.
//  Copyright (c) 2013 Prashant Sridharan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface ViewController : UIViewController <FBLoginViewDelegate>
@property (weak, nonatomic) IBOutlet FBProfilePictureView *profilePictureView;
@property (weak, nonatomic) IBOutlet UILabel *greetingLabel;
@property (weak, nonatomic) IBOutlet FBLoginView *loginView;

- (IBAction)shareButtonPressed:(id)sender;
- (IBAction)nativeShareButtonPressed:(id)sender;
- (IBAction)nativeOGShareButtonPressed:(id)sender;
- (IBAction)placePickerButtonPressed:(id)sender;

@end
