//
//  AddressBookVC.m
//  Blocks
//
//  Created by Jean Paul Salas Poveda on 09/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddressBookVC.h"

@implementation AddressBookVC

- (void) safeReleaseForVariable:(id)var
{
    if (var != nil) 
    {
        [var release];
        var = nil;
    }
}

#pragma mark - AddressBook methods
- (ABRecordRef) createNewPersonInAddressBook:(ABAddressBookRef)paramAddressBook
{
    /* Check the address book parameter */ 
    if (paramAddressBook == nil)
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

- (BOOL) addPerson:(ABRecordRef)person inAddressBook:(ABAddressBookRef)paramAddressBook
{
    CFErrorRef  error = nil;
    BOOL    couldAddPerson = ABAddressBookAddRecord(paramAddressBook, person,&error);
    
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

- (BOOL) setFirstName:(NSString*)firstName inPerson:(ABRecordRef)person
{   
    return [self setValue:firstName atPropertyID:kABPersonFirstNameProperty inPerson:person];
}

- (BOOL) setLastName:(NSString*)lastName inPerson:(ABRecordRef)person
{
    return [self setValue:lastName atPropertyID:kABPersonLastNameProperty inPerson:person];
}

#pragma mark - ...
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

- (void) retrieveAllPeopleFromAddressBook:(ABAddressBookRef)addressBook
{
    CFArrayRef arrayOfAllPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
    
    if (arrayOfAllPeople != nil)
    {
        NSUInteger peopleCounter = 0; 
        
        for (peopleCounter = 0;peopleCounter < CFArrayGetCount(arrayOfAllPeople); peopleCounter++)
        {
            ABRecordRef thisPerson = CFArrayGetValueAtIndex(arrayOfAllPeople, peopleCounter);
            NSLog(@"%@", thisPerson);
            
            /* Use the [thisPerson] address book record */ 
            NSString *firstName = [self firstNamePropertyForRecord:thisPerson];
            NSString *lastName  = [self lastNamePropertyForRecord:thisPerson];
            
            NSLog(@"First Name = %@", firstName); 
            NSLog(@"Last Name = %@", lastName); 
            
            [self safeReleaseForVariable:firstName];
            [self safeReleaseForVariable:lastName];
            
            [self emailPropertyForRecord:thisPerson];
        }
        CFRelease(arrayOfAllPeople); 
    } /* if (allPeople != nil){ */
}

- (void) referenceToAddressBook
{
    ABAddressBookRef addressBook = ABAddressBookCreate();
    
    if (addressBook != nil)
    {
        NSLog(@"Successfully accessed the address book.");
        
        /* Work with the address book here */
        [self retrieveAllPeopleFromAddressBook:addressBook];
        
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
            } /* if (doYouWantToSaveChanges == YES){ */
        } 
        else 
        {
            /* We have not made any changes to the address book */
            NSLog(@"No changes to the address book."); 
        }
        
        CFRelease(addressBook);
    } 
    else 
    {
        NSLog(@"Could not access the address book."); 
    }    
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self referenceToAddressBook];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end