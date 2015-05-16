//
//  SystemViewController.m
//  MedicalSystem
//
//  Created by mac on 15/3/23.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "SystemViewController.h"
#import "FellowViewController.h"
#import "AboutViewController.h"
#import "MedicalPrefix.pch"
#import "MainViewController.h"
#import "RegisterViewController.h"

@interface SystemViewController ()

@end

@implementation SystemViewController



- (void)viewDidLoad {
    [super viewDidLoad];
	dbUser = [[UserDB alloc]init];
	[self initWithUI];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initWithUI{
	self.view.backgroundColor = [UIColor whiteColor];
	self.aView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, ScreenHeight-20)];
	self.aView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg7.png"]];
	[self.view addSubview:self.aView];
	
	self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	self.backBtn.frame = CGRectMake(ScreenWidth - 70, 20, 60, 30);
	[self.backBtn setTitle:@"Back" forState:UIControlStateNormal];
	[self.backBtn addTarget:self action:@selector(clickBtnToBack) forControlEvents:UIControlEventTouchUpInside];
	[self.aView addSubview:self.backBtn];
	
	self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	self.loginBtn.frame = CGRectMake(10, 20, 60, 30);
	[self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
	[self.loginBtn addTarget:self action:@selector(clickBtnToLogin) forControlEvents:UIControlEventTouchUpInside];
	[self.aView addSubview:self.loginBtn];

	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if ([defaults stringForKey:@"userName"] != nil) {
		self.aString = [defaults stringForKey:@"userName"];
		if ([self.aString isEqualToString:@"未登录"]) {
			self.aImage = [UIImage imageNamed:@"weidenglu.png"];
		}
		self.users = [dbUser getAllData];
		for (int i=0; i<[self.users count]; i++) {
			self.sysUser = [self.users objectAtIndex:i];
			if ([self.sysUser.userName isEqual:self.aString]) {
				if (self.sysUser.image == nil) {
					self.aImage = [UIImage imageNamed:@"weidenglu.png"];
					isOk = YES;
				}else{
					self.aImage = self.sysUser.image;
					isOk = NO;
				}
			}
		}
	}


	self.aLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2 - 25, 115, 100, 20)];
	self.aLabel2.text = self.aString;
	self.aLabel2.textColor = [UIColor blackColor];
	self.aLabel2.backgroundColor = [UIColor clearColor];
	self.aLabel2.font = [UIFont boldSystemFontOfSize:15];
	[self.aView addSubview:self.aLabel2];
	
	self.imageView = [[UIImageView alloc]initWithImage:self.aImage];
	self.imageView.frame = CGRectMake(ScreenWidth/2 - 25, 55, 50, 50);
	[self.imageView.layer setCornerRadius:25];
	self.imageView.layer.masksToBounds = YES;
	[self.aView addSubview:self.imageView];
	
	if (isOk) {
		self.chageImage = [UIButton buttonWithType:UIButtonTypeCustom];
		self.chageImage.frame = CGRectMake(ScreenWidth/2 - 25, 55, 50, 50);
		self.chageImage.backgroundColor = [UIColor clearColor];
		[self.chageImage addTarget:self action:@selector(clickBtnToaddImage) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:self.chageImage];
	}
	
	aTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 135, ScreenWidth, ScreenHeight - 50) style:UITableViewStyleGrouped];
	aTableView.dataSource = self;
	aTableView.delegate = self;
	aTableView.backgroundColor = [UIColor clearColor];
	[self.aView addSubview:aTableView];
	
	
	self.titleArray = @[@"个人", @"医疗人员", @"系统"];
	self.aArray1 = @[@"修改头像", @"修改密码"];
	self.aArray2 = @[@"我的同事"];
	self.aArray3 = @[@"关于",@"退出当前账号"];

}

#pragma mark -- tableView dataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
	return 3;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	switch (section) {
		case 0:
			return [self.aArray1 count];
			break;
		case 1:
			return [self.aArray2 count];
			break;
		case 2:
			return [self.aArray3 count];
			break;
			
		default:
			return 0;
			break;
	}
}

#pragma mark -- tableView delegate

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	switch (section) {
		case 0:
			return [self.titleArray objectAtIndex:section];
			break;
		case 1:
			return [self.titleArray objectAtIndex:section];
			break;
		case 2:
			return [self.titleArray objectAtIndex:section];
			break;
		default:
			return NULL;
			break;
	}
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
	
	switch (indexPath.section) {
		case 0:
			cell.textLabel.text = [self.aArray1 objectAtIndex:indexPath.row];
			break;
		case 1:
			cell.textLabel.text = [self.aArray2 objectAtIndex:indexPath.row];
			break;
		case 2:
			cell.textLabel.text = [self.aArray3 objectAtIndex:indexPath.row];
			break;
		default:
			cell.textLabel.text = @"Unknown";
			break;
	}
	cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.backgroundColor = [UIColor clearColor];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
	if (cell.accessoryType == UITableViewCellAccessoryDisclosureIndicator) {
		if (indexPath.section == 0) {
			if (indexPath.row == 0) {//修改头像
				
			}else if (indexPath.row == 1){ //修改密码
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入要修改的密码！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
				alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
				self.changPsTf1 = [alert textFieldAtIndex:0];
				self.changPsTf1.placeholder = @"Password";
				[self.changPsTf1 setSecureTextEntry:YES];
				self.changPsTf2 = [alert textFieldAtIndex:1];
				[alert show];
			}
		}else if (indexPath.section == 1) {
			if (indexPath.row == 0) {
                FellowViewController *fellowCtrl = [[FellowViewController alloc]init];
				[self presentViewController:fellowCtrl animated:NO completion:NULL];
			}
		}else if(indexPath.section == 2){
			if (indexPath.row == 0) {  //关于
				AboutViewController *aboutCtrl = [[AboutViewController alloc]init];
				[self presentViewController:aboutCtrl animated:NO completion:NULL];
			}else if(indexPath.row == 1){  //退出当前账号
				NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
				[defaults setObject:@"未登录" forKey:@"userName"];
				[defaults synchronize];
				[self reloadLogoutView];
			}
		}
		
	}
}

#pragma mark --- UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if (buttonIndex == alertView.firstOtherButtonIndex) {
		if ([self.changPsTf1.text isEqual:self.changPsTf2.text]) {
			isOk = NO;
		}else{
			isOk = YES;
		}
		if (isOk) {
			UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(170, 0, 60, 20)];
			label.text = @"两次密码不同";
			label.font = [UIFont boldSystemFontOfSize:9];
			label.textColor = [UIColor redColor];
			[self.changPsTf1 addSubview:label];

		}

	}
}

- (void)willPresentAlertView:(UIAlertView *)alertView{
}

- (void)reloadLogoutView{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	self.aString = [defaults stringForKey:@"userName"];
	self.aImage = [UIImage imageNamed:@"weidenglu.png"];
	[self initWithUI];
	if ([self.aLabel2.text isEqual:@"未登录"]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您已经成功注销" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
		[alert show];
	}

}

- (void)clickBtnToLogin{
	if ([self.aLabel2.text isEqual:@"未登录"]) {
		RegisterViewController *registerCtrl = [[RegisterViewController alloc]init];
		[self presentViewController:registerCtrl animated:NO completion:NULL];
	}else{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您已经登录，不能重复登录哦！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
		[alert show];
	}
}

- (void)clickBtnToBack{
	MainViewController *mainCtl = [[MainViewController alloc]init];
	mainCtl.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_background.png"];
	[mainCtl setSelectedIndex:2];
	[self presentViewController:mainCtl animated:NO completion:NULL];
}

- (void)clickBtnToaddImage{
	NSLog(@"加图片");
}

@end
