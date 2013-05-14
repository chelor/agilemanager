//
//  AGMTableContent.h
//  AgileManager
//
//  Created by Marcelo Russo on 5/11/13.
//  Copyright (c) 2013 Marcelo Russo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AGMTableContent : NSObject

@property(nonatomic) NSMutableArray *notStartedList;
@property(nonatomic) NSMutableArray *backlogList;

+(AGMTableContent*)sharedMySingleton;

//-(NSMutableArray*)getTableData;

-(void) populateNotStarted:(NSMutableArray *)arr;
-(void) populateBacklog:(NSMutableArray *)arr;

-(NSMutableArray *)getNotStarted;
-(NSMutableArray *)getBackloglist;


@end
