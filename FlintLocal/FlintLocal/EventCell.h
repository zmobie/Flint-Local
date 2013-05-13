//
//  EventCell.h
//  FlintLocal
//
//  Created by Andrew Lenox on 5/12/13.
//  Copyright (c) 2013 Andrew Lenox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *eventTitle;

@end
