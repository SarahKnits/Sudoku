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
    int _numberSelected;
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
        self.backgroundColor = [UIColor clearColor];
        
        // Leaving 0.01 each for four lines separating blocks
        CGFloat buttonSize = (size - 4*separation)/10.0;
        
        // Array to hold 9 buttons
        _buttonArray = [[NSMutableArray alloc] init];
        
        // create button
        for (int i = 0; i < 10; i++) {
            // Create the button
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i*buttonSize + 2*separation,separation, buttonSize, buttonSize)];
            
            button.backgroundColor = [UIColor whiteColor];
            [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            if (i == 0) {
                [button setTitle:@"" forState:UIControlStateNormal];
            } else {
                [button setTitle:[NSString stringWithFormat:@"%i",i] forState:UIControlStateNormal];
            }
            button.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
            
            // Tag of 21 represents second row, first column
            [button setTag:i];
            [button addTarget:self action:@selector(buttonPressed:)forControlEvents:UIControlEventTouchUpInside];
            
            [button.layer setBorderWidth:2.0f];
            
            //Store the button in our array
            [_buttonArray addObject:button];
            [self addSubview:button];
        }
        _numberSelected = 2;
        [self setSelectedNumber:1];
    }
    return self;
}

- (IBAction)buttonPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(numberSelected:)]) {
        [self.delegate numberSelected:sender];
    }
    [self setSelectedNumber:(int) ((UIButton*) sender).tag];
}

- (void)setSelectedNumber:(int)selection
{
    UIButton *oldSelection = (UIButton *) _buttonArray[_numberSelected];
    UIButton *newSelection = (UIButton *) _buttonArray[selection];
    oldSelection.backgroundColor = [UIColor whiteColor];
    newSelection.backgroundColor = [UIColor yellowColor];
    _numberSelected = selection;
}

- (int)getSelectedNumber
{
    return _numberSelected;
}


@end
