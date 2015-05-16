//
//  Patient.h
//  MedicalSystem
//
//  Created by mac on 15/3/24.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Patient : NSObject{
	int ID;
	NSString *name;
	NSString *age;
	NSString *sex;
	NSString *phone;
	NSString *address;
	NSString *familyName;
	NSString *familPhone;
	NSString *illnessName;
}

@property (nonatomic) int ID;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *age;
@property (strong,nonatomic) NSString *sex;
@property (strong,nonatomic) NSString *phone;
@property (strong,nonatomic) NSString *address;
@property (strong,nonatomic) NSString *familyName;
@property (strong,nonatomic) NSString *familPhone;
@property (strong,nonatomic) NSString *illnessName;

@end
