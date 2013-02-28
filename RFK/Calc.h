//
//  Calc.h
//  RFK
//
//  Created by Christian Sørensen on 27/02/13.
//  Copyright (c) 2013 Christian Sørensen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Calc : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *HeightLabel;
@property (weak, nonatomic) IBOutlet UITextField *IASLabel;
@property (weak, nonatomic) IBOutlet UITextField *WinddirectionLabel;
@property (weak, nonatomic) IBOutlet UITextField *WindSpeedLabel;
@property (weak, nonatomic) IBOutlet UITextField *TrackLabel;
@property (weak, nonatomic) IBOutlet UILabel *TASlabel;
@property (weak, nonatomic) IBOutlet UILabel *MACHlabel;
@property (weak, nonatomic) IBOutlet UILabel *Groundslabel;
@property (weak, nonatomic) IBOutlet UIImageView *ImgView;
- (IBAction)Calc:(id)sender;
- (IBAction)Clear:(id)sender;

@end
