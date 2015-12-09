//
//  detailPage.h
//  Cuisine
//
//  Created by Yeehan Chan on 10/7/15.
//  Copyright © 2015 Yeehan Chan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface detailPage : UIViewController<NSURLConnectionDelegate>
@property(atomic,strong) UIImageView *foodpic;
@property(atomic,strong) UILabel *foodTitle;
@property(atomic,strong) UITextView *foodDiscription;
@property(atomic,strong) MKMapView *map;
@property (strong,nonatomic) NSDictionary *info;


-(void)populateFoodInfo:(NSDictionary *)info;
@end
