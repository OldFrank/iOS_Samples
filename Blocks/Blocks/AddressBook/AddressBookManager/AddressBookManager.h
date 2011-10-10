//
//  AddressBookManager.h
//  Blocks
//
//  Created by Jean Paul Salas Poveda on 09/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>

@interface AddressBookManager : NSObject
{
    ABAddressBookRef addressBook;    
}

- (void) releaseReference:(ABRecordRef)ref;

#pragma mark - SAVE, REVERT changes
- (void) saveAddressBookChanges;
- (void) revertAddressBookChanges;

#pragma mark - GROUP : create / add
- (ABRecordRef) createNewGroup;
- (BOOL) addGroup:(ABRecordRef)group;

#pragma mark - GROUP : set parameters
- (BOOL) setName:(NSString*)name inGroup:(ABRecordRef)group;
- (BOOL) addPerson:(ABRecordRef)paramPerson toGroup:(ABRecordRef)paramGroup;

#pragma mark - PERSON : create / add
- (ABRecordRef) createNewPerson;
- (BOOL) addPerson:(ABRecordRef)person;

#pragma mark - PERSON : set parameters
- (BOOL) setFirstName:(NSString*)firstName inPerson:(ABRecordRef)person;
- (BOOL) setLastName:(NSString*)lastName inPerson:(ABRecordRef)person;

#pragma mark - PERSON : get parameters
- (NSString*) firstNamePropertyForRecord:(ABRecordRef)record;
- (NSString*) lastNamePropertyForRecord:(ABRecordRef)record;
- (void)      emailPropertyForRecord:(ABRecordRef)record;

#pragma mark - PERSON : retrieve all people
- (CFArrayRef) retrieveAllPeople;
- (ABRecordRef) personInArray:(CFArrayRef)array atIndex:(NSInteger)index;

@end

@interface AddressBookManager (Private)
- (void) safeReleaseForVariable:(id)var;
- (BOOL) setValue:(NSString*)value atPropertyID:(ABPropertyID)key inPerson:(ABRecordRef)person;
- (BOOL) setValue:(NSString*)value atGroupProperty:(ABPropertyID)key inGroup:(ABRecordRef)group;
@end