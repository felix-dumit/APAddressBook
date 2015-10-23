//
//  APContactListBuilder
//  AddressBook
//
//  Created by Alexey Belkevich on 06.10.15.
//  Copyright © 2015 alterplay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APTypes.h"

@class APContact;
@class APAddressBookContactsRoutine;

@interface APContactListBuilder : NSObject

@property (nonatomic, strong) BOOL (^ filterBlock)(APContact *contact);
@property (nonatomic, strong) NSArray *sortDescriptors;
@property (assign, nonatomic) BOOL mergeLinkedContacts;
@property (nonatomic, strong) APAddressBookContactsRoutine *contacts;
@property (nonatomic, assign) APContactField fieldsMask;


- (NSArray *)contactListWithAllContacts:(NSArray *)allContacts;

@end