//
//  AGMTableViewCellDelegate.h
//  AgileManager
//
//  Created by Marcelo Russo on 5/10/13.
//  Copyright (c) 2013 Marcelo Russo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AGMActionItemModel.h"

@protocol AGMTableViewCellDelegate <NSObject>

// indicates that the given item has been deleted
-(void) toDoItemDeleted:(AGMActionItemModel*)todoItem;

-(void) toDoItemReassigned:(AGMActionItemModel*)todoItem;

@end
