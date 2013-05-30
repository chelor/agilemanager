//
//  AGMSecondViewController.m
//  AgileManager
//
//  Created by Marcelo Russo on 5/10/13.
//  Copyright (c) 2013 Marcelo Russo. All rights reserved.
//

#import "AGMSecondViewController.h"
#import "AGMTableContent.h"
//#import "AGMTableViewCell.h"
#import "AGMItemCell.h"

@implementation AGMSecondViewController
{
     // Declaro la variable de instancia que contendra los items
     //NSMutableArray *_backlogItems;
     AGMTableContent *tableContent;
     
     NSString *ident;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
     self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
     if (self) {
          self.title = NSLocalizedString(@"Backlog", @"Second");
          self.tabBarItem.image = [UIImage imageNamed:@"second"];
          
          tableContent =[AGMTableContent sharedMySingleton];
          //self->_backlogItems = [tableContent getBackloglist];
               self->ident = @"cell2";
          
     }
     return self;
}
- (void)viewWillAppear:(BOOL)animated{
     [self.tableView reloadData];
}

- (void)viewDidLoad
{
     [super viewDidLoad];
     // Do any additional setup after loading the view, typically from a nib.
     //Digo que el origen de mis datos esta dentro de mi clase....
     //self->_backlogItems = [tableContent getBackloglist];
     self.tableView.dataSource = self;
     //Digo que clase va a ser la celda
     //TODO: Como funciona el "identifier"
     
     //self->_backlogItems = [tableContent getBackloglist];
     
     [self.tableView registerClass:[AGMItemCell class] forCellReuseIdentifier:ident];
     
     self.tableView.delegate = self;
     
     self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     self.tableView.backgroundColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning
{
     [super didReceiveMemoryWarning];
     // Dispose of any resources that can be recreated.
}

-(void)toDoItemDeleted:(id)todoItem {
     float delay = 0.0;
     
     // remove the model object
     [[tableContent getBackloglist] removeObject:todoItem];
     
     // find the visible cells
     NSArray* visibleCells = [self.tableView visibleCells];
     
     UIView* lastView = [visibleCells lastObject];
     bool startAnimating = false;
     
     // iterate over all of the cells
     for(AGMItemCell* cell in visibleCells) {
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

-(void) toDoItemReassigned:(id)todoItem{
     float delay = 0.0;
     
     /// remove the model object
     [[tableContent getBackloglist] removeObject:todoItem];
     
     // find the visible cells
     NSArray* visibleCells = [self.tableView visibleCells];
     
     UIView* lastView = [visibleCells lastObject];
     bool startAnimating = false;
     
     // iterate over all of the cells
     for(AGMItemCell* cell in visibleCells) {
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
     return [tableContent getBackloglist].count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

     // re-use or create a cell
     AGMItemCell *cell = [tableView dequeueReusableCellWithIdentifier:ident forIndexPath:indexPath];
     // find the to-do item for this index
     int index = [indexPath row];
     AGMActionItemModel*item = [tableContent getBackloglist][index];
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

-(void)tableView:(UITableView *)tableView willDisplayCell:(AGMItemCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
     cell.backgroundColor = [UIColor grayColor];
}


@end
