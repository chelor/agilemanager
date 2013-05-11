//
//  AGMToDoItem.h
//  AgileManager
//
//  Created by Marcelo Russo on 5/10/13.
//  Copyright (c) 2013 Marcelo Russo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AGMToDoItem : NSObject

// A text description of this item.
@property (nonatomic, copy) NSString *text;

// A Boolean value that determines the completed state of this item.
@property (nonatomic) BOOL completed;

// Returns an SHCToDoItem item initialized with the given text.
-(id)initWithText:(NSString*)text;

// Returns an SHCToDoItem item initialized with the given text.
+(id)toDoItemWithText:(NSString*)text;

@end
