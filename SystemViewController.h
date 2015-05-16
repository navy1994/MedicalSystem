//
//  SystemViewController.h
//  MedicalSystem
//
//  Created by mac on 15/3/23.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"
#import "UserDB.h"

@interface SystemViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>{
	UITableView *aTableView;
	UserDB *dbUser;
	BOOL isOk;
}

@property (strong, nonatomic) UIView *aView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIButton *logoutButton;
@property (strong, nonatomic) UIButton *backBtn;
@property (strong, nonatomic) UIButton *loginBtn;
@property (strong, nonatomic) UIButton *chageImage;
@property (strong, nonatomic) UILabel *aLabel2;
@property (strong, nonatomic) UIImage *aImage;
@property (strong, nonatomic) NSString *aString;

@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) NSArray *aArray1;
@property (strong, nonatomic) NSArray *aArray2;
@property (strong, nonatomic) NSArray *aArray3;
@property (strong, nonatomic) UserModel *sysUser;
@property (strong, nonatomic) NSMutableArray* users;

@property (strong, nonatomic) UITextField *changPsTf1;
@property (strong, nonatomic) UITextField *changPsTf2;

- (void)initWithUI;
- (void)clickBtnToBack;
- (void)clickBtnToLogin;
- (void)reloadLogoutView;
- (void)clickBtnToaddImage;

@end
