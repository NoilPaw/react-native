/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "RCTHeadlessTask.h"

@implementation RCTHeadlessTask

- (instancetype)initWithTaskKey:(NSString *)taskKey
                           data:(NSDictionary *)data
                        timeout:(long)timeout
                     completion:(TaskCompletion)completion
{
  self = [super init];
  if (self != nil) {
    _taskKey = taskKey;
    _data = data;
    _timeout = timeout;
    _completion = completion;
  }
  return self;
}

@end
