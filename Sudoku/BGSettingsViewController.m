//
//  BGSettingsViewController.m
//  Sudoku
//
//  Created by Sarah Gilkinson on 9/25/14.
//  Copyright (c) 2014 Blauzvern Gilkinson. All rights reserved.
//

#import "BGSettingsViewController.h"

@interface BGSettingsViewController () {

    UISwitch * _allowInvalidMoveSwitch;
    UISwitch * _doNotCheckValidIfFullSwitch;
}


@end

@implementation BGSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _allowInvalidMoveSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(435, 319, 51, 31)];
    _doNotCheckValidIfFullSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(435, 262, 51, 31)];
    
    [self.view addSubview:_allowInvalidMoveSwitch];
    [self.view addSubview:_doNotCheckValidIfFullSwitch];
    
    [_allowInvalidMoveSwitch setOn:[[NSUserDefaults standardUserDefaults]
                                    boolForKey:@"_allowInvalidMove"]];
    [_doNotCheckValidIfFullSwitch setOn:[[NSUserDefaults standardUserDefaults]
                                         boolForKey:@"_doNotCheckValidIfFull"]];
    
    [_allowInvalidMoveSwitch addTarget:self action:@selector(changeAllowInvalidMove:)
                      forControlEvents:UIControlEventValueChanged];
    [_doNotCheckValidIfFullSwitch addTarget:self action:@selector(changeDoNotCheckValidIfFull:)
                           forControlEvents:UIControlEventValueChanged];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction) changeAllowInvalidMove: (UISwitch *) sender
{
    [[NSUserDefaults standardUserDefaults] setBool:[sender isOn] forKey:@"_allowInvalidMove"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction) changeDoNotCheckValidIfFull:(UISwitch *)sender
{
   [[NSUserDefaults standardUserDefaults] setBool:[sender isOn] forKey:@"_doNotCheckValidIfFull"];
   [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
