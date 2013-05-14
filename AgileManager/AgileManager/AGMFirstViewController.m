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
#import "AGMTableContent.h"

@implementation AGMFirstViewController{
     // Declaro la variable de instancia que contendra los items
     NSMutableArray *_notStartedItemsx;
     AGMTableContent *tableContent;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
     // No se bien que es, pero es el "super" de este constructor
     self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
     
     //Aqui dentro va todo lo que "funciona"
     if (self) {
         
          //Defino el nombre de la solapa y su imagen tmb
         self.title = NSLocalizedString(@"Not Started", @"First");
         self.tabBarItem.image = [UIImage imageNamed:@"first"];
         
          //Populo el array de items
          //TODO: esto deberia reemplazarlo con la conexion al JSON2
          self->tableContent = [AGMTableContent sharedMySingleton];
          //self->_notStartedItems = [tableContent getNotStarted];

    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
     [self.tableView reloadData];
}
							
- (void)viewDidLoad
{
     [super viewDidLoad];
     //Digo que el origen de mis datos esta dentro de mi clase....
     
     self.tableView.dataSource = self;
     //Digo que clase va a ser la celda
     //TODO: Como funciona el "identifier"
     //self->_notStartedItems = [tableContent getNotStarted];
     
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
     
     NSUInteger itemCount = [tableContent getNotStarted].count - 1;
     float val = ((float)index / (float)itemCount) * 0.6;
     return [UIColor colorWithRed: 1.0 green:val blue: 0.0 alpha:1.0];
     
}

-(void)toDoItemDeleted:(id)todoItem {
     float delay = 0.0;
     
     // remove the model object
     [[tableContent getNotStarted] removeObject:todoItem];
     [[tableContent getBackloglist] addObject:todoItem];
     
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

-(void) toDoItemReassigned:(id)todoItem{
     float delay = 0.0;
     
     /// remove the model object
     [[tableContent getNotStarted] removeObject:todoItem];
     
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
    return [tableContent getNotStarted].count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *ident = @"cell";
    // re-use or create a cell
    AGMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident forIndexPath:indexPath];
    // find the to-do item for this index
    int index = [indexPath row];
    AGMToDoItem *item = [tableContent getNotStarted][index];
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
     cell.backgroundColor = [UIColor grayColor];
}

@end
