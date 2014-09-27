//
//  BGSettingsViewController.m
//  Sudoku
//
//  Created by Sarah Gilkinson on 9/25/14.
//  Copyright (c) 2014 Blauzvern Gilkinson. All rights reserved.
//

#import "BGSettingsViewController.h"

@interface BGSettingsViewController ()

@end

@implementation BGSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction) changeAllowInvalidMove: (UISwitch *) sender
{
    [[NSUserDefaults standardUserDefaults] setBool:[sender isOn] forKey:@"_allowInvalidMove"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"Setting is: %d", [[NSUserDefaults standardUserDefaults] boolForKey:@"_allowInvalidMove"]);
}

- (IBAction) changeDoNotCheckValidIfFull:(UISwitch *)sender
{
   [[NSUserDefaults standardUserDefaults] setBool:[sender isOn] forKey:@"_doNotCheckValidIfFull"];
   [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"Setting is: %d", [[NSUserDefaults standardUserDefaults] boolForKey:@"_doNotCheckValidIfFull"]);
}


@end
