//
//  AGMItemCell.h
//  AgileManager
//
//  Created by Marcelo Russo on 5/29/13.
//  Copyright (c) 2013 Marcelo Russo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGMTableViewCellDelegate.h"
#import "AGMActionItemModel.h"

@interface AGMItemCell : UITableViewCell

// The item that this cell renders.
@property (nonatomic) AGMActionItemModel *todoItem;

// The object that acts as delegate for this cell.
@property (nonatomic, assign) id<AGMTableViewCellDelegate> delegate;

// the label used to render the to-do text
//@property (nonatomic, strong, readonly) AGMStrikethroughLabel* label;


@property (weak, nonatomic) IBOutlet UILabel *storyNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *memberNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *originalFunctionalityLabel;

@property (weak, nonatomic) IBOutlet UILabel *storyPointsLabel;

@property (weak, nonatomic) IBOutlet UILabel *consumedHoursLabel;

@property (weak, nonatomic) IBOutlet UILabel *totalHoursLabel;

@end
