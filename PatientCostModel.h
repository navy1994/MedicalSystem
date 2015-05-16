//
//  PatientCostModel.h
//  MedicalSystem
//
//  Created by mac on 15/3/27.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PatientCostModel : NSObject{
	int  Id;
	NSString *patientName;
	NSString *cash;
	NSString *xiaofei;
	NSString *yue;
}

@property(nonatomic)int  Id;
@property(copy,nonatomic)NSString *patientName;
@property(copy,nonatomic)NSString *cash;
@end
