//
//  ViewController.h
//  FlintLocal
//
//  Created by Andrew Lenox on 9/27/12.
//  Copyright (c) 2012 Andrew Lenox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *authButton;
@property (weak, nonatomic) IBOutlet UIButton *queryButton;
@property (weak, nonatomic) IBOutlet UIButton *multiQueryButton;

@property (strong, nonatomic) NSArray *events;

@end
