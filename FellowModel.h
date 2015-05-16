//
//  FellowModel.h
//  MedicalSystem
//
//  Created by mac on 15/4/1.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FellowModel : NSObject{
	int ID;
	NSString *name;
	NSString *post;
	NSString *school;
}
@property (nonatomic) int ID;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *post;
@property (strong, nonatomic) NSString *school;
@end
