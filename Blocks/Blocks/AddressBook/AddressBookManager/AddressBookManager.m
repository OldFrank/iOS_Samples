//
//  AddressBookManager.m
//  Blocks
//
//  Created by Jean Paul Salas Poveda on 09/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddressBookManager.h"

@implementation AddressBookManager

- (id)init
{
    if ((self = [super init])) 
    {
        addressBook = ABAddressBookCreate();
        
        if (addressBook != nil)
            NSLog(@"Successfully accessed the address book.");
        else
            NSLog(@"Could not access the address book."); 
    }
    
    return self;
}

- (void) saveAddressBookChanges
{
    /* Let's see if we have made any changes to the address book or not, before attempting to save it */
    if (ABAddressBookHasUnsavedChanges(addressBook) == YES)
    { 
        /* Now decide if you want to save the changes to the address book */
        NSLog(@"Changes were found in the address book.");
        BOOL doYouWantToSaveChanges = YES;
        
        /* We can make a decision to save or revert the address book back to how it was before */
        if (doYouWantToSaveChanges == YES)
        {
            CFErrorRef saveError = NULL;
            if (ABAddressBookSave(addressBook, &saveError) == YES)
            { 
                /* We successfully saved our changes to the address book */
            } 
            else 
            {
                /* We failed to save the changes. You can now
                 access the [saveError] variable to find out
                 what the error is */ 
            }
        } 
        else 
        {
            /* We did NOT want to save the changes to the address book so let's revert it to how it was before */
            ABAddressBookRevert(addressBook);
        }
    } 
    else 
    {
        /* We have not made any changes to the address book */
        NSLog(@"No changes to the address book."); 
    }    
}

- (void) revertAddressBookChanges
{
    /* We did NOT want to save the changes to the address book so let's revert it to how it was before */
    ABAddressBookRevert(addressBook);
}

#pragma mark - Create / Add person
- (ABRecordRef) createNewPersonInAddressBook
{
    /* Check the address book parameter */ 
    if (addressBook == nil)
    {
        NSLog(@"The address book is nil.");
        return nil; 
    }
    
    /* Just create an empty person entry */
    ABRecordRef person = ABPersonCreate();
    
    if (person == nil)
    {
        NSLog(@"Failed to create a new person.");
        
        return nil; 
    }
    
    return person;
}

- (BOOL) addPerson:(ABRecordRef)person
{
    CFErrorRef  error = nil;
    BOOL    couldAddPerson = ABAddressBookAddRecord(addressBook, person,&error);
    
    /* Add the person record to the address book. We have NOT saved yet */
    if (couldAddPerson == YES)
    {
        NSLog(@"Successfully added the new person.");
    } 
    else 
    {
        NSLog(@"Could not add a new person."); 
    }
    
    return couldAddPerson;
}

#pragma mark - Set AddressBookParameters
- (BOOL) setFirstName:(NSString*)firstName inPerson:(ABRecordRef)person
{   
    return [self setValue:firstName atPropertyID:kABPersonFirstNameProperty inPerson:person];
}

- (BOOL) setLastName:(NSString*)lastName inPerson:(ABRecordRef)person
{
    return [self setValue:lastName atPropertyID:kABPersonLastNameProperty inPerson:person];
}

#pragma mark - Get AddressBook parameters
- (NSString*) firstNamePropertyForRecord:(ABRecordRef)record
{
    return (NSString *)ABRecordCopyValue(record,kABPersonFirstNameProperty);
}

- (NSString*) lastNamePropertyForRecord:(ABRecordRef)record
{
    return (NSString *) ABRecordCopyValue(record,kABPersonLastNameProperty);
}

- (void) emailPropertyForRecord:(ABRecordRef)record
{
    if (record == nil)
    {
        return; 
    }
    
    ABMultiValueRef emails = ABRecordCopyValue(record, kABPersonEmailProperty);
    
    /* This contact does not have an email property */ 
    if (emails == nil)
    {
        return; 
    }
    
    /* Go through all the emails */ 
    NSUInteger numberOfEmails = ABMultiValueGetCount(emails);
    NSLog(@"number of emails : %d",numberOfEmails);
    
    for (NSUInteger emailCounter = 0;emailCounter < numberOfEmails; emailCounter++)
    {
        /* Get the label of the email (if any) */
        NSString *emailLabel            = (NSString *) ABMultiValueCopyLabelAtIndex(emails, emailCounter);
        NSString *localizedEmailLabel   = (NSString *) ABAddressBookCopyLocalizedLabel((CFStringRef)emailLabel);
        
        /* And then get the email address itself */ 
        NSString *email = (NSString *) ABMultiValueCopyValueAtIndex(emails, emailCounter);
        NSLog(@"Label = %@, Localized Label = %@, Email = %@", emailLabel, localizedEmailLabel, email);
        
        [self safeReleaseForVariable:email];
        [self safeReleaseForVariable:emailLabel];
        [self safeReleaseForVariable:localizedEmailLabel];
    }
    
    CFRelease(emails);
}

#pragma mark - Others
- (CFArrayRef) retrieveAllPeople
{
    return ABAddressBookCopyArrayOfAllPeople(addressBook);
}

@end

@implementation AddressBookManager (Private)
- (void) safeReleaseForVariable:(id)var
{
    if (var != nil) 
    {
        [var release];
        var = nil;
    }
}

- (BOOL) setValue:(NSString*)value atPropertyID:(ABPropertyID)key inPerson:(ABRecordRef)person
{
    /* Set the first name of the person */
    CFErrorRef error = nil;
    BOOL couldSetValue = ABRecordSetValue(person, key, value,&error);
    
    if (couldSetValue == YES)
    {
        NSLog(@"Successfully set %@.",value);
    }
    else 
    {
        NSLog(@"Could not set %@.",value); 
    }
    
    return couldSetValue;
}
@end