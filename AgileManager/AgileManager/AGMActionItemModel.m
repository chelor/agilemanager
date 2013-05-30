//
//  AGMToDoItem.m
//  AgileManager
//
//  Created by Marcelo Russo on 5/10/13.
//  Copyright (c) 2013 Marcelo Russo. All rights reserved.
//

#import "AGMActionItemModel.h"

@implementation AGMActionItemModel

-(id)initWithText:(NSString*)text {
    if (self = [super init]) {
        self.text = text;
    }
    return self;
}

+(id)toDoItemWithText:(NSString *)text {
    return [[AGMActionItemModel alloc] initWithText:text];
}



@end
