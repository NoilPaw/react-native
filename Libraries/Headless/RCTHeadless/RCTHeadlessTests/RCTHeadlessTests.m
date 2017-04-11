/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import <XCTest/XCTest.h>
#import "RCTHeadlessTaskController.h"
#import "RCTHeadlessTask.h"
#import "RCTHeadlessTaskSupport.h"
#import <React/RCTBridge.h>
#import <RCTWebSocketModule.h>

@interface RCTHeadlessTests : XCTestCase <RCTBridgeDelegate>

@end

@implementation RCTHeadlessTests

- (void)testExecution {

  XCTestExpectation *expectation = [self expectationWithDescription:@"Task execution should finish."];

  RCTHeadlessTaskController *controller = [[RCTHeadlessTaskController alloc] initWithDelegate:self];

  RCTHeadlessTask *task = [[RCTHeadlessTask alloc] initWithTaskKey:@"TestTask" data:@{} timeout:0 completion:^(BOOL success) {
    [expectation fulfill];
  }];

  [controller executeTask:task];

  //TODO: Wait for finished execution.
  [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
    NSLog(@"Error: %@", error.localizedDescription);
  }];
}


- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
  //TODO: Initializing the native modules is not working with both following approaches.
//  NSBundle *bundle = [NSBundle bundleForClass:[self class]];
//  return [bundle URLForResource:@"TestBundle" withExtension:@"js"];
  return [NSURL URLWithString:@"http://localhost:8081/TestBundle.bundle?platform=ios"];
}

- (NSArray<id<RCTBridgeModule>> *)extraModulesForBridge:(RCTBridge *)bridge {
  // This might not be correct/necessary
  return @[[[RCTWebSocketModule alloc] init]];
}

@end

