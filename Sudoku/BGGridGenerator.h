//
//  BGGridGenerator.h
//  Sudoku
//
//  Created by Sarah Gilkinson on 9/28/14.
//  Copyright (c) 2014 Blauzvern Gilkinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BGGridGenerator : NSObject

+ (NSMutableArray *) generateRandomFromFile:(NSString*) fileName;

@end
