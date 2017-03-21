/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "RCTHeadlessTaskController.h"
#import "RCTHeadlessTask.h"
#import "RCTHeadlessTaskSupport.h"
#import "RCTBridge.h"

@interface RCTHeadlessTaskController ()
@property (nonatomic, strong) RCTBridge *bridge;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, RCTHeadlessTask *> *activeTasks;
@property (nonatomic) int lastTaskId;
@end

@implementation RCTHeadlessTaskController

- (instancetype)initWithDelegate:(id<RCTBridgeDelegate>)delegate
{
  self = [super init];
  if (self) {
    self.lastTaskId = 0;
    self.activeTasks = [NSMutableDictionary new];
    self.bridge = [[RCTBridge alloc] initWithDelegate:delegate
                                        launchOptions:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(javaScriptDidLoad:)
                                                 name:RCTJavaScriptDidLoadNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(javaScriptDidFailToLoad:)
                                                 name:RCTJavaScriptDidFailToLoadNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(taskDidFinish:)
                                                 name:RCTHeadlessTaskDidFinishNotification
                                               object:nil];
  }
  return self;
}

- (void)dealloc
{
  [self.bridge invalidate];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)executeTask:(RCTHeadlessTask *)task
{
  if (!self.bridge.isValid) {
    // TODO: Handle error
    return;
  }

  NSNumber *newTaskId = @(self.lastTaskId++);
  self.activeTasks[newTaskId] = task;

  if (!self.bridge.isLoading) {
    [self startTask:task withTaskId:newTaskId];
  }

  if (task.timeout > 0) {
    [self startTimeoutForTask:task];
  }
}

- (void)startTask:(RCTHeadlessTask *)task withTaskId:(NSNumber *)taskId
{
  [self.bridge enqueueJSCall:@"AppRegistry"
                      method:@"startHeadlessTask"
                        args:@[taskId, task.taskKey, task.data]
                  completion:NULL];
}

- (void)javaScriptDidLoad:(NSNotification *)notification
{
  if (self.activeTasks.count > 0) {
    for (NSNumber *taskId in self.activeTasks) {
      RCTHeadlessTask *task = self.activeTasks[taskId];
      [self startTask:task withTaskId:taskId];
    }
  }
}

- (void)javaScriptDidFailToLoad:(NSNotification *)notification
{
  //TODO: We should not allow executeTask to be called from now on

  if (self.activeTasks.count > 0) {
    for (NSNumber *taskId in self.activeTasks) {
      RCTHeadlessTask *task = self.activeTasks[taskId];
      //TODO: Notify a task delegate about the failure
    }
  }
}

- (void)taskDidFinish:(NSNotification *)notification
{
  NSNumber *taskId = notification.userInfo[@"taskId"];
  if (taskId) {
    for (NSNumber *aTaskId in self.activeTasks) {
      if ([aTaskId isEqualToNumber:taskId]) {

        RCTHeadlessTask *task = [self.activeTasks objectForKey:aTaskId];

        [self.activeTasks removeObjectForKey:aTaskId];
        [self cancelTimeoutForTask:task];

        //TODO: Notify a task delegate about the success

        break;
      }
    }
  }
}

- (void)startTimeoutForTask:(RCTHeadlessTask *)task
{
  //TODO: Timeout handling
}

- (void)cancelTimeoutForTask:(RCTHeadlessTask *)task
{
  //TODO: Remove timeout
}

- (void)taskDidTimeout:(RCTHeadlessTask *)task
{
  //TODO: Notify a task delegate about the failure
}

@end
