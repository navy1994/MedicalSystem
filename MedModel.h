//
//  MedModel.h
//  MedicalSystem
//
//  Created by mac on 15/3/25.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MedModel : NSObject{
	int  Id;
	NSString *medName;
	NSString *sum;
	NSString *price;

}

@property(nonatomic)int  Id;
@property(copy,nonatomic)NSString *medName;
@property(copy,nonatomic)NSString *sum;
@property(copy,nonatomic)NSString *price;

@end
