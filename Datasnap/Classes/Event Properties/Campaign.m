//
//  Campaign.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/6/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "Campaign.h"

@implementation Campaign
@synthesize title;
@synthesize identifier;
@synthesize communicationIds;
@synthesize tags;
- (NSDictionary*)convertToDictionary
{
    NSDictionary* dictionary = @{
        @"title" : self.title,
        @"id" : self.identifier,
        @"communication_ids" : self.communicationIds,
        @"tags" : [self.tags convertToDictionary] ? [self.tags convertToDictionary] : [NSNull null]
    };
    return dictionary;
}
- (Campaign*)initWithTitle:(NSString*)title
                identifier:(NSString*)identifier
          communicationIds:(NSString*)communicationIds
                   andTags:(Tags*)tags
{
    self.title = title;
    self.identifier = identifier;
    self.communicationIds = communicationIds;
    self.tags = tags;
    return self;
}
@end
