//
//  ListView.m
//  Cuisine
//
//  Created by Yeehan Chan on 9/30/15.
//  Copyright © 2015 Yeehan Chan. All rights reserved.
//

#import "ListView.h"
#import "ListCell.h"
#import "detailPage.h"
#import <UIKit/UIKit.h>

@interface ListView ()
@property (strong, nonatomic) UISearchBar *searchBar;
@end
@implementation ListView
-(void)viewWillDisappear:(BOOL)animated{
    [lmanager stopUpdatingLocation];
    
}
-(void)viewWillAppear:(BOOL)animated{
    if(result == nil){
        extern NSString *urlString;
        NSString *getString = [NSString stringWithFormat:@"%@/search?term=beef",urlString];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:getString]];
        request.HTTPMethod=@"GET";
        NSError *error;
        NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
  
    lmanager = [[CLLocationManager alloc]init];
    lmanager.delegate = self;
    lmanager.desiredAccuracy = kCLLocationAccuracyBest; // setting the accuracy
    [lmanager requestWhenInUseAuthorization];
    [lmanager startUpdatingLocation];  //requesting location updates
    
    
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, 40)];
    self.searchBar.showsCancelButton = NO; 
    self.searchBar.delegate = self;
    self.tableView.tableHeaderView = self.searchBar;
    [self.tableView setContentOffset:CGPointMake(0, 40)];
    numberOfRows = 3;
    

//    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(userDidSwipeLeft:)];
//    [swipe setDirection:UISwipeGestureRecognizerDirectionLeft];
//    swipe.delegate = self;
//    [self.tableView addGestureRecognizer:swipe];
    
    NSLog(@"view did load");
}



- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    CLLocation *location = [lmanager location];
    NSLog(@"current location:%f,%f",location.coordinate.latitude,location.coordinate.longitude);
    
    //send out http request
    [searchBar resignFirstResponder];
    extern NSString *urlString;
    NSString *getString = [NSString stringWithFormat:@"%@/search?term=%@",urlString,
self.searchBar.text];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:getString]];
    request.HTTPMethod=@"GET";
    NSError *error;
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
 
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)userDidSwipeLeft: (UISwipeGestureRecognizer *)swipe{
        CGPoint location = [swipe locationInView:self.tableView];
        NSIndexPath *swipeCell = [self.tableView indexPathForRowAtPoint:location];
//    NSLog(@"%@",swipeCell);
        ListCell* cell = [self.tableView cellForRowAtIndexPath:swipeCell];
    cell.userInteractionEnabled = YES;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [UIView animateWithDuration:0.1f animations:^{
        cell.foodpic.frame = CGRectOffset(cell.foodpic.frame, -40, 0);
    }];
    //    NSLog(@"%@",cell.accessoryType);
//    NSLog(@"gotin");

}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    NSLog(@"numberofrows is %d",numberOfRows);
    return numberOfRows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" ];
//    CGFloat navh = self.navigationController.navigationBar.frame.size.height;
//    cell.frame = CGRectMake(self.view.frame.origin.x,navh+self.view.frame.origin.y,self.view.frame.size.width,250);
    // Configure the cell...
    if(cell == nil){
        cell = [[ListCell alloc]init];
    }
    NSLog(@"read image %@",image[indexPath.row]);
    cell.foodpic.image = image[indexPath.row];
    cell.foodname.text = foodname[indexPath.row];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
//    UINavigationController *nav = [[UINavigationController alloc]init];
    detailPage *detail = [[detailPage alloc]init];
    if(detail.info == nil){
        [detail populateFoodInfo:result[indexPath.row]];
    }
    NSLog(@"print bar height%f",self.navigationController.navigationBar.frame.size.height);
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
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"There was an error retrieving your location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [errorAlert show];
    NSLog(@"Error: %@",error.description);
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *crnLoc = [locations lastObject];
    NSLog(@"didupdatelocation");
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
    NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    result = [json objectForKey:@"result"];
    imageURL = [[NSMutableArray alloc]init];
    foodname = [[NSMutableArray alloc]init];
    NSLog(@"dic:%@",result);
    for(NSDictionary *dict in result){
        [imageURL addObject:[dict objectForKey:@"image_url"]];
        [foodname addObject:[dict objectForKey:@"name"]];
    }
    
    
    NSLog(@"url:%@",imageURL);
    [self reloadTableView];
}
-(void)reloadTableView{
    if(imageURL){
        //        NSLog(@"imageURL get");
        numberOfRows = [imageURL count];
        image = [[NSMutableArray alloc]init];
        for (int i=0;i<numberOfRows;i++){
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL[i]]];
            [image addObject:[UIImage imageWithData:imageData]];
        }
        //        NSLog(@"image array%@",image);
        [self.tableView numberOfRowsInSection:numberOfRows];
        [self.tableView reloadData];
        //        NSLog(@"numberofrows is %ld",(long)[self.tableView numberOfRowsInSection:0]);
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
