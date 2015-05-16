//
//  ZhuceViewController.h
//  MedicalSystem
//
//  Created by mac on 15/4/1.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MedTextFiled.h"
#import "UserDB.h"
#import "UserModel.h"

@interface ZhuceViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
	UITableView *aTableView;
	UserDB *dbUser;
}

//注册控件
@property (strong, nonatomic) UIButton *regBtn;
@property (strong, nonatomic) MedTextFiled *nameTextField;
@property (strong, nonatomic) MedTextFiled *pswTextField;
@property (strong, nonatomic) MedTextFiled *pswTextField1;
@property (strong, nonatomic) MedTextFiled *safeQuestionTf;
@property (strong, nonatomic) MedTextFiled *safeResultTf;
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) NSArray *left1;
@property (strong, nonatomic) NSArray *right1;
@property (strong, nonatomic) NSArray *left2;
@property (strong, nonatomic) NSArray *right2;


- (void) initWithNavigation;
- (void) initWithUI;

- (void) clickBtnToBack;
- (void) clickBtnToRegister;
@end
