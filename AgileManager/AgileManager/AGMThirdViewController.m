//
//  AGMThirdViewController.m
//  AgileManager
//
//  Created by Marcelo Russo on 5/14/13.
//  Copyright (c) 2013 Marcelo Russo. All rights reserved.
//

#import "AGMThirdViewController.h"

@interface AGMThirdViewController ()

@end

@implementation AGMThirdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         //Defino el nombre de la solapa y su imagen tmb
         self.title = NSLocalizedString(@"ALGO", @"Third");
         self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
