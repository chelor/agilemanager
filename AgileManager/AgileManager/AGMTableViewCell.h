//
//  AGMTableViewCell.h
//  AgileManager
//
//  Created by Marcelo Russo on 5/10/13.
//  Copyright (c) 2013 Marcelo Russo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGMTableViewCellDelegate.h"
#import "AGMToDoItem.h"

@interface AGMTableViewCell : UITableViewCell

// The item that this cell renders.
@property (nonatomic) AGMToDoItem *todoItem;

// The object that acts as delegate for this cell.
@property (nonatomic, assign) id<AGMTableViewCellDelegate> delegate;

@end
