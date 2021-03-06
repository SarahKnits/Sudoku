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

- (id) initWithGrid:(NSArray *) initialGrid {
    self = [super init];
    if (self) {
        for(int i = 0; i < 9; i++) {
            for (int j = 0; j < 9; j++) {
                _grid[i][j] = [initialGrid[i][j] intValue];
                _canChange[i][j] = (_grid[i][j] == 0) ? YES : NO;
            }
        }
    }
    return self;
}

- (id) initWithIntGrid:(int[9][9]) initialGrid {
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
    if (value == 0) {
        return YES;
    }
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

- (void) saveGrid {
    [[NSFileManager defaultManager] createFileAtPath:@"savedGrid.txt" contents:nil attributes:nil];
    NSString *gridState = @"";
    NSString *canChange = @"";
    if (self) {
        for(int i = 0; i < 9; i++) {
            for (int j = 0; j < 9; j++) {
                if (_grid[i][j] != 0) {
                    gridState = [gridState stringByAppendingString:[NSString stringWithFormat:@"%i",_grid[i][j]]];
                } else {
                   gridState = [gridState stringByAppendingString:@"."];
                }
                canChange = [canChange stringByAppendingString:_canChange[i][j] ? @"1" : @"0"];
            }
        }
    }
    
    gridState = [gridState stringByAppendingString:canChange];
    
    [[NSUserDefaults standardUserDefaults] setObject:gridState forKey:@"_savedGrid"];
    
}

- (instancetype) restoreGrid {
    NSString* gridString = [[NSUserDefaults standardUserDefaults] objectForKey:@"_savedGrid"];
    int currentCharacterIndex = 0;
    for(int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
            NSString* curChar = [gridString substringWithRange:NSMakeRange(currentCharacterIndex,1)];
            currentCharacterIndex++;
            if ([curChar isEqual:@"."]) {
                _grid[i][j] = 0;
            } else {
                _grid[i][j] = [curChar intValue];
            }
            _canChange[i][j] = (_grid[i][j] == 0) ? YES : NO;
        }
    }
    for(int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
            NSString* curChar = [gridString substringWithRange:NSMakeRange(currentCharacterIndex,1)];
            currentCharacterIndex++;
            _canChange[i][j] = ([curChar isEqual:@"1"]) ? YES : NO;
        }
    }
    return self;
}

@end
