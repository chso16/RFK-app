//
//  Calc.m
//  RFK
//
//  Created by Christian Sørensen on 27/02/13.
//  Copyright (c) 2013 Christian Sørensen. All rights reserved.
//

#import "Calc.h"

@interface Calc ()

@end

@implementation Calc
@synthesize HeightLabel;
@synthesize IASLabel;
@synthesize WinddirectionLabel;
@synthesize WindSpeedLabel;
@synthesize TrackLabel;
@synthesize TASlabel;
@synthesize MACHlabel;
@synthesize Groundslabel;
@synthesize ImgView;

float height, speed, IAS, windDir, windSpeed, trk, TAS, MACH, GS;
float PI, g, R, lambda, T0, TropT, ftm, P0, TropP;
float pres, temp, pow1, pow2, relDen, MACH1, windAng, windComp, drift, heading, rad, deg;
int trkInt, driftInt, headingInt;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    PI = 3.14159265;
    g = 9.81;
    R = 287;
    lambda = 0.00198;
    T0 = 288;
    TropT = 216.5;
    ftm = 3.28126;
    P0 = 1013.25;
    TropP = 226;
    
    pres = 0.0;
    temp = 0.0;
    relDen = 0.0;
    MACH1 = 0.0;
    windAng = 0.0;
    windComp = 0.0;
    drift = 0.0;
    heading = 0.0;
    rad = 0.0;
    deg = 0.0;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidAppear:(BOOL)animated
{
    
}

-(void)calculate
{    
    height = [HeightLabel.text floatValue];
    IAS = [IASLabel.text floatValue];
    windDir = [WindSpeedLabel.text floatValue];
    windSpeed = [WindSpeedLabel.text floatValue];
    trk = [TrackLabel.text floatValue];
    TAS = 0.0;
    MACH = 0.0;
    GS = 0.0;
    
    //Pressure
    
    if (height < 36090)
    {
        pow1 = (1 - (lambda * height / T0));
        pow2 = (g / (R * lambda * ftm));
        pres = powf(pow1, pow2);
        pres = P0 * pres;
    }
    
    else
    {
        pres = TropP * exp(-g * ((height-36090) / ftm) / (R * TropT));
    }
    
    //Temperature
    
    if (height < 36090)
    {
        temp = 288 - ((height / 1000) * 1.98);
    }
    
    else
    {
        temp = 216.5;
    }
    
    //RelDensity
    
    relDen = (3.51823 / (pres / temp));

    //Heading
    rad = PI / 180;
    deg = 180 / PI;
    windAng = rad * (trk - windDir);
    windComp = sinf(windAng) * windSpeed / TAS;
    drift = deg * (asinf(windComp));
    trkInt = round(trk);
    driftInt = round(drift);
    headingInt = (360 + trkInt - driftInt) %360;
    heading = (float) headingInt;
    
    //TAS
    
    TAS = sqrtf(relDen) * IAS;
    
    //MACH
    
    MACH1 = 38.9 * sqrtf(temp);
    MACH = TAS / MACH1;
    
    //Ground Speed
    windAng = rad * (heading - windDir);
    GS = TAS - windSpeed * cosf(windAng);

    //Result
    TASlabel.text = [NSString stringWithFormat:@"%.2f", TAS];
    MACHlabel.text = [NSString stringWithFormat:@"%.2f", MACH];
    Groundslabel.text = [NSString stringWithFormat:@"%.2f", GS];

    

}

- (void)viewDidUnload

{
    
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    
    // e.g. self.myOutlet = nil;
    
}

- (IBAction)Calc:(id)sender
{
    [self calculate];
    [[self view] endEditing:NO];
}

- (IBAction)Clear:(id)sender
{
    HeightLabel.text = @"0";
        
    IASLabel.text = @"0";
        
    WinddirectionLabel.text = @"0";
        
    WindSpeedLabel.text = @"0";
        
    TrackLabel.text = @"0";
        
    TASlabel.text = @"0";
        
    MACHlabel.text = @"0";
        
    Groundslabel.text = @"0";
    [[self view] endEditing:NO];
}

-(void) viewWillAppear:(BOOL)animated
{
    NSUserDefaults* defaultsa = [NSUserDefaults standardUserDefaults];
    if([defaultsa boolForKey:@"sky2"])
    {
        [ImgView setImage:[UIImage imageNamed:@"sky.jpg"]];
    }
    else
    {
        [ImgView setImage:[UIImage imageNamed:@""]];
    }
}

@end
