//
//  PatientOutViewController.m
//  MedicalSystem
//
//  Created by mac on 15/3/23.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "PatientOutViewController.h"
#import "MedicalPrefix.pch"
#import "NavigationBar.h"
#import "Patient.h"
#import "PatientDB.h"
#import "OutViewController.h"

@interface PatientOutViewController ()

@end

@implementation PatientOutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	dbPatient = [[PatientDB alloc]init];
	self.patients = [dbPatient getAllData];
	
	dbState = [[StateDB alloc]init];
	self.states = [dbState getAllData];

	[self initWithNavigation];
	[self initWithUI];

}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void) initWithNavigation{
	NavigationBar *navBar = [[NavigationBar alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 50)];
	
	//创建一个导航栏集合
	UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:nil];
	
		//设置导航栏内容
	[navigationItem setTitle:@"出院管理"];
	
	//把导航栏集合添加入导航栏中，设置动画关闭
	[navBar pushNavigationItem:navigationItem animated:NO];
	
	//把导航栏添加到视图中
	[self.view addSubview:navBar];
}

- (void) initWithUI{
	self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 70, ScreenWidth, ScreenHeight - 60)];
	self.bgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg3.png"]];
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
	return [self.states count];
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
	
	State *state = [self.states objectAtIndex:indexPath.row];
	
	UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 10, 80, 30)];
	nameLabel.font = [UIFont boldSystemFontOfSize:15];
	nameLabel.text = state.patientName;
	[cell.contentView addSubview:nameLabel];
	
	UILabel *outLabel = [[UILabel alloc]initWithFrame:CGRectMake(200, 15, 100, 20)];
	outLabel.font = [UIFont boldSystemFontOfSize:13];
	outLabel.text = [NSString stringWithFormat:@"能否出院:%@",state.patientOut];
	outLabel.textColor = [UIColor redColor];
	[cell.contentView addSubview:outLabel];
	
	cell.backgroundColor = [UIColor clearColor];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	if (cell.accessoryType == UITableViewCellAccessoryDisclosureIndicator) {
		OutViewController *detailOut = [[OutViewController alloc]init];
		detailOut.aState = [self.states objectAtIndex:indexPath.row];
		[self presentViewController:detailOut animated:NO completion:NULL];
	}
}


@end
