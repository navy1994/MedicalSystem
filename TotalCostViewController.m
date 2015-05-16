//
//  TotalCostViewController.m
//  MedicalSystem
//
//  Created by mac on 15/3/27.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "TotalCostViewController.h"
#import "NavigationBar.h"
#import "MedicalPrefix.pch"
#import "MedModelView.h"
#import "PatientCostViewController.h"
#import "PatientCostModel.h"
#import "MedCostModel.h"

@interface TotalCostViewController ()

@end

@implementation TotalCostViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	dbPatientCost = [[PatientCostDB alloc]init];
	self.patientCosts = [dbPatientCost getAllData];
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
	
	//创建一个右边按钮
	UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd 																         target:self
																				 action:@selector(clickBtnToAdd)];
	rightButton.tintColor = [UIColor blackColor];
	
	//设置导航栏内容
	[navigationItem setTitle:@"费用管理"];
	
	//把导航栏集合添加入导航栏中，设置动画关闭
	[navBar pushNavigationItem:navigationItem animated:NO];
	
	//把左右两个按钮添加入导航栏集合中
	[navigationItem setRightBarButtonItem:rightButton];
	
	//把导航栏添加到视图中
	[self.view addSubview:navBar];
	
}
//初始化控件
- (void)initWithUI{
	self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 70, ScreenWidth, ScreenHeight - 60)];
	self.bgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg5.png"]];
	[self.view addSubview:self.bgView];
	//定义搜索栏
	self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 75, ScreenWidth, 30)];
	self.searchBar.barTintColor = [UIColor whiteColor];
	self.searchBar.alpha = 0.3;
	[self.view addSubview:self.searchBar];
	//定义列表
	aTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 105, ScreenWidth, ScreenHeight - 105) style:UITableViewStyleGrouped];
	aTableView.dataSource = self;
	aTableView.delegate = self;
	aTableView.backgroundColor = [UIColor clearColor];
	[self.view addSubview:aTableView];
	
}

#pragma mark -- tableView dataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [self.patientCosts count];
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
	PatientCostModel *patientCost = [self.patientCosts objectAtIndex:indexPath.row];
	UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 150, 30)];
	nameLabel.font = [UIFont boldSystemFontOfSize:13];
	nameLabel.text = patientCost.patientName;
	[cell.contentView addSubview:nameLabel];
	UILabel *cashLabel = [[UILabel alloc]initWithFrame:CGRectMake(155, 10, 80, 30)];
	cashLabel.font = [UIFont boldSystemFontOfSize:13];
	cashLabel.text = [NSString stringWithFormat:@"押金:%@",patientCost.cash];
	[cell.contentView addSubview:cashLabel];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.backgroundColor = [UIColor clearColor];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
	if (cell.accessoryType == UITableViewCellAccessoryDisclosureIndicator) {
	
		dbMedCost = [[MedCostDB alloc]init];
		PatientCostModel *patientCost = [self.patientCosts objectAtIndex:indexPath.row];
		self.medCosts = [dbMedCost getAllData:patientCost.patientName];
		
		PatientCostViewController *PatientCostVC = [[PatientCostViewController alloc]init];
		PatientCostVC.medCosts = self.medCosts;
		PatientCostVC.paCost = patientCost;
		[self presentViewController:PatientCostVC animated:NO completion:NULL];
	}
}

//按钮触发事件
#pragma mark -- clickBtton
- (void)clickBtnToAdd{
	[self initModelView];
	UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth - 160)/2, 10, 70, 30)];
	title.text = @"交押金";
	[_addMedView addSubview:title];
}


- (void)clickBtnToOK{
	patientNametf = _addMedView.tfArray[0];
	cashTf = _addMedView.tfArray[1];
	PatientCostModel *patientcost = [[PatientCostModel alloc]init];
	patientcost.patientName = patientNametf.text;
	patientcost.cash = cashTf.text;
	if (![patientNametf.text isEqual: @""] && ![cashTf.text isEqual:@""]) {
		[dbPatientCost insertName:patientNametf.text cash:cashTf.text];
		[self.patientCosts addObject:patientcost];
		[aTableView reloadData];
		[_addMedView removeFromSuperview];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"添加药品成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
		[alert show];
	}else{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请填满信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
		[alert show];
	}
}


- (void)clickBtnToCancel{
	[_addMedView removeFromSuperview];
}

#pragma mark -- initModelView
- (void)initModelView{
	NSArray *array = @[@"病号姓名",@"押金"];
	_addMedView = [[MedModelView alloc]init:array];
	_addMedView.frame = CGRectMake(45, 100, ScreenWidth - 90, 200);
	_okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[_okBtn setTitle:@"确定" forState:UIControlStateNormal];
	_okBtn.backgroundColor = [UIColor colorWithRed:38.0/255.0 green:140.0/255.0 blue:233.0/255.0 alpha:1.0];
	_okBtn.frame = CGRectMake((ScreenWidth - 105)/2+10, 150,(ScreenWidth - 105)/2, 30);
	[_okBtn addTarget:self action:@selector(clickBtnToOK) forControlEvents:UIControlEventTouchUpInside];
	[_addMedView addSubview:_okBtn];
	_cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
	_cancelBtn.backgroundColor = [UIColor colorWithRed:38.0/255.0 green:140.0/255.0 blue:233.0/255.0 alpha:1.0];
	_cancelBtn.frame = CGRectMake(5, 150, (ScreenWidth - 105)/2, 30);
	[_cancelBtn addTarget:self action:@selector(clickBtnToCancel) forControlEvents:UIControlEventTouchUpInside];
	[_addMedView addSubview:_cancelBtn];
	[self.view addSubview:_addMedView];
}

@end
