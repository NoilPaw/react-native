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

NS_ASSUME_NONNULL_BEGIN

@interface RCTHeadlessTaskController : NSObject

/**
 * Executes the task in JS.
 *
 * @param task The task to execute.
 */
- (void)executeTask:(RCTHeadlessTask *)task NS_SWIFT_NAME(execute(task:));

@end

NS_ASSUME_NONNULL_END
