/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "HeadlessJsTaskSupport.h"

NSString *const RCTHeadlessTaskDidFinishNotification = @"RCTHeadlessTaskDidFinishNotification";

@implementation HeadlessJsTaskSupport

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(notifyTaskFinished:(int)taskId)
{
  dispatch_async(dispatch_get_main_queue(), ^{
    [[NSNotificationCenter defaultCenter] postNotificationName:RCTHeadlessTaskDidFinishNotification object:@{@"taskId": @(taskId)}];
  });
}

@end
