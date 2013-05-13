//
//  SingleEventViewController.m
//  FlintLocal
//
//  Created by Andrew Lenox on 5/12/13.
//  Copyright (c) 2013 Andrew Lenox. All rights reserved.
//

#import "SingleEventViewController.h"

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
