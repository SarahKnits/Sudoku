//
//  BGViewController.h
//  Sudoku
//
//  Created by Sarah Gilkinson on 9/11/14.
//  Copyright (c) 2014 Blauzvern Gilkinson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BGViewController : UIViewController <UIActionSheetDelegate>

- (void)actionSheet:(UIActionSheet*) actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

- (IBAction) exitFromSettings:(UIStoryboardSegue *) segue;

@end
