//
//  DictionaryWithObject.m
//  Pods
//
//  Created by Alyssa McIntyre on 7/14/16.
//
//

#import "NSObject+Helpers.h"

@implementation NSObject (Helpers)
//- (NSDictionary*)dictionary
//{
    //NSMutableDictionary* dict = [NSMutableDictionary dictionary];

    //unsigned count;
    //objc_property_t* properties = class_copyPropertyList([self class], &count);
    //if ([self class] == [NSObject class]) {
        //return [NSDictionary dictionaryWithDictionary:dict];
    //}
    //else{
    //for (int i = 0; i < count; i++) {
        //NSString* key = [NSString stringWithUTF8String:property_getName(properties[i])];

        //id value = [self valueForKey:key];

        //if (!value) {
        //}

        //else if ([value isKindOfClass:[NSNumber class]]
            //|| [value isKindOfClass:[NSString class]]
            //|| [value isKindOfClass:[NSDictionary class]]
            //|| [value isKindOfClass:[NSArray class]]) {
            //[dict setObject:value forKey:key];
        //}
        //else if ([value isKindOfClass:[NSObject class]]) {
            //if ([key isEqualToString:@"identifier"]) {
                //[dict setObject:[value dictionary] forKey:@"id"];
            //}
            //else if ([key isEqualToString:@"globalPosition"]) {
                //[dict setObject:[value dictionary] forKey:@"global-position"];
            //}
            //else {
                //[dict setObject:[value dictionary] forKey:key];
            //}
        //}
        //else {
            //NSLog(@"Invalid type for %@ (%@)", NSStringFromClass([self class]), key);
        //}
    //}
    //}
    //free(properties);

    //return [[self superclass] dictionary];
//}
@end
