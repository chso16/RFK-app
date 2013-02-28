//
//  settings.m
//  RFK
//
//  Created by Christian Sørensen on 26/02/13.
//  Copyright (c) 2013 Christian Sørensen. All rights reserved.
//

#import "settings.h"

@interface settings ()

@end

@implementation settings
@synthesize state;
@synthesize statetest;
@synthesize State1;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    if(state.on)
    {
        [defaults setBool:YES forKey:@"sky"];
    }
    else
    {
        [defaults setBool:NO forKey:@"sky"];
    }
    
    NSUserDefaults* defaultsa = [NSUserDefaults standardUserDefaults];
    if(state.on)
    {
        [defaultsa setBool:YES forKey:@"sky2"];
    }
    else
    {
        [defaultsa setBool:NO forKey:@"sky2"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)imageswitch:(id)sender
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    if(state.on)
    {
        [defaults setBool:YES forKey:@"sky"];
    }
    else
    {
        [defaults setBool:NO forKey:@"sky"];
    }
}

- (IBAction)ImgSwitch1:(id)sender
{
    NSUserDefaults* defaultsa = [NSUserDefaults standardUserDefaults];
    
    if(State1.on)
    {
        [defaultsa setBool:YES forKey:@"sky2"];
    }
    else 
    {
        [defaultsa setBool:NO forKey:@"sky2"];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

@end
