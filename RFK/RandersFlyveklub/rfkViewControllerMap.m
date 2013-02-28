//
//  rfkDetailViewController.m
//  RandersFlyveklub
//
//  Created by Christian Sørensen on 19/02/13.
//  Copyright (c) 2013 Christian Sørensen. All rights reserved.//

#import "rfkViewControllerMap.h"
#import "Airfield.h"

@implementation rfkViewControllerMap
@synthesize labelSelected;
@synthesize labelObservationTime;
@synthesize labelWindDirection;
@synthesize labelWindSpeed;
@synthesize labelClouds;
@synthesize labelDewPoint;
@synthesize labelWeatherCondition;
@synthesize labelTemperature;
@synthesize myMapView2;
@synthesize dcDelegate2;
@synthesize textfieldInputICAO;

NSString* dump;
NSMutableArray *airfieldList;

////////
NSURLConnection *theConnection;
NSMutableData *receivedData;
NSString* xml;
NSData *dataOne;
////////
 
- (void)getMapWithPins
{
    // Map center
    myMapView2.mapType = MKMapTypeSatellite;
    MKCoordinateRegion myRegion;
    myRegion.center.latitude = 56;
    myRegion.center.longitude = 10.8;
    myRegion.span.latitudeDelta = 3;
    myRegion.span.longitudeDelta = 7;
    
    // Clear all annotations
    [self.myMapView2 removeAnnotations:self.myMapView2.annotations];
    
    // Database...
    self.dcDelegate2 = [[DBDataController alloc] init];
    airfieldList = [self.dcDelegate2 getAll:self];
    NSInteger count = 0;
    for (Airfield *airfield in airfieldList)
    {
        CLLocationCoordinate2D coordinate1 ;
        coordinate1.latitude = airfield.lat;
        coordinate1.longitude = airfield.lng;
        MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc] init];
        [myAnnotation setCoordinate:coordinate1];
        [myAnnotation setTitle:airfield.name];
        [myAnnotation setSubtitle:airfield.icao];
        
        [self.myMapView2 addAnnotation:myAnnotation];
        
        NSLog(@"name: %@, icao: %@, country: %@, lat: %.2f, long: %.2f", airfield.name, airfield.icao, airfield.country, airfield.lat, airfield.lng);
        
        count = count + 1;
    }
    //NSLog(@"Total: %i", count);

    [self.myMapView2 setRegion:myRegion animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getMapWithPins];
}


//////// START //////////////
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
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (theConnection)
    {
        xml = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
        xmlParser = [[NSXMLParser alloc] initWithData:[xml dataUsingEncoding:NSUTF8StringEncoding]];
        [xmlParser setDelegate:self];
        [xmlParser setShouldProcessNamespaces:NO];
        [xmlParser setShouldReportNamespacePrefixes:NO];
        [xmlParser setShouldResolveExternalEntities:NO];
        [xmlParser parse];
        NSLog(@" here is the data: %@", xml);
    }
} 

-(void)parserDidStartDocument:(NSXMLParser *)parser
{
    depth = 0;
    currentElement = nil;
    stationName = [[NSMutableString alloc] init];
    lat = [[NSMutableString alloc] init];
    lng = [[NSMutableString alloc] init];
    temperature = [[NSMutableString alloc] init];
    humid = [[NSMutableString alloc] init];
    clouds = [[NSMutableString alloc] init];;
    observationTime = [[NSMutableString alloc] init];;
    windSpeed = [[NSMutableString alloc] init];;
    windDirection = [[NSMutableString alloc] init];;
    dewPoint = [[NSMutableString alloc] init];;
    weatherCondition = [[NSMutableString alloc] init];;
}

-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"Error: %@", [parseError localizedDescription]);
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    currentElement = [elementName copy];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([currentElement isEqualToString:@"stationName"]) 
        [stationName appendString:string];
    if ([currentElement isEqualToString:@"lat"]) 
        [lat appendString:string];
    if ([currentElement isEqualToString:@"lng"]) 
        [lng appendString:string];
    if ([currentElement isEqualToString:@"humidity"]) 
        [humid appendString:string];
    if ([currentElement isEqualToString:@"temperature"]) 
        [temperature appendString:string];
    if ([currentElement isEqualToString:@"clouds"]) 
        [clouds appendString:string];
    if ([currentElement isEqualToString:@"observationTime"]) 
        [observationTime appendString:string];
    if ([currentElement isEqualToString:@"windSpeed"]) 
        [windSpeed appendString:string];
    if ([currentElement isEqualToString:@"windDirection"]) 
        [windDirection appendString:string];
    if ([currentElement isEqualToString:@"dewPoint"]) 
        [dewPoint appendString:string];
    if ([currentElement isEqualToString:@"weatherCondition"]) 
        [weatherCondition appendString:string];
}

-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    // Change values of "weather info box"
    labelSelected.text = stationName;
    labelObservationTime.text = observationTime;
    labelWindDirection.text = windDirection;
    labelWindSpeed.text = windSpeed;
    labelClouds.text = clouds;
    labelDewPoint.text = dewPoint;
    labelWeatherCondition.text = weatherCondition;
    labelTemperature.text = [NSString stringWithFormat:@"%@°C", temperature];
}
///////// END //////////////


- (void)viewDidUnload
{
    [self setMyMapView2:nil];
    [self setLabelSelected:nil];
    [self setLabelObservationTime:nil];
    [self setLabelWindDirection:nil];
    [self setLabelWindSpeed:nil];
    [self setLabelClouds:nil];
    [self setLabelDewPoint:nil];
    [self setLabelWeatherCondition:nil];
    [self setTextfieldInputICAO:nil];
    [self setLabelTemperature:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self getMapWithPins];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (void)callWebService
{
    NSLog(@"button is pushed...");
    NSString *icaoInput = textfieldInputICAO.text;
    
    
    receivedData = [[NSMutableData alloc] init];
    
    NSString *url = [NSString stringWithFormat:@"http://api.geonames.org/weatherIcao?ICAO=%@&username=okdios&style=full", icaoInput];
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
}

- (IBAction)buttonGetWeatherInfo:(id)sender 
{
    [sender resignFirstResponder];
    [self callWebService];
}

-(IBAction)ReturnKeyButton:(id)sender
{
    [sender resignFirstResponder];
    [self callWebService];
}

-(IBAction)backgroundTouched:(id)sender
{
    
}

@end