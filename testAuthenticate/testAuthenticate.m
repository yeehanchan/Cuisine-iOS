//
//  testAuthenticate.m
//  testAuthenticate
//
//  Created by Yeehan Chan on 12/9/15.
//  Copyright © 2015 Yeehan Chan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "loginPageViewController.h"
@interface testAuthenticate : XCTestCase
@property(strong,nonatomic)loginPageViewController *login;
@end

@implementation testAuthenticate

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.login = [[loginPageViewController alloc]init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    [self.login loginTestUser:@"yeehan" andpassword:@"123"];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
