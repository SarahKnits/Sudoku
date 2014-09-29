//
//  BGGridModel.h
//  Sudoku
//
//  Created by Sarah Gilkinson on 9/19/14.
//  Copyright (c) 2014 Blauzvern Gilkinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BGGridModel : NSObject

- (int) getValueAtRow:(int)row andCol:(int)col;
- (void) setValue:(int)value atRow:(int)row andCol:(int)col;
- (BOOL) canChangeAtRow:(int)row andCol:(int)col;
- (BOOL) isFull;
- (BOOL) checkGrid;
- (BOOL) value:(int)value allowedAtRow:(int)row andCol:(int)col;
- (id) initWithGrid:(NSArray *) initialGrid;
- (void) saveGrid;
- (instancetype) restoreGrid;

@end
