//
//  APContact.m
//  APAddressBook
//
//  Created by Alexey Belkevich on 1/10/14.
//  Copyright (c) 2014 alterplay. All rights reserved.
//

#import "APContact.h"

@interface NSArray (Unique)

@end

@implementation NSArray(Unique)

- (NSArray *)uniqueArray
{
    return [[NSOrderedSet orderedSetWithArray:self] array];
}

@end

@implementation APContact

- (void)mergeWith:(APContact *)contact {

    if(!self.name){
        self.name = contact.name;
    }
    
    if(!self.birthday){
        self.birthday = contact.birthday;
    }
    
    if(!self.job){
        self.job = contact.job;
    }

    if (!self.thumbnail) {
        self.thumbnail = contact.thumbnail;
    }
    
    if (!self.thumbnail) {
        self.thumbnail = contact.thumbnail;
    }
    
    if (!self.note) {
        self.note = contact.note;
    }

    self.phones = [[self.phones arrayByAddingObjectsFromArray:contact.phones] uniqueArray];
    self.emails = [[self.emails arrayByAddingObjectsFromArray:contact.emails] uniqueArray];
    self.addresses = [[self.addresses arrayByAddingObjectsFromArray:contact.addresses] uniqueArray];
    self.socialProfiles = [[self.socialProfiles arrayByAddingObjectsFromArray:contact.socialProfiles] uniqueArray];
    self.linkedRecordIDs = [[self.linkedRecordIDs arrayByAddingObjectsFromArray:contact.linkedRecordIDs] uniqueArray];
}

@end

