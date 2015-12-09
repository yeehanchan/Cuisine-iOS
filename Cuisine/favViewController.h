//
//  favViewController.h
//  Cuisine
//
//  Created by Yeehan Chan on 12/7/15.
//  Copyright © 2015 Yeehan Chan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface favViewController : UITableViewController<NSURLConnectionDelegate>{
    NSMutableData *responseData;
    NSMutableArray *json_str;
    int numberOfRow;
}
@end
