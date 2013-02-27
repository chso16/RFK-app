//
//  FirstViewController.h
//  RFK
//
//  Created by Christian Sørensen on 19/02/13.
//  Copyright (c) 2013 Christian Sørensen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController
{
    IBOutlet UILabel *countdownLabel;
    NSTimer *countdownTimer;
    int secondsCount;
}
@property (weak, nonatomic) IBOutlet UILabel *labelwindspeed;
@property (weak, nonatomic) IBOutlet UILabel *labelWindDirection;
@property (weak, nonatomic) IBOutlet UILabel *labelTeampature;
@property (weak, nonatomic) IBOutlet UILabel *labeHPA;
@property (weak, nonatomic) IBOutlet UIImageView *img;


- (IBAction)imageChange:(id)sender;


    

@end
