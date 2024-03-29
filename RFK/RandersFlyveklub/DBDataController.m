//
//  DBDataController.m
//  Database Data Controller
//
//  Created by Christian Sørensen on 19/02/13.
//  Copyright (c) 2013 Christian Sørensen. All rights reserved.
//

#import "DBDataController.h"
#import "sqlite3.h"
#import "Airfield.h"

//
@implementation DBDataController  {
    NSString       *db;             // Database name string
    NSMutableArray *data;           // Container for data returned from query
    sqlite3        *dbh;            // Database handle
    sqlite3_stmt   *stmt_query;     // Select statement handle
}

// Copy a named resource from bundle to Documents/Data
- (NSString *)copyResource:(NSString *)resource ofType:(NSString *)type
{
    NSString *dstDb = nil; 
    // Find path to Sandbox Documents
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    // Find named resource in bundle
    NSString *srcDb = [[NSBundle mainBundle] pathForResource:resource ofType:type];
    // Build path to "Data" subdirectory in Sandbox Documents
    NSString *dstDir = [docDir stringByAppendingPathComponent:@"Data"];
    // Build basename to resource in Sandbox Documents/Data
    NSString *dstBase = [dstDir stringByAppendingPathComponent:resource];
    // Append resource extension to build full path to resource "Documents/Data/resource.type"
    dstDb = [dstBase stringByAppendingPathExtension:type];
    
    NSError *error = nil;
    BOOL isDirectory = false;
    // Test if "Data" subdirectory exists in Sandbox "Documents"
    if (![[NSFileManager defaultManager] fileExistsAtPath:dstDir isDirectory:&isDirectory])
    {
        // Create "Data" subdirecotory
        if (![[NSFileManager defaultManager] createDirectoryAtPath:dstDir withIntermediateDirectories:YES attributes:nil error:&error])
            NSLog(@"Error creating directory:%@ \n", [error localizedDescription]);
    }
    
    // Test if named resource exists in Documents/Data
    if (![[NSFileManager defaultManager] fileExistsAtPath:dstDb])
    {
        // Copy the named resource from bundle to Documents/Data
        if (![[NSFileManager defaultManager] copyItemAtPath:srcDb toPath:dstDb error:&error])
            NSLog(@"Error: copying resource:%@\n", [error localizedDescription]);
    }
    
    // Return full path to resource "Documents/Data/resource.type"
    return dstDb;
}

// Prepare array to hold data from data storage
// Setup access to data storage
- (id)init
{
    self = [super init];
    if (self) 
    {
        // Copy sqlite database from bundle to Sandbox
        db = [self copyResource:@"airfields" ofType:@"rdb"];
        
        // Open database
        if (sqlite3_open([db UTF8String], &dbh) != SQLITE_OK) 
        {
            NSLog(@"Error:open");
        }
        
        // Reset statements
        stmt_query = nil;
        //stmt_delete = nil;
        //stmt_insert = nil;
        
        // Allocate array to hold data from data storage       
        data = [[NSMutableArray alloc] init];
    }
    return self;
}

//
- (void)dealloc
{   
    // Cleanup statement handles
    sqlite3_finalize(stmt_query);
    //sqlite3_finalize(stmt_delete);
    //sqlite3_finalize(stmt_insert);
    
    // Close database
    sqlite3_close(dbh);
}

#pragma mark - DataControllerDelegate 

// Fetch airfield objects from data storage
// Return array with airfield objects, selected according to SQL statement
- (NSMutableArray *) getAll:(rfkViewControllerMap *)controller
{
    if (!stmt_query)  
    {
        // Prepare SQL select statement
        NSString *sql = @"SELECT name, icao, country, lat, long FROM airfields WHERE country = 'Denmark'";
        if (sqlite3_prepare_v2(dbh, [sql UTF8String], -1, &stmt_query, nil) != SQLITE_OK)
        {
            NSLog(@"Error preparing SQL query");
            return data;
        }
    }
    
    // Reset state of query statement
    sqlite3_reset(stmt_query);  
    // Fetch selected rows in airfields table and populate data array
    while (sqlite3_step(stmt_query) == SQLITE_ROW) 
    {
        Airfield *airfield = [[Airfield alloc] init];
        
        // Assign name property with id column in result
        airfield.name = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(stmt_query, 0)];
        // Assign icao property with id column in result
        airfield.icao = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(stmt_query, 1)];
        // Assign country property with id column in result
        airfield.country = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(stmt_query, 2)];
        
        airfield.lat = [[[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(stmt_query, 3)]doubleValue];
        airfield.lng = [[[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(stmt_query, 4)]doubleValue];
        
        // Append Airfield object to data array
        [data addObject:airfield];
        //NSLog(@"===> Added Airfield: country: %@, lat: %.2f, long: %.2f", airfield.country, airfield.lat, airfield.lng);
        //NSLog(@"===> Added Airfield: name: %@, icao: %@, country: %@, lat: %@, long: %@", airfield.name, airfield.icao, airfield.country, airfield.lat, airfield.lng);
    }

    return data;
}

// Fetch airfield objects from data storage
// Return array with airfield objects, selected according to SQL statement
- (NSMutableArray *) getRegion:(rfkViewControllerMap *)controller, int minLat, int maxLat, int minLong, int maxLong
{
    if (!stmt_query)  
    {
        // Prepare SQL select statement
        NSString *sql = @"SELECT name, icao, country, lat, long FROM airfields WHERE tilerow > ";
        sql = [sql stringByAppendingString: [NSString stringWithFormat:@"%d", minLat]];
        sql = [sql stringByAppendingString: @" AND tilerow < "];
        sql = [sql stringByAppendingString: [NSString stringWithFormat:@"%d", maxLat]];
        sql = [sql stringByAppendingString: @" AND tilecol > "];
        sql = [sql stringByAppendingString: [NSString stringWithFormat:@"%d", minLong]];
        sql = [sql stringByAppendingString: @" AND tilecol < "];
        sql = [sql stringByAppendingString: [NSString stringWithFormat:@"%d", maxLong]];

        NSLog(@"%@", sql);
        if (sqlite3_prepare_v2(dbh, [sql UTF8String], -1, &stmt_query, nil) != SQLITE_OK)
        {
            NSLog(@"Error preparing SQL query");
            return data;
        }
    }
    
    // Reset state of query statement
    sqlite3_reset(stmt_query);  
    // Fetch selected rows in airfields table and populate data array
    while (sqlite3_step(stmt_query) == SQLITE_ROW) 
    {
        Airfield *airfield = [[Airfield alloc] init];
        
        // Assign name property with id column in result
        airfield.name = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(stmt_query, 0)];
        // Assign icao property with id column in result
        airfield.icao = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(stmt_query, 1)];
        airfield.country = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(stmt_query, 2)];
        airfield.lat = [[[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(stmt_query, 3)] doubleValue];
        airfield.lng = [[[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(stmt_query, 4)] doubleValue];    
        
        // Append Airfield object to data array
        [data addObject:airfield];
        NSLog(@"Added Airfield: %@", airfield.name);
    }
    
    return data;
}

@end
