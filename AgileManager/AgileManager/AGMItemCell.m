//
//  AGMItemCell.m
//  AgileManager
//
//  Created by Marcelo Russo on 5/29/13.
//  Copyright (c) 2013 Marcelo Russo. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "AGMItemCell.h"


@implementation AGMItemCell

{
     CAGradientLayer* _gradientLayer;
     CGPoint _originalCenter;
     CALayer *_itemCompleteLayer;
     
     BOOL _deleteOnDragRelease;
     BOOL _markCompleteOnDragRelease;
     BOOL _markReassingment;
     
     UILabel *_startLabel;
     UILabel *_toBacklogLabel;
     UILabel *_reassignLabel;
     
     NSString *toStart;
     NSString *toBacklog;
     NSString *reassign;
     
}

const float LABEL_LEFT_MARGIN = 15.0f;
const float UI_CUES_MARGIN = 10.0f;
const float UI_CUES_WIDTH = 350.0f;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
     self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {

          [self addCuesToSubview];
          
          /*
          // remove the default blue highlight for selected cells
          //self.selectionStyle = UITableViewCellSelectionStyleNone;
          _gradientLayer = [CAGradientLayer layer];
          _gradientLayer.frame = self.bounds;
          _gradientLayer.colors = @[(id)[[UIColor colorWithWhite:1.0f alpha:0.2f] CGColor],
                                    (id)[[UIColor colorWithWhite:1.0f alpha:0.1f] CGColor],
                                    (id)[[UIColor clearColor] CGColor],
                                    (id)[[UIColor colorWithWhite:0.0f alpha:0.1f] CGColor]];
          _gradientLayer.locations = @[@0.00f, @0.01f, @0.95f, @1.00f];
          [self.layer insertSublayer:_gradientLayer atIndex:0];
          
          // add a layer that renders a green background when an item is complete
          
          _itemCompleteLayer = [CALayer layer];
          _itemCompleteLayer.backgroundColor = [[[UIColor alloc] initWithRed:0.0 green:0.6 blue:0.0 alpha:1.0] CGColor];
          _itemCompleteLayer.hidden = YES;
          [self.layer insertSublayer:_itemCompleteLayer atIndex:0];
          */
          // add a pan recognizer
          UIGestureRecognizer* recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
          
          recognizer.delegate = self;
          
          [self addGestureRecognizer:recognizer];
     }
     return self;
}

-(void)layoutSubviews {
     [super layoutSubviews];
     // ensure the gradient layers occupies the full bounds
     _gradientLayer.frame = self.bounds;
     _itemCompleteLayer.frame = self.bounds;
//     _label.frame = CGRectMake(LABEL_LEFT_MARGIN, 0,
//                               self.bounds.size.width - LABEL_LEFT_MARGIN,self.bounds.size.height);
     _startLabel.frame = CGRectMake(-UI_CUES_WIDTH - UI_CUES_MARGIN, 0,
                                    UI_CUES_WIDTH, self.bounds.size.height);
     _toBacklogLabel.frame = CGRectMake(self.bounds.size.width + UI_CUES_MARGIN, 0,
                                        UI_CUES_WIDTH, self.bounds.size.height);
     
     _reassignLabel.frame = CGRectMake(-UI_CUES_WIDTH - UI_CUES_MARGIN, 0,
                                       UI_CUES_WIDTH, self.bounds.size.height);
}

-(void)setTodoItem:(AGMActionItemModel *)todoItem {
     _todoItem = todoItem;
     // we must update all the visual state associated with the model item
//     _label.text = todoItem.text;
//     _label.strikethrough = todoItem.completed;
//     _itemCompleteLayer.hidden = !todoItem.completed;
}

-(void)addCuesToSubview
{
     // add a tick and cross
     _startLabel = [self createCueLabel];
     toStart = @"Start \u2192";
     _startLabel.text = toStart;
     _startLabel.textAlignment = NSTextAlignmentRight;
     _startLabel.hidden = YES;
     [self addSubview:_startLabel];
     
     _toBacklogLabel = [self createCueLabel];
     _toBacklogLabel.text = @"\u2190 to Backlog";
     _toBacklogLabel.textAlignment = NSTextAlignmentLeft;
     [self addSubview:_toBacklogLabel];
     
     _reassignLabel = [self createCueLabel];
     reassign = @"Reassign \u265F";
     _reassignLabel.text = reassign;
     _reassignLabel.textAlignment = NSTextAlignmentRight;
     [self addSubview:_reassignLabel];

}

// utility method for creating the contextual cues
-(UILabel*) createCueLabel {
     UILabel* label = [[UILabel alloc] initWithFrame:CGRectNull];
     label.textColor = [UIColor whiteColor];
     label.font = [UIFont boldSystemFontOfSize:32.0];
     label.backgroundColor = [UIColor clearColor];
     return label;
}

//****************************************************
//****************************************************
#pragma mark - horizontal pan gesture methods
//****************************************************
//****************************************************
-(BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
     CGPoint translation = [gestureRecognizer translationInView:[self superview]];
     // Check for horizontal gesture
     if (fabsf(translation.x) > fabsf(translation.y)) {
          return YES;
     }
     return NO;
}

-(void)handlePan:(UIPanGestureRecognizer *)recognizer {
     // 1
     if (recognizer.state == UIGestureRecognizerStateBegan) {
          // if the gesture has just started, record the current centre location
          _originalCenter = self.center;
     }
     
     // 2
     if (recognizer.state == UIGestureRecognizerStateChanged) {
          // translate the center
          CGPoint translation = [recognizer translationInView:self];
          self.center = CGPointMake(_originalCenter.x + translation.x, _originalCenter.y);
          // determine whether the item has been dragged far enough to initiate a delete / complete
          
          _deleteOnDragRelease = self.frame.origin.x < -self.frame.size.width * 0.75;
          
          NSLog(@"Mark Completed : %d",_markCompleteOnDragRelease);
          NSLog(@"Mark Reassignment : %d",_markReassingment);
          
          _markCompleteOnDragRelease = self.frame.origin.x > self.frame.size.width * 0.75;
          _markReassingment = self.frame.origin.x > self.frame.size.width * 0.45;
          
          if (_markCompleteOnDragRelease) {
               _markReassingment = NO;
          }
          
          
          // fade the contextual cues
          float cueAlpha = fabsf(self.frame.origin.x) / (self.frame.size.width / 2);
          //_startLabel.alpha = cueAlpha;
          _toBacklogLabel.alpha = cueAlpha;
          
          // indicate when the item have been pulled far enough to invoke the given action
          _startLabel.textColor = _markCompleteOnDragRelease ?
          [UIColor greenColor] : [UIColor whiteColor];
          _toBacklogLabel.textColor = _deleteOnDragRelease ?
          [UIColor redColor] : [UIColor whiteColor];
          _reassignLabel.textColor = _markReassingment ?
          [UIColor yellowColor] : [UIColor whiteColor];
          
          _startLabel.hidden = !_markCompleteOnDragRelease;
          _reassignLabel.hidden = !_markReassingment;
          
          
     }
     
     // 3
     if (recognizer.state == UIGestureRecognizerStateEnded) {
          if (_deleteOnDragRelease) {
               // notify the delegate that this item should be deleted
               [self.delegate toDoItemDeleted:self.todoItem];
          }
          if (_markCompleteOnDragRelease){
               // mark the item as complete and update the UI state
               self.todoItem.completed = YES;
               _itemCompleteLayer.hidden = NO;
//               _label.strikethrough = YES;
          }
          
          if (_markReassingment){
               NSLog(@"REASSIGN PLEASE!");
               [self.delegate toDoItemReassigned:self.todoItem];
          }
          self.center = _originalCenter;
     }
     
     
     
}

@end
