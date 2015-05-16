//
//  PatientStateViewController.m
//  MedicalSystem
//
//  Created by mac on 15/3/23.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "PatientStateViewController.h"
#import "MedicalPrefix.pch"
#import "NavigationBar.h"
#import "DetailStateViewController.h"
#import "State.h"

@interface PatientStateViewController ()

@end

@implementation PatientStateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	dbState = [[StateDB alloc]init];
	self.patientStates = [dbState getAllData];
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
	
	//	//创建一个右边按钮
	//	UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"登录"
	//																	style:UIBarButtonItemStylePlain
	//																   target:self
	//																   action:@selector(clickButtonBackToRegister)];
	//	rightButton.tintColor = [UIColor blackColor];
	
	//设置导航栏内容
	[navigationItem setTitle:@"病情管理"];
	
	//把导航栏集合添加入导航栏中，设置动画关闭
	[navBar pushNavigationItem:navigationItem animated:NO];
	
	//把左右两个按钮添加入导航栏集合中
	//[navigationItem setRightBarButtonItem:rightButton];
	
	//把导航栏添加到视图中
	[self.view addSubview:navBar];

}

- (void)initWithUI{
	self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 70, ScreenWidth, ScreenHeight - 60)];
	self.bgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg6.png"]];
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
	return [self.patientStates count];
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
	
	State *patientState = [self.patientStates objectAtIndex:indexPath.row];
	

	UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 80, 20)];
	nameLabel.font = [UIFont boldSystemFontOfSize:13];
	nameLabel.text = patientState.patientName;
	[cell.contentView addSubview:nameLabel];
	
	UILabel *illnessLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 30, ScreenWidth - 10, 20)];
	illnessLabel.font = [UIFont boldSystemFontOfSize:11];
	illnessLabel.text = patientState.illState;
	[cell.contentView addSubview:illnessLabel];
	
	cell.backgroundColor = [UIColor clearColor];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	if (cell.accessoryType == UITableViewCellAccessoryDisclosureIndicator) {
		DetailStateViewController *detailState = [[DetailStateViewController alloc]init];
		detailState.aState = [self.patientStates objectAtIndex:indexPath.row];
		[self presentViewController:detailState animated:NO completion:NULL];
	}
}


@end
