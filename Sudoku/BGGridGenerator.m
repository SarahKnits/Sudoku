//
//  BGGridGenerator.m
//  Sudoku
//
//  Created by Sarah Gilkinson on 9/28/14.
//  Copyright (c) 2014 Blauzvern Gilkinson. All rights reserved.
//

#import "BGGridGenerator.h"

@implementation BGGridGenerator

+ (NSMutableArray *) generateRandomFromFile:(NSString*) fileName
{
    NSLog(@"I'm here!");
    // Gets path for grid generation
    NSString* path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"txt"];
    
    NSLog(@"Path: ");
    NSLog(path);
    
    NSError* error;
    NSString* readString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    
    NSMutableArray* array = (NSMutableArray *)[readString componentsSeparatedByCharactersInSet:
                                               [NSCharacterSet characterSetWithCharactersInString:@" \n"]];
    
    NSUInteger r = arc4random_uniform((unsigned int)[array count]);
    
    NSString* gridString = [array objectAtIndex:r];
    
    NSMutableArray *grid = [@[] mutableCopy];
    
    for(int i = 0; i < 9; i++) {
        [grid addObject:[@[] mutableCopy]];
        for (int j = 0; j < 9; j++) {
            NSString* curChar = [gridString substringWithRange:NSMakeRange(i*9+j,1)];
            if ([curChar isEqual:@"."]) {
                [(NSMutableArray *)grid[i] addObject:[NSNumber numberWithInteger:0]];
            } else {
                [(NSMutableArray *)grid[i] addObject:[NSNumber numberWithInteger:[curChar intValue]]];
            }
        }
    }
    return grid;
}

@end
