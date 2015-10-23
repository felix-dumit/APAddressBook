//
//  APContactListBuilder 
//  AddressBook
//
//  Created by Alexey Belkevich on 06.10.15.
//  Copyright © 2015 alterplay. All rights reserved.
//

#import "APContactListBuilder.h"
#import "APContact.h"
#import "APAddressBookContactsRoutine.h"

@implementation APContactListBuilder

#pragma mark - public

- (NSArray *)contactListWithAllContacts:(NSArray *)allContacts
{
    NSMutableArray *mutableContacts = allContacts.mutableCopy;
    [self filterContacts:mutableContacts];
    [self sortContacts:mutableContacts];
    if(self.mergeLinkedContacts){
        return [self mergedLinkedContactsArray:mutableContacts];
    }
    return mutableContacts.copy;
}

#pragma mark - private

- (void)filterContacts:(NSMutableArray *)contacts
{
    if (self.filterBlock)
    {
        NSPredicate *predicate;
        predicate = [NSPredicate predicateWithBlock:^BOOL(APContact *contact, NSDictionary *bindings)
        {
            return self.filterBlock(contact);
        }];
        [contacts filterUsingPredicate:predicate];
    }
}

- (void)sortContacts:(NSMutableArray *)contacts
{
    if (self.sortDescriptors)
    {
        [contacts sortUsingDescriptors:self.sortDescriptors];
    }
}

- (NSArray *)mergedLinkedContactsArray:(NSMutableArray *)contacts {
    NSMutableArray *removeContactsIds = [NSMutableArray array];
    
    for (APContact *contact in contacts) {
        if ([removeContactsIds containsObject:contact.recordID]) {
            continue;
        }
        
        for (NSNumber *rId in contact.linkedRecordIDs) {
            APContact *linkedContact = [self.contacts contactByRecordID:rId withFieldMask:self.fieldsMask];

            
            if (linkedContact) {
                [contact mergeWith:linkedContact];
                [removeContactsIds addObject:linkedContact.recordID];
            }
        }
    }
    
    return [contacts filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL (APContact *evaluatedObject, NSDictionary *bindings) {
        return ![removeContactsIds containsObject:evaluatedObject.recordID];
    }]];
}


@end