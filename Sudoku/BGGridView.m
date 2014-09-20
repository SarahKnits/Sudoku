//
//  BGGridView.m
//  Sudoku
//
//  Created by Sarah Gilkinson on 9/11/14.
//  Copyright (c) 2014 Blauzvern Gilkinson. All rights reserved.
//

#import "BGGridView.h"
#import "UIImage+ImageWithColor.h"

@interface BGGridView () {
    NSMutableArray* _buttonArray;
}

@end

@implementation BGGridView // Can this just be an implementation or does it need to be both?

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)makeNewGridViewOfSize:(CGFloat)size
{
    // Separation between cells in different blocks
    const CGFloat separation = 0.01*size;
    self.backgroundColor = [UIColor blackColor];
    
    // Leaving 0.01 each for four lines separating blocks
    CGFloat buttonSize = (size-4*separation)/9.0;
    
    // Array to hold 81 buttons
    _buttonArray = [[NSMutableArray alloc] init];
    
    // create button
    for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
            //Create the button
            // Offset of 0.01*size for each major line.
            // First is at begining, additional after each 3 (1+j/3)
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((j*buttonSize+(1+j/3)*separation),i*buttonSize + (1+i/3)*separation, buttonSize, buttonSize)];
            
            button.backgroundColor = [UIColor whiteColor];
            [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
            
            // Tag of 21 represents second row, first column
            [button setTag:((i+1)*10+(j+1))];
            [button addTarget:self action:@selector(buttonPressed:)forControlEvents:UIControlEventTouchUpInside];
            
            // From stack overflow
            [button setBackgroundImage:[UIImage imageWithColor:[UIColor yellowColor]] forState:UIControlStateHighlighted];
            [button.layer setBorderWidth:2.0f];
            
            //Store the button in our array
            [_buttonArray addObject:button];
            [self addSubview:button];
            
        }
    }
}

- (IBAction)buttonPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(buttonWasTapped:)]) {
        [self.delegate buttonWasTapped:sender];
    }
}

- (void)setValue:(int)value AtRow:(int)row andCol:(int)col {
    if (value != 0) {
        [_buttonArray[row*9+col] setTitle:[NSString stringWithFormat:@"%i",value] forState:UIControlStateNormal];
    } else {
        [_buttonArray[row*9+col] setTitle:@"" forState:UIControlStateNormal];
    }
}

@end
