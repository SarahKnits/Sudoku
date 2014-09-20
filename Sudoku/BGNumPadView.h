//
//  BG.h
//  Sudoku
//
//  Created by Sarah Gilkinson on 9/20/14.
//  Copyright (c) 2014 Blauzvern Gilkinson. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BGNumPadViewDelegate <NSObject>
@required
- (void)buttonWasTapped:(id)sender;
@end

@interface BGNumPadView : UIView

@property (weak, nonatomic) id <BGNumPadViewDelegate> delegate;

@end
