//
//  AddressBookVC.m
//  Blocks
//
//  Created by Jean Paul Salas Poveda on 09/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddressBookVC.h"
#import "AddressBookManager.h"

@implementation AddressBookVC

#pragma mark - Others
- (void) safeReleaseForVariable:(id)var
{
    if (var != nil) 
    {
        [var release];
        var = nil;
    }
}

- (void) allPeopleTest
{
    AddressBookManager *manager = [[AddressBookManager alloc] init];
    
    CFArrayRef arrayOfAllPeople = [manager retrieveAllPeople];
    
    if (arrayOfAllPeople != nil)
    {
        NSUInteger peopleCounter = 0; 
        
        for (peopleCounter = 0;peopleCounter < CFArrayGetCount(arrayOfAllPeople); peopleCounter++)
        {
            ABRecordRef thisPerson = [manager personInArray:arrayOfAllPeople atIndex:peopleCounter];
            NSLog(@"%@", thisPerson);
            
            /* Use the [thisPerson] address book record */ 
            NSString *firstName = [manager firstNamePropertyForRecord:thisPerson];
            NSString *lastName  = [manager lastNamePropertyForRecord:thisPerson];            
            NSLog(@"First Name = %@", firstName); 
            NSLog(@"Last Name = %@", lastName); 
            
            [manager emailPropertyForRecord:thisPerson];
            
            [manager safeReleaseForVariable:firstName];
            [manager safeReleaseForVariable:lastName];
        }
        CFRelease(arrayOfAllPeople); 
    }
    
    [manager release];
}

- (void) createAndSaveNewPerson
{
    AddressBookManager *manager = [[AddressBookManager alloc] init];
    
    ABRecordRef newPerson = [manager createNewPerson];
    [manager setFirstName:@"CT" inPerson:newPerson];
    [manager setLastName:@"Ursita" inPerson:newPerson];
    [manager addPerson:newPerson];
    [manager saveAddressBookChanges];
    [manager releaseReference:newPerson];
    
    [manager release];
}

- (void) createAndSaveNewGroup
{
    AddressBookManager *manager = [[AddressBookManager alloc] init];
    
    ABRecordRef newGroup = [manager createNewGroup];
    [manager setName:@"Friends" inGroup:newGroup];
    [manager addGroup:newGroup];
    [manager saveAddressBookChanges];
    [manager releaseReference:newGroup];
    
    [manager release];
}

- (void) createUserAndGroupAndAddUserIntoGroup
{
    AddressBookManager *manager = [[AddressBookManager alloc] init];
    
    // New User
    ABRecordRef newPerson = [manager createNewPerson];
    [manager setFirstName:@"JP" inPerson:newPerson];
    [manager setLastName:@"SP" inPerson:newPerson];
    [manager addPerson:newPerson];
    [manager saveAddressBookChanges];
    
    // New Group
    ABRecordRef newGroup = [manager createNewGroup];
    [manager setName:@"Poveda" inGroup:newGroup];
    [manager addGroup:newGroup];
    [manager saveAddressBookChanges];
    
    // Adding user into group
    [manager addPerson:newPerson toGroup:newGroup];
    [manager saveAddressBookChanges];
    
    // Releasing
    [manager releaseReference:newPerson];
    [manager releaseReference:newGroup];
    
    [manager release];
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // TEST 1
    [self allPeopleTest];
    
    // TEST 2
    [self createAndSaveNewPerson];
    
    // TEST 3
    [self createAndSaveNewGroup];
    
    // TEST 4
    [self createUserAndGroupAndAddUserIntoGroup];
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