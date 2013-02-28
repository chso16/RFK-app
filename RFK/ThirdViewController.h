//
//  ThirdViewController.h
//  RFK
//
//  Created by Christian Sørensen on 19/02/13.
//  Copyright (c) 2013 Christian Sørensen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segcontrol;
- (IBAction)Segcontrol:(id)sender;

@end