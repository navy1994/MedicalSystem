//
//  Patient.m
//  MedicalSystem
//
//  Created by mac on 15/3/24.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "Patient.h"

@implementation Patient
+(Class)getBindingModelClass
{
	return [Patient class];
}
@synthesize ID;
@synthesize name;
@synthesize age;
@synthesize sex;
@synthesize phone;
@synthesize address;
@synthesize familyName;
@synthesize familPhone;
@synthesize illnessName;

@end
