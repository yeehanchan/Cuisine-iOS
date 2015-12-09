//
//  mapViewController.h
//  Cuisine
//
//  Created by Yeehan Chan on 10/21/15.
//  Copyright © 2015 Yeehan Chan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <AddressBook/AddressBook.h>
#import <CoreLocation/CoreLocation.h>

@interface mapViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>{
    CLLocationCoordinate2D coord;
    CLLocationManager *locationManager;
}
@property (strong,atomic)MKMapView *map;
@property (strong,nonatomic)MKMapItem *destination;
@property (strong,nonatomic)NSDictionary *address;
-(void)getDestinationCoord:(CLLocationCoordinate2D )coordinate;
@end
