//
//  loginPageViewController.h
//  Cuisine
//
//  Created by Yeehan Chan on 10/8/15.
//  Copyright © 2015 Yeehan Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loginPageViewController : UIViewController <NSURLConnectionDelegate,UITextFieldDelegate>
{
    NSMutableData *responseData;
    NSURLProtectionSpace *loginProtectionSpace;
    NSURL *url;
    NSURLCredential *credential;
}
-(void)loginTestUser:(NSString *)username andpassword:(NSString*)password;
@end
