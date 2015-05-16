//
//  UserModel.h
//  MedicalSystem
//
//  Created by mac on 15/4/1.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UserModel : NSObject{
	int ID;
	NSString *userName;
	NSString *password;
	NSString *safeQuestion;
	NSString *safeResult;
	UIImage *image;
}

@property (nonatomic) int ID;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *safeQuestion;
@property (strong, nonatomic) NSString *safeResult;
@property (strong, nonatomic) UIImage *image;

@end
