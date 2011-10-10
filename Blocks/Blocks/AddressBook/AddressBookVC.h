//
//  AddressBookVC.h
//  Blocks
//
//  Created by Jean Paul Salas Poveda on 09/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>

@interface AddressBookVC : UIViewController

#pragma mark - other
- (void) safeReleaseForVariable:(id)var;
- (BOOL) setValue:(NSString*)value atPropertyID:(ABPropertyID)key inPerson:(ABRecordRef)person;

#pragma mark - create new person
- (ABRecordRef) createNewPersonInAddressBook:(ABAddressBookRef)paramAddressBook;
- (BOOL) addPerson:(ABRecordRef)person inAddressBook:(ABAddressBookRef)paramAddressBook;

- (BOOL) setFirstName:(NSString*)firstName inPerson:(ABRecordRef)person;
- (BOOL) setLastName:(NSString*)lastName inPerson:(ABRecordRef)person;

#pragma mark - get parameters
- (NSString*) firstNamePropertyForRecord:(ABRecordRef)record;
- (NSString*) lastNamePropertyForRecord:(ABRecordRef)record;
- (void)      emailPropertyForRecord:(ABRecordRef)record;

#pragma mark - retrieve all people
- (void) retrieveAllPeopleFromAddressBook:(ABAddressBookRef)addressBook;

#pragma mark - get reference to addressbook
- (void) referenceToAddressBook;

@end