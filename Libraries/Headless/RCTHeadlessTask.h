/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TaskCompletion)(BOOL success);

@interface RCTHeadlessTask: NSObject

@property (nonatomic, readonly) NSString *taskKey;
@property (nonatomic, readonly) NSDictionary *data;
@property (nonatomic, readonly) long timeout;
@property (nonatomic, readonly, copy) TaskCompletion completion;

/**
 * @param taskKey The key for the JS task to execute. This is the same key that you call
 * AppRegistry.registerTask with in JS.
 * @param data A map of parameters that will be passed into JS.
 * @param timeout The amount of time (in ms) that the task should not exceed. A value of 0 means no timeout.
 * @param completion Will be called after the task was executed or if the execution failed.
 */
- (instancetype)initWithTaskKey:(NSString *)taskKey
                           data:(NSDictionary *)data
                        timeout:(long)timeout
                     completion:(TaskCompletion)completion;

@end

NS_ASSUME_NONNULL_END
