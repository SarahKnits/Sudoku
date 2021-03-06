//
//  BGSettingsViewController.h
//  Sudoku
//
//  Created by Sarah Gilkinson on 9/25/14.
//  Copyright (c) 2014 Blauzvern Gilkinson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BGSettingsViewController : UIViewController

- (IBAction) changeAllowInvalidMove: (UISwitch *) sender;

- (IBAction) changeDoNotCheckValidIfFull:(UISwitch *)sender;

@end
