//
//  AGMFirstViewController.m
//  AgileManager
//
//  Created by Marcelo Russo on 5/10/13.
//  Copyright (c) 2013 Marcelo Russo. All rights reserved.
//

#import "AGMFirstViewController.h"
#import "AGMActionItemModel.h"

#import "AGMTableContent.h"
#import "AGMItemCell.h"

@implementation AGMFirstViewController{
     // Declaro la variable de instancia que contendra los items
     NSMutableArray *_notStartedItemsx;
     AGMTableContent *tableContent;
     
     NSString *ident;
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
         self->ident = @"cell1";
         
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
     
     [self.tableView registerClass:[AGMItemCell class] forCellReuseIdentifier:ident];
     
     
     self.tableView.delegate = self;
     
     self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
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
     [[tableContent getNotStarted] removeObject:todoItem];
     [[tableContent getBackloglist] addObject:todoItem];
     
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
 /*
          // if you have reached the item that was deleted, start animating
          if (cell.todoItem == todoItem) {
               startAnimating = true;
               cell.hidden = YES;
          }
  */
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
         /* if (cell.todoItem == todoItem) {
               startAnimating = true;
               cell.hidden = YES;
          }*/
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
    //NSString *ident = @"cell1";
    // re-use or create a cell
    AGMItemCell *cell = [self.tableView dequeueReusableCellWithIdentifier:ident];
     
     if (cell == nil) {
          NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"ItemCell" owner:self options:nil];
          
          for (UIView *view in views)
          {
               if ([view isKindOfClass:[UITableViewCell class]]) {
                    cell = (AGMItemCell *)view;
                    break;
               }
          }
     }
     
    // find the to-do item for this index
    int index = [indexPath row];
     //EL table content contiene los modelos de datos
    AGMActionItemModel *item = [tableContent getNotStarted][index];

     //Mando los datos del modelo a la presentacion visual de la celda.
    cell.storyNameLabel.text = item.text;
     
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
     return 200.0f;
}

//-(void)tableView:(UITableView *)tableView willDisplayCell:(AGMItemCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//     cell.backgroundColor = [UIColor grayColor];
//}

@end
