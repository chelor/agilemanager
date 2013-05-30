//
//  AGMTableContent.m
//  AgileManager
//
//  Created by Marcelo Russo on 5/11/13.
//  Copyright (c) 2013 Marcelo Russo. All rights reserved.
//

#import "AGMTableContent.h"
#import "AGMActionItemModel.h"

@implementation AGMTableContent
{
     NSMutableArray *dummy;
     NSMutableArray *backlogDummy;

}

static AGMTableContent* _sharedMySingleton = nil;

+(AGMTableContent*)sharedMySingleton
{
     @synchronized([AGMTableContent class])
     {
          if (!_sharedMySingleton)
               _sharedMySingleton = [[self alloc] init];
          
          return _sharedMySingleton;
     }
     
     return nil;
}

- (id)init
{
     self = [super init];
     if (self) {
          
          dummy = [[NSMutableArray alloc] init];
          backlogDummy = [[NSMutableArray alloc] init];
          
          self.notStartedList = [[NSMutableArray alloc] init];
          self.backlogList = [[NSMutableArray alloc] init];
          
          [dummy addObject:@"Feed the cat"];
          [dummy addObject:@"Buy eggs"];
          [dummy addObject:@"Pack bags for WWDC"];
          [dummy addObject:@"Rule the web"];
          [dummy addObject:@"Buy a new iPhone"];
          [dummy addObject:@"Find missing socks"];
          [dummy addObject:@"Write a new tutorial"];
          [dummy addObject:@"Master Objective-C"];
          [dummy addObject:@"Remember your wedding anniversary!"];
          [dummy addObject:@"Drink less beer"];
          [dummy addObject:@"Learn to draw"];
          [dummy addObject:@"Take the car to the garage"];
          [dummy addObject:@"Sell things on eBay"];
          [dummy addObject:@"Learn to juggle"];
          [dummy addObject:@"Give up"];
          
          [self populateNotStarted:dummy];
          
          [backlogDummy addObject:@"Backlog 1"];
          [backlogDummy addObject:@"Backlog 2"];
          [backlogDummy addObject:@"Backlog 3"];
          
          [self populateBacklog:backlogDummy];
          
     }
     return self;
}

-(void) populateNotStarted:(NSMutableArray *)arr{
     int i;

     for (i=0; i<[arr count]; i++) {
          [self.notStartedList addObject:[AGMActionItemModel toDoItemWithText:[arr objectAtIndex:i]]];
     }

}


-(void) populateBacklog:(NSMutableArray *)arr{
     int i;
     
     for (i=0; i<[arr count]; i++) {
          [self.backlogList addObject:[AGMActionItemModel toDoItemWithText:[arr objectAtIndex:i]]];
     }
     
}

-(NSMutableArray *)getNotStarted{
     return self.notStartedList;
}

-(NSMutableArray *)getBackloglist{
     return self.backlogList;
}

@end