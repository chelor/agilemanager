//
//  AGMSecondViewController.h
//  AgileManager
//
//  Created by Marcelo Russo on 5/10/13.
//  Copyright (c) 2013 Marcelo Russo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGMTableViewCellDelegate.h"

@interface AGMSecondViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, AGMTableViewCellDelegate>

@property(weak,nonatomic) IBOutlet UITableView *tableView;

@end
