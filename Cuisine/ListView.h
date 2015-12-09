//
//  ListView.h
//  Cuisine
//
//  Created by Yeehan Chan on 9/30/15.
//  Copyright © 2015 Yeehan Chan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListCell.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface ListView : UITableViewController<UISearchBarDelegate,NSURLConnectionDelegate,CLLocationManagerDelegate>
{    NSMutableData *responseData;
     NSMutableArray *imageURL;
     NSMutableArray *image;
     NSMutableArray *foodname;
     NSMutableArray *fooddesc;
     MKMapView *mapview;
    CLLocationManager *lmanager;
    NSArray *result;
     int numberOfRows;
}
@end
