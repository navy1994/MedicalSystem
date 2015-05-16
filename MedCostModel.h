//
//  MedCostModel.h
//  MedicalSystem
//
//  Created by mac on 15/3/27.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MedCostModel : NSObject{
	int  Id;
	NSString *medDate;
	NSString *medName;
	NSString *sum;
	NSString *jiage;
	NSString *patientName;
}

@property(nonatomic)int  Id;
@property(copy,nonatomic)NSString *medDate;
@property(copy,nonatomic)NSString *medName;
@property(copy,nonatomic)NSString *sum;
@property(copy,nonatomic)NSString *jiage;
@property(copy,nonatomic)NSString *patientName;

@end
