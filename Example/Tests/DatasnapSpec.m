//
//  DatasnapSpec.m
//  datasnap-ios-sdk
//
//  Created by Alyssa McIntyre on 6/20/16.
//  Copyright © 2016 DataSnap. All rights reserved.
//
#import <Datasnap/Datasnap.h>
#import <Kiwi/Kiwi.h>
#import <MagicalRecord/MagicalRecord.h>

SPEC_BEGIN(DatasnapSpec)
describe(@"Datasnap API",
    ^{
        __block NSManagedObjectContext* context = nil;
        __block Datasnap* datasnap = nil;
        __block EventQueue* eventQueue = nil;
        __block DatasnapAPI* apiServer = nil;
        __block NSDictionary* json = nil;
        beforeEach(^{

            // Set up Core Data entities for the categories tests.
            [MagicalRecord setDefaultModelFromClass:[BaseEvent class]];
            [MagicalRecord setupCoreDataStackWithInMemoryStore];
            context = [NSManagedObjectContext MR_defaultContext];

            // Mock the API server
            apiServer = [DatasnapAPI mock];
            [DatasnapAPI stub:@selector(init) andReturn:apiServer];

            //mock json for an event
            json = @{ @"event_type" : @"app_installed",
                @"user" : @{ @"id" : @{ @"global_distinct_id" : @"1" } },
                @"organization_ids" : @[ @"19CYxNMSQvfnnMf1QS4b3Z" ],
                @"project_ids" : @[ @"21213f8b-8341-4ef3-a6b8-ed0f84945186" ]
            };

            datasnap = [Datasnap new];
            datasnap.api = apiServer;
            eventQueue = [EventQueue new];
            [eventQueue stub:@selector(init) andReturn:eventQueue];
            datasnap.eventQueue = eventQueue;
            eventQueue.context = context;
        });
        afterEach(^{
            [MagicalRecord cleanUp];
        });
        it(@"Should add an event to db when recorded",
            ^{
                [eventQueue recordEvent:json];
                NSArray* eventsArray = [EventEntity returnAllEventsInContext:context];
                [[theValue(eventsArray.count) should] equal:theValue(1)];
            });
        it(@"Should not call API while offline",
            ^{
                [datasnap stub:@selector(connected) andReturn:theValue(NO)];
                [eventQueue recordEvent:json];
                __block BOOL isAPICalled = NO;
                [apiServer stub:@selector(sendEvents:)
                      withBlock:^id(NSArray* params) {
                          isAPICalled = YES;
                          return nil;
                      }];
                [datasnap checkQueue];
                [[theValue(isAPICalled) should] equal:theValue(NO)];
            });
        it(@"Should call API while online", ^{
            [datasnap stub:@selector(connected) andReturn:theValue(YES)];
            [eventQueue recordEvent:json];
            __block BOOL isAPICalled = NO;
            [apiServer stub:@selector(sendEvents:)
                  withBlock:^id(NSArray* params) {
                      isAPICalled = YES;
                      return nil;
                  }];
            [datasnap checkQueue];
            [[theValue(isAPICalled) should] equal:theValue(YES)];
        });
        it(@"Should not call checkQueue unless timer is up", ^{
            [datasnap setFlushParamsWithDuration:100000 withMaxElements:50];
            [NSTimer scheduledTimerWithTimeInterval:1
                                             target:self
                                           selector:@selector(checkQueue)
                                           userInfo:nil
                                            repeats:NO];
            __block BOOL isCheckQueueCalled = NO;
            [datasnap stub:@selector(checkQueue)
                 withBlock:^id(NSArray* params) {
                     isCheckQueueCalled = YES;
                     return nil;
                 }];
            [[theValue(isCheckQueueCalled) should] equal:theValue(NO)];
        });

    });

SPEC_END
