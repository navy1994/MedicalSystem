//
//  RegisterViewController.h
//  MedicalSystem
//
//  Created by mac on 15/4/1.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MedTextFiled.h"
#import "UserDB.h"
#import "UserModel.h"
#import "SystemViewController.h"

@interface RegisterViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
	UITableView *aTableView;
	UserDB *dbUser;
}

//登录控件
@property (strong, nonatomic) MedTextFiled *nameTextField;
@property (strong, nonatomic) MedTextFiled *pswTextField;
@property (strong, nonatomic) UIImageView *aImageView;;
@property (strong, nonatomic) UIButton *loginBtn;

@property (strong, nonatomic) NSArray *left;
@property (strong, nonatomic) NSArray *right;
@property (strong, nonatomic) NSMutableArray* users;
@property (strong, nonatomic) UserModel *user;
@property (strong, nonatomic) UILabel *wrongLabel;

- (void)initWithNavigation;
- (void)initWithUI;

- (void)clickBtnToBack;
- (void)clickBtnToLogIn;
- (void)clickBtnToRegister;
@end
