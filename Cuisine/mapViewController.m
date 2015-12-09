//
//  mapViewController.m
//  Cuisine
//
//  Created by Yeehan Chan on 10/21/15.
//  Copyright © 2015 Yeehan Chan. All rights reserved.
//

#import "mapViewController.h"
@interface mapViewController ()
@end

@implementation mapViewController
-(void)viewWillDisappear:(BOOL)animated{
    [locationManager stopUpdatingLocation];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.map = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    
    MKUserLocation *userLocation = [locationManager location];
    self.map.showsUserLocation = YES;
    NSLog(@"user location coordinate %f,%f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 2000, 2000);
    [self.map setRegion:region animated:YES];
    self.map.delegate = self;
    [self getDirections];
    [self.view addSubview:self.map];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)getDestinationCoord:(CLLocationCoordinate2D)coordinate{
    coord = coordinate;
    NSLog(@"coord update %f,%f",coord);
}
- (void)getDirections
{
    MKDirectionsRequest *request =[[MKDirectionsRequest alloc] init];
    
    request.source = [MKMapItem mapItemForCurrentLocation];
    
    self.address= @{
                    (NSString *) kABPersonAddressStreetKey : @"15th st",
                    (NSString *) kABPersonAddressCityKey : @"New York",
                    (NSString *) kABPersonAddressStateKey : @"New York",
                    (NSString *) kABPersonAddressZIPKey : @"10001",
                    (NSString *) kABPersonAddressCountryKey : @"United State",
                    (NSString *) kABPersonAddressCountryCodeKey : @"+1"
                    };
    MKPlacemark *placemark = [[MKPlacemark alloc]initWithCoordinate:coord addressDictionary:self.address];
    self.destination = [[MKMapItem alloc]initWithPlacemark:placemark];
    request.destination = self.destination;
    
    request.requestsAlternateRoutes = NO;
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    
    
    
    [directions calculateDirectionsWithCompletionHandler:
     ^(MKDirectionsResponse *response, NSError *error) {
         if (error) {
             // Handle error
             NSLog(@"direction response error!");
         } else {
             [self showRoute:response];
         }
     }];
}
-(void)showRoute:(MKDirectionsResponse *)response
{
    for (MKRoute *route in response.routes)
    {
        [self.map addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
        
        for (MKRouteStep *step in route.steps)
        {
            NSLog(@"%@", step.instructions);
        }
    }
    MKCircle *circle = [MKCircle circleWithCenterCoordinate:coord radius:500];
    [self.map addOverlay:circle];

}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay
{
    if([overlay isKindOfClass:[MKPolyline class]]){
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        renderer.strokeColor = [UIColor blueColor];
        renderer.lineWidth = 5.0;
        return renderer;
    }
    if ([overlay isKindOfClass:[MKCircle class]]) {
        NSLog(@"overlay is circle");
        MKCircleRenderer *renderer = [[MKCircleRenderer alloc] initWithOverlay:overlay];
        renderer.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.2];
        renderer.strokeColor = [[UIColor redColor] colorWithAlphaComponent:0.7];
        renderer.lineWidth = 2;
        return renderer;
    }
    return false;
    
}
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay {
    if ([overlay isKindOfClass:[MKCircle class]]) {
        NSLog(@"overlay is circle");
        MKCircleRenderer *circleView = [[MKCircleRenderer alloc] initWithCircle:(MKCircle*)overlay];
        circleView.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.2];
        circleView.strokeColor = [[UIColor redColor] colorWithAlphaComponent:0.7];
        circleView.lineWidth = 2;
        return circleView;
    }
    else{
        return false;
    }
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    NSLog(@"map key did update");
 //   [ stopUpdatingLocation];
}
@end
