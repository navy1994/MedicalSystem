//
//  NewPatientViewController.m
//  MedicalSystem
//
//  Created by mac on 15/3/23.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "NewPatientViewController.h"
#import "MainViewController.h"
#import "NavigationBar.h"
#import "MedicalPrefix.pch"

@interface NewPatientViewController ()

@end

@implementation NewPatientViewController

- (void)viewDidLoad {
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	[super viewDidLoad];
	dbPatient = [[PatientDB alloc]init];
	dbPatientCost = [[PatientCostDB alloc]init];
	dbState = [[StateDB alloc]init];
	[self initWithNavigation];
	[self initWithUI];
	
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

//初始化导航栏
- (void)initWithNavigation{
	NavigationBar *navBar = [[NavigationBar alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 50)];
	
	//创建一个导航栏集合
	UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:nil];
	
	//创建一个左边按钮
	UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationbar_back_highlighted.png"]
																   style:UIBarButtonItemStyleDone
																  target:self
																  action:@selector(clickBtnToBack)];
	
	leftButton.tintColor = [UIColor blackColor];
	//设置导航栏内容
	if (self.flag == 2) {
		[navigationItem setTitle:@"病号详情"];
	}else{
		[navigationItem setTitle:@"添加病号"];
	}
	
    //把导航栏集合添加入导航栏中，设置动画关闭
	[navBar pushNavigationItem:navigationItem animated:NO];
	
	//把左右两个按钮添加入导航栏集合中
	[navigationItem setLeftBarButtonItem:leftButton];
	
	//把导航栏添加到视图中
	[self.view addSubview:navBar];

}
//初始化控件
- (void)initWithUI{
	self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 70, ScreenWidth, ScreenHeight - 60)];
	self.bgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg6.png"]];
	[self.view addSubview:self.bgView];

		//定义列表
	aTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 75, ScreenWidth, ScreenHeight - 220) style:UITableViewStyleGrouped];
	aTableView.dataSource = self;
	aTableView.delegate = self;
	aTableView.backgroundColor = [UIColor clearColor];
	[self.view addSubview:aTableView];
	
	self.titleArray = @[@"病号信息", @"家属信息", @"病因"];
	self.aArray1 = @[@"姓名", @"年龄",@"地址"];
	self.aArray2 = @[@"姓名",@"电话号码"];
	self.aArray3 = @[@""];
	
	
	//定义确定按钮
	self.okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.okButton.frame = CGRectMake(0, ScreenHeight - 60, ScreenWidth, 60);
	[self.okButton setTitle:@"确定" forState:UIControlStateNormal];
	[self.okButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	self.okButton.backgroundColor = [UIColor colorWithRed:41.0/250.0 green:140.0/250.0 blue:232.0/250.0 alpha:1];
	[self.okButton addTarget:self action:@selector(clickBtnToOK) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:self.okButton];
	
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	if (indexPath.section == 2) {
		return 150;
	}
	else
	return 30;
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
		cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
	}
	
	switch (indexPath.section) {
		case 0:
			cell.textLabel.text = [self.aArray1 objectAtIndex:indexPath.row];
			cell.textLabel.font = [UIFont boldSystemFontOfSize:13];
			
			switch (indexPath.row)
			{
				case 0:
					self.patientNameTf = [[MedTextFiled alloc] initWithFrame:CGRectMake(50, 0, ScreenWidth/2-60, 30) andFontOfSize:13];
					self.patientNameTf.delegate = self;
					[cell.contentView addSubview:self.patientNameTf];
					self.patientSexLb = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2-20, 0, 60, 30)];
					self.patientSexLb.font = [UIFont boldSystemFontOfSize:13];
					self.patientSexLb.text = @"性别";
					[cell.contentView addSubview:self.patientSexLb];
					_radio1 = [[QRadioButton alloc] initWithDelegate:self groupId:@"groupId1"];
					_radio1.frame = CGRectMake(ScreenWidth/2+50, 0, 40, 30);
					[_radio1 setTitle:@"男" forState:UIControlStateNormal];
					[_radio1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
					[_radio1.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
					[cell.contentView addSubview:_radio1];
					_radio2 = [[QRadioButton alloc] initWithDelegate:self groupId:@"groupId1"];
					_radio2.frame = CGRectMake(ScreenWidth/2+100, 0, 40, 30);
					[_radio2 setTitle:@"女" forState:UIControlStateNormal];
					[_radio2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
					[_radio2.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
					[cell.contentView addSubview:_radio2];
					break;
				case 1:
					self.patientAgeTf = [[MedTextFiled alloc] initWithFrame:CGRectMake(50, 0, ScreenWidth/2-60, 30) andFontOfSize:13];
					self.patientAgeTf.delegate = self;
					[cell.contentView addSubview:self.patientAgeTf];
					self.patientPhoneLb = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2-20, 0, 60, 30)];
					self.patientPhoneLb.font = [UIFont boldSystemFontOfSize:13];
					self.patientPhoneLb.text = @"电话号码";
					[cell.contentView addSubview:self.patientPhoneLb];
					self.patientPhoneTf = [[MedTextFiled alloc]initWithFrame:CGRectMake(ScreenWidth/2+50, 0, ScreenWidth/2-10, 30) andFontOfSize:13];
					self.patientPhoneTf.delegate = self;
					[cell.contentView addSubview:self.patientPhoneTf];
					break;
				case 2:
					self.patientAddressTf = [[MedTextFiled alloc] initWithFrame:CGRectMake(50, 0, ScreenWidth-50, 30) andFontOfSize:13];
					self.patientAddressTf.delegate = self;
					[cell.contentView addSubview:self.patientAddressTf];
					break;
				default:
					break;
			}
			
			break;
		case 1:
			cell.textLabel.text = [self.aArray2 objectAtIndex:indexPath.row];
			cell.textLabel.font = [UIFont boldSystemFontOfSize:13];
			switch (indexPath.row) {
				case 0:
					self.familyNameTf = [[MedTextFiled alloc] initWithFrame:CGRectMake(50, 0, ScreenWidth-50, 30) andFontOfSize:13];
					self.familyNameTf.delegate = self;
					[cell.contentView addSubview:self.familyNameTf];
					break;
				case 1:
					self.familyPhoneTf = [[MedTextFiled alloc] initWithFrame:CGRectMake(70, 0, ScreenWidth-70, 30) andFontOfSize:13];
					self.familyPhoneTf.delegate = self;
					[cell.contentView addSubview:self.familyPhoneTf];
					break;
				default:
					break;
			}
			break;
		case 2:
			cell.textLabel.text = [self.aArray3 objectAtIndex:indexPath.row];
			cell.textLabel.font = [UIFont boldSystemFontOfSize:13];
			self.illnessNameTf = [[MedTextFiled alloc] initWithFrame:CGRectMake(5, 5, ScreenWidth-10, 140) andFontOfSize:13];
			self.illnessNameTf.delegate = self;
			[cell.contentView addSubview:self.illnessNameTf];
			break;
		default:
			cell.textLabel.text = @"Unknown";
			break;
	}
	if (self.flag == 2) {
		_patientNameTf.text = _aPtient.name;
		if ([_aPtient.sex isEqual:@"男"]) {
			[_radio1 setChecked:YES];
		}else{
			[_radio2 setChecked:YES];
		}
		_patientAgeTf.text = _aPtient.age;
		_patientPhoneTf.text = _aPtient.phone;
		_patientAddressTf.text = _aPtient.address;
		_familyNameTf.text = _aPtient.familyName;
		_familyPhoneTf.text = _aPtient.familPhone;
		_illnessNameTf.text = _aPtient.illnessName;
		UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, ScreenHeight - 90, ScreenWidth-20, 30)];
		label.font = [UIFont boldSystemFontOfSize:13];
		label.text = @"温馨提示:需要的话可以先编辑再按“确定”保存哦O(∩_∩)O";
		[self.view addSubview:label];
	}
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	cell.backgroundColor = [UIColor clearColor];
	return cell;
}

#pragma mark -- textFiledDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	if (_patientNameTf==textField || _patientAgeTf==textField || _patientAddressTf==textField|| _patientPhoneTf==textField || _familyNameTf==textField ||_familyPhoneTf==textField || _illnessNameTf==textField) {
		[_patientNameTf resignFirstResponder];
		[_patientAgeTf resignFirstResponder];
		[_patientAddressTf resignFirstResponder];
		[_patientPhoneTf resignFirstResponder];
		[_familyNameTf resignFirstResponder];
		[_familyPhoneTf resignFirstResponder];
		[_illnessNameTf resignFirstResponder];
	}
	return YES;
}



#pragma mark - QRadioButtonDelegate
- (void)didSelectedRadioButton:(QRadioButton *)radio groupId:(NSString *)groupId {
	NSLog(@"did selected radio:%@ groupId:%@", radio.titleLabel.text, groupId);
	self.getSexString = radio.titleLabel.text;
}

//按钮触发事件
#pragma mark -- clickBtton
- (void)clickBtnToBack{
	MainViewController *mainCtl = [[MainViewController alloc]init];
	mainCtl.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_background.png"];
	[mainCtl setSelectedIndex:2];
	[self presentViewController:mainCtl animated:NO completion:NULL];
}

- (void)clickBtnToOK{
		Patient *patient = [[Patient alloc]init];
		patient.name = _patientNameTf.text;
		patient.sex = self.getSexString;
		patient.age = _patientAgeTf.text;
		patient.phone = _patientPhoneTf.text;
		patient.address = _patientAddressTf.text;
		patient.familyName = _familyNameTf.text;
		patient.familPhone = _familyPhoneTf.text;
		patient.illnessName = _illnessNameTf.text;
	if (self.flag == 1) {
		[dbPatient insertToDB:patient];
		[dbPatientCost insertName:patient.name cash:nil];
		[dbState insertName:patient.name illState:nil Out:nil];
	}else if (self.flag == 2){
		[dbPatient updateDataOfName:self.aPtient.name andMedModel:patient];
	}
	
}

@end
