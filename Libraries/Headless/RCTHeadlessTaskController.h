/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import <Foundation/Foundation.h>

@class RCTHeadlessTask;
@protocol RCTBridgeDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface RCTHeadlessTaskController : NSObject

/**
 * It may take a while until the controller is fully initialized. Executing
 * tasks in this time will be delayed until the initialization is complete.
 * A possible timeout of a task will start as soon as the task is added for
 * execution. As a result the controller might not even be initialized when
 * a task times out.
 *
 * @param delegate Used to initialize the underlying RCTBridge.
 */
- (instancetype)initWithDelegate:(id<RCTBridgeDelegate>)delegate;

/**
 * Executes the task in JS.
 *
 * @param task The task to execute.
 */
- (void)executeTask:(RCTHeadlessTask *)task NS_SWIFT_NAME(execute(task:));

@end

NS_ASSUME_NONNULL_END
