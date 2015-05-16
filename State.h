//
//  State.h
//  MedicalSystem
//
//  Created by mac on 15/3/27.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface State : NSObject{
	int Id;
	NSString *patientName;
	NSString *illState;
	NSString *patientOut;
}

@property (nonatomic) int Id;
@property (strong, nonatomic) NSString* patientName;
@property (strong, nonatomic) NSString* illState;
@property (strong, nonatomic) NSString* patientOut;

@end
