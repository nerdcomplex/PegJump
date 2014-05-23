//
//  DropDownViewController.h
//
//  Created by brshapiro on 5/22/14.
//  Copyright (c) 2014 Bradley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropDownViewController : UITableViewController

@property (strong,nonatomic) NSMutableArray *options;

- (id) init: (NSMutableArray *) options;
- (void) collapse;

@end
