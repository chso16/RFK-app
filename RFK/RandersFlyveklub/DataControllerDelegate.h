//  DataControllerDelegate.h
//
//  Created by Christian Sørensen on 19/02/13.
//  Copyright (c) 2013 Christian Sørensen. All rights reserved.

#import <Foundation/Foundation.h>

@class rfkViewControllerMap;
@class Airfield;

@protocol DataControllerDelegate <NSObject>

- (NSMutableArray *) getAll:(rfkViewControllerMap *)controller;
- (NSMutableArray *) getRegion:(rfkViewControllerMap *)controller, int minLat, int maxLat, int minLong, int maxLong;

@end
