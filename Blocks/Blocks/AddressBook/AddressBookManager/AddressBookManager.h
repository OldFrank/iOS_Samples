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

#pragma mark - Other
- (void) saveAddressBookChanges;
- (void) revertAddressBookChanges;

#pragma mark - Create / Add person
- (ABRecordRef) createNewPersonInAddressBook:(ABAddressBookRef)paramAddressBook;
- (BOOL) addPerson:(ABRecordRef)person inAddressBook:(ABAddressBookRef)paramAddressBook;

#pragma mark - Set AddressBookParameters
- (BOOL) setFirstName:(NSString*)firstName inPerson:(ABRecordRef)person;
- (BOOL) setLastName:(NSString*)lastName inPerson:(ABRecordRef)person;

#pragma mark - Get AddressBook parameters
- (NSString*) firstNamePropertyForRecord:(ABRecordRef)record;
- (NSString*) lastNamePropertyForRecord:(ABRecordRef)record;
- (void)      emailPropertyForRecord:(ABRecordRef)record;

#pragma mark - Retrieve all people
- (void) retrieveAllPeopleFromAddressBook:(ABAddressBookRef)addressBook;

@end

@interface AddressBookManager (Private)
- (void) safeReleaseForVariable:(id)var;
- (BOOL) setValue:(NSString*)value atPropertyID:(ABPropertyID)key inPerson:(ABRecordRef)person;
@end