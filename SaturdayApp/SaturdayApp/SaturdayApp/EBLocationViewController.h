//
//  EBLocationViewController.h
//  SaturdayApp
//
//  Created by michael on 4/19/14.
//  Copyright (c) 2014 BharatJeffSimer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h> //import corelocation framework
#import <MapKit/MapKit.h> //import the mapkit framework

@interface EBLocationViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate, MKOverlay> {
    
    CLLocationManager *lm; //core lcoation manager instance
    
    NSMutableArray *trackPointArray; //Array to store location points
    
    //instaces from mapkit to draw trail on map
    MKMapRect routeRect;
    MKPolylineView* routeLineView;
    MKPolyline* routeLine;
}
- (IBAction)startTracking:(id)sender;
@property (weak, nonatomic) IBOutlet MKMapView *mapview;


@end
