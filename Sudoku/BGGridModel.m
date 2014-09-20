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

- (int) getValueAtRow:(int)row andCol:(int)col {
    return _grid[row][col];
}

- (void) setValue:(int)value atRow:(int)row andCol:(int)col {
    _grid[row][col] = value;
}

- (BOOL) canChangeAtRow:(int)row andCol:(int)col {
    return _canChange[row][col];
}

@end
