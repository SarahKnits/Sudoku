//
//  BGStartScreenViewController.m
//  Sudoku
//
//  Created by Sarah Gilkinson on 9/27/14.
//  Copyright (c) 2014 Blauzvern Gilkinson. All rights reserved.
//

#import "BGStartScreenViewController.h"

@interface BGStartScreenViewController ()

@end

@implementation BGStartScreenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-fabric-1680-800x500.png"]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startNewGame:(id)sender
{
    // This is to fix an issue with iOS, help from
    // http://stackoverflow.com/questions/24854802/presenting-a-view-controller-modally-from-an-action-sheets-delegate-in-ios8
    dispatch_async(dispatch_get_main_queue(), ^ {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"_restoreSavedGame"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self performSegueWithIdentifier:@"startToGrid" sender:self];
    });
}

- (IBAction)restoreSavedGame:(id)sender
{
    // This is to fix an issue with iOS, help from
    // http://stackoverflow.com/questions/24854802/presenting-a-view-controller-modally-from-an-action-sheets-delegate-in-ios8
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"_savedGrid"] == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Saved Game!"
                                                        message:@"You don't have a saved game. Click Start New Game."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^ {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"_restoreSavedGame"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self performSegueWithIdentifier:@"startToGrid" sender:self];
        });
    }
}

- (IBAction)deleteSavedGame:(id)sender
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"_savedGrid"] == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Saved Game!"
                                                        message:@"You have no game to delete!"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete Saved Game?"
                                                        message:@"Are you sure you want to delete the game?"
                                                       delegate:self
                                              cancelButtonTitle:@"NO"
                                              otherButtonTitles:@"YES", nil];
        [alert show];
    }
}

- (void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"_savedGrid"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (IBAction) exitFromSettings:(UIStoryboardSegue *) segue
{
    // Do nothing
}

@end
