//
//  BGGridModel.m
//  Sudoku
//
//  Created by Sarah Gilkinson on 9/19/14.
//  Copyright (c) 2014 Gilkinson Valentine. All rights reserved.
//

#import "BGGridModel.h"

@interface BGGridModel() <NSObject> {
    int _grid[9][9];
    BOOL _canChange[9][9];
}
@end

@implementation BGGridModel

- (id) init {
    self = [super init];
    if (self) {
        int initialGrid[9][9] = {
            {7,0,0,4,2,0,0,0,9},
            {0,0,9,5,0,0,0,0,4},
            {0,2,0,6,9,0,5,0,0},
            {6,5,0,0,0,0,4,3,0},
            {0,8,0,0,0,6,0,0,7},
            {0,1,0,0,4,5,6,0,0},
            {0,0,0,8,6,0,0,0,2},
            {3,4,0,9,0,0,1,0,0},
            {8,0,0,3,0,2,7,4,0}};
        for(int i = 0; i < 9; i++) {
            for (int j = 0; j < 9; j++) {
                _grid[i][j] = initialGrid[i][j];
                _canChange[i][j] = (_grid[i][j] == 0) ? YES : NO;
            }
        }
    }
    return self;
}

- (id) initForTests:(int[9][9]) initialGrid {
    self = [super init];
    if (self) {
        for(int i = 0; i < 9; i++) {
            for (int j = 0; j < 9; j++) {
                _grid[i][j] = initialGrid[i][j];
                _canChange[i][j] = (_grid[i][j] == 0) ? YES : NO;
            }
        }
    }
    return self;
}

- (int) getValueAtRow:(int)row andCol:(int)col {
    return _grid[row][col];
}

- (void) setValue:(int)value atRow:(int)row andCol:(int)col {
    _grid[row][col] = value;
}

- (BOOL) canChangeAtRow:(int)row andCol:(int)col {
    return _canChange[row][col];
}

- (BOOL) value:(int)value allowedAtRow:(int)row andCol:(int)col {
    // Check row and column
    for (int i=0; i<9; i++) {
        if (i != row && _grid[i][col] == value) {
            return NO;
        }
        if (i != col && _grid[row][i] == value) {
            return NO;
        }
    }

    // Check block
    int blockRow = 3*(row/3), blockCol = 3*(col/3);
    for (int i = blockRow; i < blockRow+3; i++) {
        for (int j = blockCol; j < blockCol+3; j++) {
            if ( !(i==row && j==col) && _grid[i][j] == value) {
                return NO;
            }
        }
    }
    
    return YES;
}

- (BOOL) checkGrid {
    if (! [self isFull]) {
        return NO;
    }
    for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
            if (![self value:_grid[i][j] allowedAtRow:i andCol:j]) {
                return NO;
            }
        }
    }
    return YES;
}

- (BOOL) isFull {
    for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
            if (_grid[i][j] == 0) {
                return NO;
            }
        }
    }
    return YES;
}

@end
