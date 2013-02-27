//
//  FirstViewController.m
//  RFK
//
//  Created by Christian Sørensen on 19/02/13.
//  Copyright (c) 2013 Christian Sørensen. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
@end

@implementation FirstViewController
@synthesize labelwindspeed;
@synthesize labelWindDirection;
@synthesize labelTeampature;
@synthesize labeHPA;
@synthesize img;


bool colorimage = YES;

NSURLConnection *theConnection;
NSMutableData *receivedData;
NSString *rawData;
NSTimer *autoTimer;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getWeather];
    [self setTimer];
    [img setImage:[UIImage imageNamed:@"sky.jpg"]];
}

-(void) timerRun
{
    secondsCount = secondsCount - 1;
    int minuts = secondsCount / 60;
    int seconds = secondsCount - (minuts * 60);
    NSString *timerOutput = [NSString stringWithFormat:@"%2d", seconds];
    countdownLabel.text = timerOutput;
    if (secondsCount == 1) {
        secondsCount = 11;
    }
}
-(void) setTimer  {
    secondsCount = 11;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) getWeather
{
    receivedData = [[NSMutableData alloc] init];
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.randersflyveklub.dk/vejr/clientraw.txt"] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5.0];
    
    theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [receivedData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //myTextField.textColor = [UIColor redColor];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (theConnection == nil)
    {
    }
    else
    {
        rawData = [[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding];
        
        //NSLog(@" here is the data: %@", rawData);
        NSArray *arrayData = [rawData componentsSeparatedByString:@" "];
        NSLog(@" here is the data: %@", arrayData);
        
        // Wind speed
        labelwindspeed.text = [arrayData objectAtIndex:1];
        NSLog(@"%@", [arrayData objectAtIndex:1]);
        
        // Wind direction
        labelWindDirection.text = [arrayData objectAtIndex:3];
        NSLog(@"%@", [arrayData objectAtIndex:3]);
        
        // Temperature
        labelTeampature.text = [arrayData objectAtIndex:4];
        NSLog(@"%@", [arrayData objectAtIndex:4]);
        
        // hPa
        labeHPA.text = [arrayData objectAtIndex:6];
        NSLog(@"%@", [arrayData objectAtIndex:6]);
        
        theConnection = nil;
    }
}



- (void)viewDidUnload
{
    [self setLabelwindspeed:nil];
    [self setLabelWindDirection:nil];
    [self setLabelTeampature:nil];
    [self setLabeHPA:nil];
    [super viewDidUnload];
    [autoTimer invalidate];
    autoTimer = nil;
    
    [countdownTimer invalidate];
    countdownTimer = nil;

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    autoTimer = [NSTimer scheduledTimerWithTimeInterval:(10.0)
                                                 target:self
                                               selector:@selector(getWeather)
                                               userInfo:nil
                                                repeats:YES];
    
    
    countdownTimer = [NSTimer scheduledTimerWithTimeInterval:(1) target:(self) selector:@selector(timerRun) userInfo:(Nil) repeats:(YES)];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
  
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [autoTimer invalidate];
    autoTimer = nil;
    
    [countdownTimer invalidate];
    countdownTimer = nil;
    secondsCount = 11;

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}



- (IBAction)imageChange:(id)sender
{
    if(colorimage)
    {
        [img setImage:[UIImage imageNamed:@""]];
        colorimage = NO;
    }
    else
    {
        [img setImage:[UIImage imageNamed:@"sky.jpg"]];
        colorimage = YES;
    }

       

  }
@end