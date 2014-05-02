//
//  EBLocationViewController.m
//  SaturdayApp
//
//  Created by michael on 4/19/14.
//  Copyright (c) 2014 BharatJeffSimer. All rights reserved.
//

#import "EBLocationViewController.h"

@interface EBLocationViewController ()

@end

@implementation EBLocationViewController

@synthesize mapview;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Welcome to Broadcast!";
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    trackPointArray = [[NSMutableArray alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startTracking:(id)sender {
    //start location manager
    lm = [[CLLocationManager alloc] init];
    lm.delegate = self;
    lm.desiredAccuracy = kCLLocationAccuracyBest;
    lm.distanceFilter = kCLDistanceFilterNone;
    [lm startUpdatingLocation];
    
    mapview.delegate = self;
    mapview.showsUserLocation = YES;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    //get the latest location
    CLLocation *currentLocation = [locations lastObject];
    
    //store latest location in stored track array;
    [trackPointArray addObject:currentLocation];
    
    //get latest location coordinates
    CLLocationDegrees Latitude = currentLocation.coordinate.latitude;
    CLLocationDegrees Longitude = currentLocation.coordinate.longitude;
    CLLocationCoordinate2D locationCoordinates = CLLocationCoordinate2DMake(Latitude, Longitude);
    
    //zoom map to show users location
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(locationCoordinates, 1000, 1000);
    MKCoordinateRegion adjustedRegion = [mapview regionThatFits:viewRegion]; [mapview setRegion:adjustedRegion animated:YES];
    
    NSInteger numberOfSteps = trackPointArray.count;
    
    CLLocationCoordinate2D coordinates[numberOfSteps];
    for (NSInteger index = 0; index < numberOfSteps; index++) {
        CLLocation *location = [trackPointArray objectAtIndex:index];
        CLLocationCoordinate2D coordinate2 = location.coordinate;
        
        coordinates[index] = coordinate2;
    }
    
    MKPolyline *polyLine = [MKPolyline polylineWithCoordinates:coordinates count:numberOfSteps];
    [mapview addOverlay:polyLine];
    
    //NSLog(@"%@", trackPointArray);
}


- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    MKPolylineView *polylineView = [[MKPolylineView alloc] initWithPolyline:overlay];
    polylineView.strokeColor = [UIColor redColor];
    polylineView.lineWidth = 4.0;
    
    return polylineView;
}



@end
