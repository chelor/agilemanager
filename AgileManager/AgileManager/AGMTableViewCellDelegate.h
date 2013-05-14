//
//  AGMTableViewCellDelegate.h
//  AgileManager
//
//  Created by Marcelo Russo on 5/10/13.
//  Copyright (c) 2013 Marcelo Russo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AGMToDoItem.h"

@protocol AGMTableViewCellDelegate <NSObject>

// indicates that the given item has been deleted
-(void) toDoItemDeleted:(AGMToDoItem*)todoItem;

-(void) toDoItemReassigned:(AGMToDoItem*)todoItem;

@end
