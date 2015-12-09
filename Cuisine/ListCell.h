//
//  ListCell.h
//  Cuisine
//
//  Created by Yeehan Chan on 9/30/15.
//  Copyright © 2015 Yeehan Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListCell : UITableViewCell
@property(nonatomic,strong) UIImageView *foodpic;
@property(nonatomic,strong) UIVisualEffectView *mask;
@property(nonatomic,strong) UIBlurEffect *blur;
@property(nonatomic,strong) UILabel *foodname;
@property(nonatomic,strong) UIImage *img;
@property(nonatomic,strong) NSString *fn;

- (void)populateImage:(UIImage *)i andFoodname:(NSString *)s;
- (void)cleanCell;
@end
