//
//  BGGridView.h
//  Sudoku
//
//  Created by Sarah Gilkinson on 9/11/14.
//  Copyright (c) 2014 Blauzvern Gilkinson. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BGGridViewDelegate <NSObject>
@required
- (void)buttonWasTapped:(id)sender;
@end

@interface BGGridView : UIView

- (void)makeNewGridViewOfSize:(CGFloat)size;

- (void)setValue:(int)value AtRow:(int)row andCol:(int)col;

@property (weak, nonatomic) id <BGGridViewDelegate> delegate;

@end
