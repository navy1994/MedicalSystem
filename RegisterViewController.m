//
//  RegisterViewController.m
//  MedicalSystem
//
//  Created by mac on 15/4/1.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "RegisterViewController.h"
#import "MainViewController.h"
#import "ZhuceViewController.h"
#import "NavigationBar.h"
#import "MedicalPrefix.pch"
#import "SystemViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	dbUser = [[UserDB alloc]init];
	[self initWithNavigation];
	[self initWithUI];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)initWithNavigation{
	NavigationBar *navBar = [[NavigationBar alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 50)];
	
	//创建一个导航栏集合
	UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:nil];
	
	//创建一个右边按钮
	UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationbar_back_highlighted.png"]
																   style:UIBarButtonItemStyleDone
																  target:self
																  action:@selector(clickBtnToBack)];
	
	leftButton.tintColor = [UIColor blackColor];
	UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"注册"															                    style:UIBarButtonItemStyleDone						                                           target:self
																   action:@selector(clickBtnToRegister)];
	rightButton.tintColor = [UIColor blackColor];	//设置导航栏内容
	[navigationItem setTitle:@"高校医疗管理"];
	
	//把导航栏集合添加入导航栏中，设置动画关闭
	[navBar pushNavigationItem:navigationItem animated:NO];
	
	//把左右两个按钮添加入导航栏集合中
	[navigationItem setLeftBarButtonItem:leftButton];
	[navigationItem setRightBarButtonItem:rightButton];
	//把导航栏添加到视图中
	[self.view addSubview:navBar];
	
}

- (void)initWithUI{
	self.aImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo1.png"]];
	self.aImageView.frame = CGRectMake(25, 150, 325, 260);
	[self.view addSubview:self.aImageView];
	//定义列表
	aTableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 465, ScreenWidth-30, 100) style:UITableViewStylePlain];
	aTableView.dataSource = self;
	aTableView.delegate = self;
	[self.view addSubview:aTableView];
	
	self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	self.loginBtn.frame = CGRectMake(15, 575, ScreenWidth - 30, 40);
	[self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
	self.loginBtn.backgroundColor = [UIColor colorWithRed:41.0/250.0 green:140.0/250.0 blue:232.0/250.0 alpha:1];
	[self.loginBtn addTarget:self action:@selector(clickBtnToLogIn) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:self.loginBtn];
	
	self.left = [NSArray arrayWithObjects:@"姓名",@"密码", nil];
	self.right = [NSArray arrayWithObjects:@"请输入用户名",@"请输入密码", nil];
	
}

#pragma mark -- tableView dataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	return 50;
}

#pragma mark -- tableView delegate
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
	}
	
		UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 8, 80, 30)];
		label.text = [self.left objectAtIndex:indexPath.row];
		label.backgroundColor = [UIColor clearColor];
		[cell.contentView addSubview:label];
		if (indexPath.row == 0 ){
			_nameTextField = [[MedTextFiled alloc]initWithArray:self.right andRow:indexPath.row];
			_nameTextField.delegate = self;
			[cell.contentView addSubview:_nameTextField];
		}else{
			_pswTextField = [[MedTextFiled alloc]initWithArray:self.right andRow:indexPath.row];
			_pswTextField.delegate = self;
			[_pswTextField setSecureTextEntry:YES];
			[cell.contentView addSubview:_pswTextField];
			//[self readUserInfoFromFile];//还要再读取一次，如果注销会发生什么？大家可以去试试
		}
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	return cell;
}
#pragma mark -- textfiledDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	if (_nameTextField==textField || _pswTextField==textField) {
		[_nameTextField resignFirstResponder];
		[_pswTextField resignFirstResponder];
	}
	return YES;
}

#pragma mark -- clickBtn
- (void)clickBtnToBack
{
	SystemViewController *systemCtl = [[SystemViewController alloc]init];
	[self presentViewController:systemCtl animated:NO completion:NULL];
}

- (void)clickBtnToRegister{
	ZhuceViewController *zhuceCtrl = [[ZhuceViewController alloc]init];
	[self presentViewController:zhuceCtrl animated:NO completion:NULL];
}

- (void)clickBtnToLogIn{
	self.wrongLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 430, 200, 30)];
	self.wrongLabel.textColor = [UIColor redColor];
	self.users = [dbUser getAllData];
	for (int i=0; i < [self.users count]; i++) {
		self.user = [self.users objectAtIndex:i];
		if ([self.user.userName isEqual:_nameTextField.text]) {
			if ([self.user.password isEqual:_pswTextField.text]) {
				self.wrongLabel.text = @"";
				NSLog(@"我进来了");
				NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
			    [defaults setObject:self.user.userName forKey:@"userName"];
				[defaults synchronize];
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"小主,您已登录成功O(∩_∩)O~" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
				[alert show];
				SystemViewController *sysCtrl = [[SystemViewController alloc]init];
			    [self presentViewController:sysCtrl animated:NO completion:NULL];
			}
		}else{
			self.wrongLabel.text = @"用户名或密码错误";
		}
		
	}
	[self.view addSubview:self.wrongLabel];
}

@end
