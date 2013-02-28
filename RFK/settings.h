//
//  settings.h
//  RFK
//
//  Created by Christian Sørensen on 26/02/13.
//  Copyright (c) 2013 Christian Sørensen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface settings : UIViewController
@property (weak, nonatomic) IBOutlet UISwitch *state;
@property (weak, nonatomic) IBOutlet UILabel *statetest;
@property (weak, nonatomic) IBOutlet UISwitch *State1;
- (IBAction)imageswitch:(id)sender;
- (IBAction)ImgSwitch1:(id)sender;

@end
