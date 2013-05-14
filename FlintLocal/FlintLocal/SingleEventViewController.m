//
//  SingleEventViewController.m
//  FlintLocal
//
//  Created by Andrew Lenox on 5/12/13.
//  Copyright (c) 2013 Andrew Lenox. All rights reserved.
//

#import "SingleEventViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface SingleEventViewController ()

@end

@implementation SingleEventViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.eventDescription.text = self.event[@"description"];
    self.eventTitle.text = self.event[@"name"];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSURL *url = [NSURL URLWithString:self.event[@"pic_cover"][@"source"]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.eventImage.image = image;
        });
    });

}

-(void)rsvpEvent
{
    NSNumber *eventID = self.event[@"eid"];
    NSString *graphPath = [[eventID stringValue] stringByAppendingString:@"/attending"];
    FBRequest *request = [FBRequest requestForPostWithGraphPath:graphPath graphObject:nil];
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            //do something
            NSLog(@"success! %@", result);
        } else {
            NSLog(@"error: %@", error);
        }
    }];
}

- (IBAction)attendingButtonPressed:(id)sender {
    
    BOOL permissionGranted = [FBSession.activeSession.permissions containsObject:@"rsvp_event"];
    
    if (permissionGranted) {
        [self rsvpEvent];
    } else {
        [[FBSession activeSession] requestNewPublishPermissions:@[@"rsvp_event"] defaultAudience:FBSessionDefaultAudienceEveryone completionHandler:^(FBSession *session, NSError *error) {
            [self rsvpEvent];
        }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
