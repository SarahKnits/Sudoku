//
//  BGViewController.m
//  Sudoku
//
//  Created by Sarah Gilkinson on 9/11/14.
//  Copyright (c) 2014 Blauzvern Gilkinson. All rights reserved.
//

#import "BGViewController.h"
#import "BGGridView.h"
#import "BGGridModel.h"
#import "BGNumPadView.h"
#import <QuartzCore/QuartzCore.h>

@interface BGViewController() <BGGridViewDelegate, BGNumPadViewDelegate> {
    BGGridView* _gridView;
    BGGridModel* _gridModel;
    BGNumPadView* _numPadView;
    UIActionSheet* _menu;
}

@end

@implementation BGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Create grid frame
    CGRect frame = self.view.bounds;
    CGFloat x = CGRectGetWidth(frame)*.1;
    CGFloat y = CGRectGetHeight(frame)*.1;
    CGFloat size = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.80;
    
    CGRect gridFrame = CGRectMake(x, y, size, size);
    
    // Create grid view
    _gridView = [[BGGridView alloc] initWithFrame:gridFrame];
    // Assign gridView's delegate to be the controller
    _gridView.delegate = self;
    // Populate the grid with the initial grid
    [_gridView makeNewGridViewOfSize:size];
    
    [self.view addSubview:_gridView];
    
    CGRect numPadFrame = CGRectMake(x, 2*y + size, size, ((size*.96)/ 9) + 0.02*size); // Adjust as we figure this out
    
    // Create num Pad view
    _numPadView = [[BGNumPadView alloc] initWithFrame:numPadFrame];
    // Assign numPadView's delegate to be the controller
    _numPadView.delegate = self;
    
    [self.view addSubview:_numPadView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"Options Menu" forState:UIControlStateNormal];
    [button sizeToFit];
    button.center = CGPointMake(CGRectGetWidth(frame)*.9, CGRectGetHeight(frame)*.95);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.tintColor = [UIColor darkGrayColor];
    [button addTarget:self action:@selector(showActionSheet:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"_restoreSavedGame"]) {
        _gridModel = [[BGGridModel alloc] restoreGrid];
    } else {
        _gridModel = [[BGGridModel alloc] initRandomFromFile:@"grid1"];
    }
    
    if (animated) {
        for (int i = 0; i < 9; i++) {
            for (int j = 0; j < 9; j++) {
                [_gridView setValue:[_gridModel getValueAtRow:i andCol:j] AtRow:i andCol:j
                       andIsInitial:![_gridModel canChangeAtRow:i andCol:j]];
                // [NSThread sleepForTimeInterval:0.1];
            }
        }
    }
}

- (void) showActionSheet:(id)sender
{
    _menu = [[UIActionSheet alloc] initWithTitle:@"Options Menu" delegate:self cancelButtonTitle:@"Resume" destructiveButtonTitle:nil otherButtonTitles:
             @"Quit Game",
             @"How to play",
             @"Reset Board",
             @"Settings", nil];
    _menu.tag = 1;
    [_menu showInView:self.view];
}

- (void)buttonWasTapped:(id)sender
{
    UIButton *curButton = (UIButton *) sender;
    int selectedNumber = [_numPadView getSelectedNumber];
    int row = (int) (curButton.tag / 10) -1;
    int col = (int) (curButton.tag % 10) -1;
    if ([_gridModel canChangeAtRow:row andCol:col]
        && ([_gridModel value:selectedNumber allowedAtRow:row andCol:col]
            || [[NSUserDefaults standardUserDefaults] boolForKey:@"_allowInvalidMove"])) {
        [_gridView setValue:selectedNumber AtRow:row andCol:col andIsInitial:NO];
        [_gridModel setValue:selectedNumber atRow:row andCol:col];
    } else if (![_gridModel canChangeAtRow:row andCol:col]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You can't put that there!"
                                                        message:@"You can't replace initial values!"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You can't put that there!"
                                                        message:@"That number is already in this row, column, or block."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    if ([_gridModel isFull] && ![[NSUserDefaults standardUserDefaults] boolForKey:@"_doNotCheckValidIfFull"]) {
        if ([_gridModel checkGrid]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You've won!"
                                                            message:@"You are a winner."
                                                           delegate:self
                                                  cancelButtonTitle:@"Yay for me!"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
    
    NSLog(@"You touched the button with row %ld and column %ld", (curButton.tag / 10), (curButton.tag % 10));
}

- (void)numberSelected:(UIButton*)sender
{
    UIButton *curButton = sender;
    NSLog(@"You touched the button in position %ld", curButton.tag);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)actionSheet:(UIActionSheet*) actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self returnToMenu];
            break;
        case 1:
            [self showHowToPlay];
            break;
        case 2:
            [self resetGrid];
            break;
        case 3:
            [self settings];
            break;
        default:
            break;
    }
}

- (void) returnToMenu
{
    // This is to fix an issue with iOS, help from
    // http://stackoverflow.com/questions/24854802/presenting-a-view-controller-modally-from-an-action-sheets-delegate-in-ios8
    dispatch_async(dispatch_get_main_queue(), ^ {
        [_gridModel saveGrid];
        [self performSegueWithIdentifier:@"returnToMenu" sender:self];
    });
}

- (void) showHowToPlay
{
    // This is to fix an issue with iOS, help from
    // http://stackoverflow.com/questions/24854802/presenting-a-view-controller-modally-from-an-action-sheets-delegate-in-ios8
    dispatch_async(dispatch_get_main_queue(), ^ {
        [self performSegueWithIdentifier:@"showHowToPlay" sender:self];
    });
}

- (void) resetGrid
{
    for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
            if ([_gridModel canChangeAtRow:i andCol:j]) {
                [_gridModel setValue:0 atRow:i andCol:j];
                [_gridView setValue:0 AtRow:i andCol:j andIsInitial:NO];
            }
        }
    }
}

- (void) settings
{
    // This is to fix an issue with iOS, help from
    // http://stackoverflow.com/questions/24854802/presenting-a-view-controller-modally-from-an-action-sheets-delegate-in-ios8
    dispatch_async(dispatch_get_main_queue(), ^ {
        [self performSegueWithIdentifier:@"gridToSettings" sender:self];
    });
}

- (IBAction) exitFromSettings:(UIStoryboardSegue *) segue
{
    // Do nothing
}


@end
