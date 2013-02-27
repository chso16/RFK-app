//
//  ThirdViewController.m
//  RFK
//
//  Created by Christian Sørensen on 19/02/13.
//  Copyright (c) 2013 Christian Sørensen. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()


@end

@implementation ThirdViewController
@synthesize webView;
@synthesize segcontrol;


- (void)viewDidLoad
{
    
    NSString *urlAddress = @"http://mobil.dmi.dk";
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:requestObj];

    [super viewDidLoad];
	
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






- (IBAction)Segcontrol:(id)sender
{
   if (segcontrol.selectedSegmentIndex == 0)
   {
       NSString *urlAddress = @"http://mobil.dmi.dk";
       NSURL *url = [NSURL URLWithString:urlAddress];
       
       NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
       
       [webView loadRequest:requestObj];
       
   }

    else if (segcontrol.selectedSegmentIndex == 1)
    
        {
            NSString *urlAddress = @"http://www.airfields.dk";
            NSURL *url = [NSURL URLWithString:urlAddress];
            
            NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
            
            [webView loadRequest:requestObj];
            
        }

    
    else if (segcontrol.selectedSegmentIndex == 2)
    {
        NSString *urlAddress = @"http://www.randersflyveklub.dk";
        NSURL *url = [NSURL URLWithString:urlAddress];
        
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        
        [webView loadRequest:requestObj];
        
    }

    
    else if (segcontrol.selectedSegmentIndex == 3)
        
    {
        NSString *urlAddress = @"http://embed.bambuser.com/broadcast/3381299";
        NSURL *url = [NSURL URLWithString:urlAddress];
        
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        
        [webView loadRequest:requestObj];
        
    }


    else
    {
        
    }

}
@end
