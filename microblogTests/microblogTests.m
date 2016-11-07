//
//  microblogTests.m
//  microblogTests
//
//  Created by apple on 15/12/23.
//  Copyright © 2015年 yf. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface microblogTests : XCTestCase

@end

@implementation microblogTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    NSTimeInterval inter=CACurrentMediaTime();
    XCTAssert(3==3,@"==============123123");
    [NSThread sleepForTimeInterval:2];
    NSLog(@"-------------------%.2f",CACurrentMediaTime()-inter);

}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}


-(void)testxxxx{
    
}

@end
