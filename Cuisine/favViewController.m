//
//  favViewController.m
//  Cuisine
//
//  Created by Yeehan Chan on 12/7/15.
//  Copyright © 2015 Yeehan Chan. All rights reserved.
//

#import "favViewController.h"
#import "loginPageViewController.h"
#import "detailPage.h"
@interface favViewController()
@property (strong,nonatomic)UIButton *logOut;
@end

@implementation favViewController

-(void)viewWillAppear:(BOOL)animated{
    if([[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"]!= nil){
        extern NSString *urlString;
        NSString *getString = [NSString stringWithFormat:@"%@/favorite?user_id=%@",urlString,[[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"]];
        NSLog(@"fetch favorite %@",[[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"]);
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:getString]];
        request.HTTPMethod=@"GET";
        NSError *error;
    
        NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    }
}
-(void)viewDidLoad{
    NSLog(@"view did load");
    int statusheight = [[UIApplication sharedApplication]statusBarFrame].size.height;
    [self.tableView setContentInset:UIEdgeInsetsMake(statusheight,0,0,0)];
//    self.tableView.backgroundColor = [UIColor blackColor];
    NSLog(@"tableview frame%f",self.tableView.frame.origin.y);
    
    self.logOut = [[UIButton alloc]init];
    [self.logOut setTitle:@"LogOut" forState:UIControlStateNormal];
    self.logOut.backgroundColor = [UIColor redColor];
    [self.logOut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.logOut layer].cornerRadius = 5;
    
    UIView * footerview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 80)];
//    footerview.backgroundColor = [UIColor blueColor];
    [footerview addSubview:self.logOut];
    self.logOut.frame = CGRectMake(40, 40, self.logOut.superview.frame.size.width-80,40);
    NSLog(@"print out superview width %f",self.logOut.superview.frame.size.width);
    [self.logOut addTarget:self action:@selector(logOutPressed) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = footerview;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//warning Incomplete implementation, return the number of rows
    NSLog(@"fav view number of row%d",numberOfRow);
    return numberOfRow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [json_str[indexPath.row]objectForKey:@"name"];
    NSData * imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[json_str[indexPath.row] objectForKey:@"image_url"]]];
    UIImage *img = [UIImage imageWithData:imgData];
    cell.imageView.image = img;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    NSLog(@"did select");
    detailPage *detail = [[detailPage alloc]init];
    [detail populateFoodInfo:json_str[indexPath.row]];
    [self.navigationController pushViewController:detail animated:YES];
    
    
    /**    //Here is a demonstration of using NSUserDefaults for persistent storage.
     //Note that NSUserDefaults can only contain certain data types. It is more restrictive than what can be put in a generic NSDictionary as a value, and even those cannot have ints as values. That's why we use NSNumber here.
     NSNumber *numberOfTimes = [[NSUserDefaults standardUserDefaults] objectForKey:@"number of times"];
     
     //The first time we pull this from NSUserDefaults numberOfTimes will be nil, so here we set it to 0 so it's an NSNumber one way or the other
     if (numberOfTimes == nil) {
     numberOfTimes = [NSNumber numberWithInt:0];
     }
     
     //need to extract the int from the NSNumber to be able to do arithmetic with it
     int n = [numberOfTimes integerValue] + 1;// add one to the count
     numberOfTimes = [NSNumber numberWithInt:n];// wrap it in an NSNumber
     
     //set the new NSNumber in the user defaults
     [[NSUserDefaults standardUserDefaults] setObject:numberOfTimes forKey:@"number of times"];
     NSLog(@"number of times: %@", numberOfTimes);
     
     //In order to appreciate the persistence of the persistent storage you should stop the app after running, then run the app directly in the device/simulator not via XCode, select some rows, and then fully quit the app (double tapping/clicking on the home button on the device/simulator), opening up again, selecting more rows, and then finally running the app with XCode again and then selecting some more rows. You will see that the counts increased for each time selected those cells.
     //Also note that the app crashes while being run in XCode, the user defaults get reset to what they were prior to running the application that time.
     **/
    
}

- (void)logOutPressed{
    NSLog(@"logout is pressed");
    extern NSString *urlString;
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLProtectionSpace* loginProtectionSpace = [[NSURLProtectionSpace alloc]initWithHost:url.host port:[url.port integerValue] protocol:url.scheme realm:nil authenticationMethod:NSURLAuthenticationMethodHTTPDigest];
    NSDictionary *credentials = [[NSURLCredentialStorage sharedCredentialStorage]credentialsForProtectionSpace:loginProtectionSpace];
    NSURLCredential *credential = [credentials.objectEnumerator nextObject];
    NSLog(@"logout credentials%@",credential);
//    NSLog(@"logout");
    [[NSURLCredentialStorage sharedCredentialStorage]removeCredential:credential forProtectionSpace:loginProtectionSpace];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"user_id"];
//    NSLog(@"delete credentials%@",credentials);
    loginPageViewController *login = [[loginPageViewController alloc]init];
    [self presentViewController:login animated:nil completion:nil];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    responseData = [[NSMutableData alloc] init];
    NSLog(@"receive response");
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [responseData appendData:data];
    NSError *error = nil;
//    NSLog(@"%@",responseData);

    NSMutableDictionary *result = [[NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error]objectForKey:@"data"];
    NSLog(@"result is %@",result);
    json_str = [[NSMutableArray alloc]init];
    for(NSDictionary *dic in result){
        NSData * json_data = [[dic objectForKey:@"json_str"] dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableArray *json_object = [NSJSONSerialization JSONObjectWithData:json_data options:NSJSONReadingMutableContainers error:&error];
//        NSLog(@"print json_object%@",json_object);
        if (json_object!=nil) {
            [json_str addObject:json_object];
        }
 //       NSLog(@"dic data is %@",dic);

    }
    NSLog(@"json_str is how long%lu",(unsigned long)[json_str count]);
    [self reloadTableView];

}

-(void)reloadTableView{
    NSLog(@"json_str count%d",[json_str count]);
    if([json_str count] != 0){
        //        NSLog(@"imageURL get");
        numberOfRow = [json_str count];

        [self.tableView numberOfRowsInSection:numberOfRow];
        [self.tableView reloadData];
        NSLog(@"numberofrows is %ld",(long)[self.tableView numberOfRowsInSection:0]);
    }
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}



@end
