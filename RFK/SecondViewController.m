//
//  SecondViewController.m
//  RFK
//
//  Created by Christian Sørensen on 19/02/13.
//  Copyright (c) 2013 Christian Sørensen. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()


@end

@implementation SecondViewController
@synthesize myMapView;



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.myMapView = [[MKMapView alloc]
                      initWithFrame:self.view.bounds];
    [self.view addSubview:self.myMapView];
    [self mapcenter];
}

- (void)mapcenter
{
    myMapView.mapType = MKMapTypeStandard;
    MKCoordinateRegion myRegion;
    myRegion.center.latitude = 56.5;
    myRegion.center.longitude = 11.4;
    myRegion.span.latitudeDelta = 3.0  ;
    myRegion.span.longitudeDelta = 1.0;
    
    [self.myMapView setRegion:myRegion animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
