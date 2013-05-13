//
//  ViewController.m
//  FlintLocal
//
//  Created by Andrew Lenox on 9/27/12.
//  Copyright (c) 2012 Andrew Lenox. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "EventsViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(sessionStateChanged:)
     name:FBSessionStateChangedNotification
     object:nil];
    
    // Check the session for a cached token to show the proper authenticated
    // UI. However, since this is not user intitiated, do not show the login UX.
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate openSessionWithAllowLoginUI:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)queryButtonAction:(id)sender {
    

    NSString *nowString = [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];
    // Query to fetch the active user's friends, limit to 25.
    NSString *query =
    @"SELECT name, start_time, end_time, location,attending_count,venue,unsure_count,eid, pic_cover, pic_square, description FROM event WHERE eid IN ";
    query = [query stringByAppendingFormat:@"( SELECT eid FROM event_member WHERE uid = 143467719044302 AND start_time >= %@)", nowString ];
    // Set up the query parameter
    NSDictionary *queryParam = [NSDictionary dictionaryWithObjectsAndKeys:query, @"q", nil];
    // Make the API request that uses FQL
    [FBRequestConnection startWithGraphPath:@"/fql"
                                 parameters:queryParam
                                 HTTPMethod:@"GET"
                          completionHandler:^(FBRequestConnection *connection,
                                              id result,
                                              NSError *error) {
                              if (error) {
                                  NSLog(@"Error: %@", [error localizedDescription]);
                              } else {
                                  //NSLog(@"Result: %@", result);
                                  NSDictionary *json = (NSDictionary*)result;
                                  NSArray *events = json[@"data"];
                                  NSLog(@"events: %@", events);
                                  events = [events sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                                      NSString *start1String = obj1[@"start_time"];
                                      NSString *start2String = obj2[@"start_time"];
                                      NSDateFormatter *df = [[NSDateFormatter alloc] init];
                                      [df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZ"];
                                      NSDate *start1 = [df dateFromString:start1String];
                                      NSDate *start2 = [df dateFromString:start2String];
                                      return [start1 compare:start2];
                                  }];
                                  NSLog(@"events: %@", events);
                                  self.events = events;
                                  [self performSegueWithIdentifier:@"Events" sender:self];
                              }
                          }];
}

- (IBAction)authButtonAction:(id)sender {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    // The user has initiated a login, so call the openSession method
    // and show the login UX if necessary.
    if (FBSession.activeSession.isOpen) {
        [appDelegate closeSession];
    } else {
        [appDelegate openSessionWithAllowLoginUI:YES];
    }
}

- (void)sessionStateChanged:(NSNotification*)notification {
    if (FBSession.activeSession.isOpen) {
        [self.authButton setTitle:@"Logout" forState:UIControlStateNormal];
        self.queryButton.hidden = NO;
        self.multiQueryButton.hidden = NO;
    } else {
        [self.authButton setTitle:@"Login" forState:UIControlStateNormal];
        self.queryButton.hidden = YES;
        self.multiQueryButton.hidden = YES;
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Events"]) {
        EventsViewController *controller = segue.destinationViewController;
        controller.events = self.events;
    }
}

@end
