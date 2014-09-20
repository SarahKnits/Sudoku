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
}

@end

@implementation BGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _gridModel = [[BGGridModel alloc] init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Create grid frame
    CGRect frame = self.view.frame;
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
    for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
            [_gridView setValue:[_gridModel getValueAtRow:i andCol:j] AtRow:i andCol:j andIsInitial:YES];
        }
    }
    [self.view addSubview:_gridView];
    
    CGRect numPadFrame = CGRectMake(x, 2*y + size, size, ((size*.96)/ 9) + 0.02*size); // Adjust as we figure this out
    
    // Create num Pad view
    _numPadView = [[BGNumPadView alloc] initWithFrame:numPadFrame];
    // Assign numPadView's delegate to be the controller
    _numPadView.delegate = self;
    
    [self.view addSubview:_numPadView];
    
}

- (void)buttonWasTapped:(id)sender
{
    UIButton *curButton = (UIButton *) sender;
    int selectedNumber = [_numPadView getSelectedNumber];
    int row = (curButton.tag / 10) -1;
    int col = (curButton.tag % 10) -1;
    if ([_gridModel canChangeAtRow:row andCol:col]) {
        [_gridView setValue:selectedNumber AtRow:row andCol:col andIsInitial:NO];
        [_gridModel setValue:selectedNumber atRow:row andCol:col];
    }
    
    NSLog(@"You touched the button with row %i and column %i", (curButton.tag / 10), (curButton.tag % 10));
}

- (void)numberSelected:(UIButton*)sender
{
    UIButton *curButton = sender;
    NSLog(@"You touched the button in position %i", curButton.tag);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
