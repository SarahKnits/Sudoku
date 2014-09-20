//
//  BG.m
//  Sudoku
//
//  Created by Sarah Gilkinson on 9/20/14.
//  Copyright (c) 2014 Blauzvern Gilkinson. All rights reserved.
//

#import "BGNumPadView.h"
#import "UIImage+ImageWithColor.h"

@interface BGNumPadView() {
    NSMutableArray* _buttonArray;
}
@end

@implementation BGNumPadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Separation between cells in different blocks
        CGFloat size = frame.size.width;
        const CGFloat separation = 0.01*size;
        self.backgroundColor = [UIColor blackColor];
        
        // Leaving 0.01 each for four lines separating blocks
        CGFloat buttonSize = (size-4*separation)/9.0;
        
        // Array to hold 9 buttons
        _buttonArray = [[NSMutableArray alloc] init];
        
        // create button
        for (int i = 0; i < 9; i++) {
            //Create the button
            // Offset of 0.01*size for each major line.
            // First is at begining, additional after each 3 (1+j/3)
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i*buttonSize + 2*separation,separation, buttonSize, buttonSize)];
            
            button.backgroundColor = [UIColor whiteColor];
            [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [button setTitle:[NSString stringWithFormat:@"%i",i+1] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
            
            // Tag of 21 represents second row, first column
            [button setTag:i+1];
            [button addTarget:self action:@selector(buttonPressed:)forControlEvents:UIControlEventTouchUpInside];
            
            // From stack overflow
            [button setBackgroundImage:[UIImage imageWithColor:[UIColor yellowColor]] forState:UIControlStateSelected];
            [button.layer setBorderWidth:2.0f];
            
            //Store the button in our array
            [_buttonArray addObject:button];
            [self addSubview:button];
            
        }

    }
    return self;
}

- (IBAction)buttonPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(buttonWasTapped:)]) {
        [self.delegate buttonWasTapped:sender];
    }
}


@end
