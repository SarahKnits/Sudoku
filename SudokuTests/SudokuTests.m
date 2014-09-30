//
//  SudokuTests.m
//  SudokuTests
//
//  Created by Sarah Gilkinson on 9/11/14.
//  Copyright (c) 2014 Blauzvern Gilkinson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BGGridModel.h"
#import "BGGridGenerator.h"

@interface SudokuTests : XCTestCase

@end

@implementation SudokuTests

- (void)setUp
{
    [super setUp];
    
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testGridModelInitialization {
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
    BGGridModel *gridModel = [[BGGridModel alloc] initWithIntGrid:initialGrid];
    for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
            XCTAssertTrue([gridModel getValueAtRow:i andCol:j] == initialGrid[i][j], @"Didn't set values correctly");
            if (initialGrid[i][j] == 0) {
                XCTAssertTrue([gridModel canChangeAtRow:i andCol:j], @"Row %i col %i (value %i) should be changeable", i, j, initialGrid[i][j]);
            } else {
                XCTAssertFalse([gridModel canChangeAtRow:i andCol:j], @"Row %i col %i (value %i) should not be changeable", i, j, initialGrid[i][j]);
            }
        }
    }
}

- (void)testNotAllowedForOneReason {
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
    BGGridModel *gridModel = [[BGGridModel alloc] initWithIntGrid:initialGrid];
    // Tests for failing columns
    XCTAssertFalse([gridModel value:2 allowedAtRow:1 andCol: 1]); // column test, middle should fail
    XCTAssertFalse([gridModel value:3 allowedAtRow:0 andCol: 7]); // column test, top should fail
    XCTAssertFalse([gridModel value:9 allowedAtRow:8 andCol: 8]); // column test, bottom should fail
    // Tests for failing rows
    XCTAssertFalse([gridModel value:5 allowedAtRow:1 andCol: 5]); // row test, middle should fail
    XCTAssertFalse([gridModel value:5 allowedAtRow:2 andCol: 0]); // row test, left should fail
    XCTAssertFalse([gridModel value:3 allowedAtRow:7 andCol: 8]); // row test, right should fail
    // Tests for failing blocks
    XCTAssertFalse([gridModel value:7 allowedAtRow:1 andCol: 1]); // block test, middle should fail
    XCTAssertFalse([gridModel value:1 allowedAtRow:8 andCol: 8]); // block test, bottom right should fail
    XCTAssertFalse([gridModel value:4 allowedAtRow:6 andCol: 0]); // block test, upper left should fail
}

- (void)testNotAllowedForMultipleReasons {
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
    BGGridModel *gridModel = [[BGGridModel alloc] initWithIntGrid:initialGrid];
    // Tests for failing columns
    XCTAssertFalse([gridModel value:6 allowedAtRow:4 andCol: 4]);
    XCTAssertFalse([gridModel value:2 allowedAtRow:8 andCol: 8]);
    XCTAssertFalse([gridModel value:2 allowedAtRow:0 andCol: 1]);
}

- (void) testAllowedMove {
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
    BGGridModel *gridModel = [[BGGridModel alloc] initWithIntGrid:initialGrid];
    XCTAssertTrue([gridModel value:5 allowedAtRow:8 andCol: 8]);
    XCTAssertTrue([gridModel value:1 allowedAtRow:1 andCol: 0]);
    XCTAssertTrue([gridModel value:1 allowedAtRow:4 andCol: 7]);
    
}

- (void) testSetNonInitialValue {
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
    BGGridModel *gridModel = [[BGGridModel alloc] initWithIntGrid:initialGrid];
    
    const int numChanges = 10;
    int changes[numChanges][3] = {
        // row, col, value
        {1, 0, 1},
        {8, 8, 4},
        {7, 5, 3},
        {2, 2, 6},
        {4, 8, 7},
        {6, 2, 6},
        
        {1, 0, 1},
        {1, 0, 4},
        {1, 0, 9},
        {4, 8, 2}
    };
    
    for (int i=0; i<numChanges; i++) {
        [gridModel setValue:changes[i][2] atRow:changes[i][0] andCol:changes[i][1]];
        initialGrid[changes[i][0]][changes[i][1]] = changes[i][2];
        [self checkModel:gridModel againstArray:initialGrid];
    }
    
}

- (void) testCorrectGridValidationWhenValid {
    int initialGrid[9][9] = {
        {1,2,3,4,5,6,7,8,9},
        {4,5,6,7,8,9,1,2,3},
        {7,8,9,1,2,3,4,5,6},
        {2,3,4,5,6,7,8,9,1},
        {5,6,7,8,9,1,2,3,4},
        {8,9,1,2,3,4,5,6,7},
        {3,4,5,6,7,8,9,1,2},
        {6,7,8,9,1,2,3,4,5},
        {9,1,2,3,4,5,6,7,8}};
    BGGridModel *gridModel = [[BGGridModel alloc] initWithIntGrid:initialGrid];
    XCTAssertTrue([gridModel isFull], @"The grid should be full");
    XCTAssertTrue([gridModel checkGrid], @"The grid should be correct");
}

- (void) testCorrectGridValidationWhenInvalid {
    int initialGrid[9][9] = {
        {1,2,3,4,5,6,7,8,8},
        {4,5,6,7,8,9,1,2,3},
        {7,8,9,1,2,3,4,5,6},
        {2,3,4,5,6,7,8,9,1},
        {5,6,7,8,9,1,2,3,4},
        {8,9,1,2,3,4,5,6,7},
        {3,4,5,6,7,8,9,1,2},
        {6,7,8,9,1,2,3,4,5},
        {9,1,2,3,4,5,6,7,8}};
    BGGridModel *gridModel = [[BGGridModel alloc] initWithIntGrid:initialGrid];
    XCTAssertFalse([gridModel checkGrid], @"The grid should be correct");
}

- (void) testCorrectGridValidationWhenNotFull {
    int initialGrid[9][9] = {
        {1,2,3,4,5,6,7,8,0},
        {4,5,6,7,8,9,1,2,3},
        {7,8,9,1,2,3,4,0,6},
        {2,3,4,5,6,7,8,9,1},
        {5,6,7,8,9,1,2,3,4},
        {8,9,1,2,3,4,5,6,7},
        {3,4,5,6,7,8,9,1,2},
        {6,7,8,9,1,2,3,4,5},
        {9,1,2,3,4,5,6,7,8}};
    BGGridModel *gridModel = [[BGGridModel alloc] initWithIntGrid:initialGrid];
    XCTAssertFalse([gridModel checkGrid], @"The un-full grid should not be correct");
}

- (void) testGridFullWhenNotFull {
    int initialGrid[9][9] = {
        {1,2,3,4,5,6,7,8,0},
        {4,5,6,7,8,9,1,2,3},
        {7,8,9,1,2,3,4,5,6},
        {2,3,4,5,6,7,8,9,1},
        {5,6,7,8,9,1,2,3,4},
        {8,9,1,2,3,4,5,6,7},
        {3,4,5,6,7,8,9,1,2},
        {6,7,8,9,1,2,3,4,5},
        {9,1,2,3,4,5,6,7,8}};
    BGGridModel *gridModel = [[BGGridModel alloc] initWithIntGrid:initialGrid];
    XCTAssertFalse([gridModel isFull], @"The grid should not be full");
}

- (void) testGenerateRandomFromFile {
    int initialGrid[9][9] = {
        {0,6,4,0,8,0,0,0,0},
        {7,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,4,0,0,0},
        {0,0,5,0,0,1,8,0,0},
        {9,2,0,4,0,0,3,0,0},
        {0,0,1,0,0,0,0,5,0},
        {0,0,0,8,0,0,0,4,6},
        {0,0,0,0,3,2,0,1,0},
        {0,0,0,6,4,5,7,0,0}};
    BGGridModel *gridModel = [[BGGridModel alloc] initWithGrid:[BGGridGenerator generateRandomFromFile:@"testGridFile"]];
    [self checkModel:gridModel againstArray:initialGrid];
}

- (void)testGridSaveAndRestore {
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
    BGGridModel *gridModel = [[BGGridModel alloc] initWithIntGrid:initialGrid];
    [gridModel saveGrid];
    [gridModel setValue:3 atRow:0 andCol:1];
    [gridModel restoreGrid];
    [self checkModel:gridModel againstArray:initialGrid];
}



- (void) checkModel:(BGGridModel*)model againstArray: (int[9][9]) array {
    for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
            XCTAssertTrue([model getValueAtRow:i andCol:j] == array[i][j], @"Value at row %i and col %i is %i but should be %i", i,j,[model getValueAtRow:i andCol: j], array[i][j]);
        }
    }
}



@end
