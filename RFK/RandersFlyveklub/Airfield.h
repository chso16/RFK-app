//
//  Airfield.h
//  MyTest
//
//  Created by Christian Sørensen on 19/02/13.
//  Copyright (c) 2013 Christian Sørensen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Airfield : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icao;
@property (nonatomic, copy) NSString *country;
@property (nonatomic) double lat;
@property (nonatomic) double lng;

@end
