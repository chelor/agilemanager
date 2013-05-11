//
//  AGMFirstViewController.m
//  AgileManager
//
//  Created by Marcelo Russo on 5/10/13.
//  Copyright (c) 2013 Marcelo Russo. All rights reserved.
//

#import "AGMFirstViewController.h"
#import "AGMToDoItem.h"
#import "AGMTableViewCell.h"

@implementation AGMFirstViewController{
    NSMutableArray *_toDoItems;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
         
         self.title = NSLocalizedString(@"Not Started", @"First");
         self.tabBarItem.image = [UIImage imageNamed:@"first"];
         
        _toDoItems = [[NSMutableArray alloc] init];
        [_toDoItems addObject:[AGMToDoItem toDoItemWithText:@"Feed the cat"]];
        [_toDoItems addObject:[AGMToDoItem toDoItemWithText:@"Buy eggs"]];
        [_toDoItems addObject:[AGMToDoItem toDoItemWithText:@"Pack bags for WWDC"]];
        [_toDoItems addObject:[AGMToDoItem toDoItemWithText:@"Rule the web"]];
        [_toDoItems addObject:[AGMToDoItem toDoItemWithText:@"Buy a new iPhone"]];
        [_toDoItems addObject:[AGMToDoItem toDoItemWithText:@"Find missing socks"]];
        [_toDoItems addObject:[AGMToDoItem toDoItemWithText:@"Write a new tutorial"]];
        [_toDoItems addObject:[AGMToDoItem toDoItemWithText:@"Master Objective-C"]];
        [_toDoItems addObject:[AGMToDoItem toDoItemWithText:@"Remember your wedding anniversary!"]];
        [_toDoItems addObject:[AGMToDoItem toDoItemWithText:@"Drink less beer"]];
        [_toDoItems addObject:[AGMToDoItem toDoItemWithText:@"Learn to draw"]];
        [_toDoItems addObject:[AGMToDoItem toDoItemWithText:@"Take the car to the garage"]];
        [_toDoItems addObject:[AGMToDoItem toDoItemWithText:@"Sell things on eBay"]];
        [_toDoItems addObject:[AGMToDoItem toDoItemWithText:@"Learn to juggle"]];
        [_toDoItems addObject:[AGMToDoItem toDoItemWithText:@"Give up"]];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
    [self.tableView registerClass:[AGMTableViewCell class] forCellReuseIdentifier:@"cell"];
     
     self.tableView.delegate = self;
     
     self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     self.tableView.backgroundColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIColor*)colorForIndex:(NSInteger) index {
     NSUInteger itemCount = _toDoItems.count - 1;
     float val = ((float)index / (float)itemCount) * 0.6;
     return [UIColor colorWithRed: 1.0 green:val blue: 0.0 alpha:1.0];
}

-(void)toDoItemDeleted:(id)todoItem {
     float delay = 0.0;
     
     // remove the model object
     [_toDoItems removeObject:todoItem];
     
     // find the visible cells
     NSArray* visibleCells = [self.tableView visibleCells];
     
     UIView* lastView = [visibleCells lastObject];
     bool startAnimating = false;
     
     // iterate over all of the cells
     for(AGMTableViewCell* cell in visibleCells) {
          if (startAnimating) {
               [UIView animateWithDuration:0.3
                                     delay:delay
                                   options:UIViewAnimationOptionCurveEaseInOut
                                animations:^{
                                     cell.frame = CGRectOffset(cell.frame, 0.0f, -cell.frame.size.height);
                                }
                                completion:^(BOOL finished){
                                     if (cell == lastView) {
                                          [self.tableView reloadData];
                                     }
                                }];
               delay+=0.03;
          }
          
          // if you have reached the item that was deleted, start animating
          if (cell.todoItem == todoItem) {
               startAnimating = true;
               cell.hidden = YES;
          }
     }
}

//*********************************************************************************
//*********************************************************************************
#pragma mark - UITableViewDataSource protocol methods
//*********************************************************************************
//*********************************************************************************
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _toDoItems.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *ident = @"cell";
    // re-use or create a cell
    AGMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident forIndexPath:indexPath];
    // find the to-do item for this index
    int index = [indexPath row];
    AGMToDoItem *item = _toDoItems[index];
    // set the text
    //cell.textLabel.text = item.text;
     
     cell.delegate = self;
     cell.todoItem = item;
     
    return cell;
}

//*********************************************************************************
//*********************************************************************************
#pragma mark - UITableViewDataDelegate protocol methods
//*********************************************************************************
//*********************************************************************************
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     return 50.0f;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(AGMTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
     cell.backgroundColor = [self colorForIndex:indexPath.row];
}

@end
