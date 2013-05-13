//
//  SingleEventViewController.h
//  FlintLocal
//
//  Created by Andrew Lenox on 5/12/13.
//  Copyright (c) 2013 Andrew Lenox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingleEventViewController : UIViewController
@property (nonatomic, strong) NSDictionary *event;
@property (weak, nonatomic) IBOutlet UIImageView *eventImage;

@property (weak, nonatomic) IBOutlet UILabel *eventTitle;
@property (weak, nonatomic) IBOutlet UILabel *eventDescription;

@end
