//
//  TotalPatientViewController.m
//  MedicalSystem
//
//  Created by mac on 15/3/24.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "TotalPatientViewController.h"
#import "NewPatientViewController.h"
#import "NavigationBar.h"
#import "MedicalPrefix.pch"
#import "MedButton.h"
#import "RegisterViewController.h"
#import "SystemViewController.h"


@interface TotalPatientViewController ()

@end

@implementation TotalPatientViewController

- (void)viewDidLoad {
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	[super viewDidLoad];
	isSearch = NO;
	dbPatient = [[PatientDB alloc]init];
	self.patients = [dbPatient getAllData];
	
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
	
	UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"设置"															                   style:UIBarButtonItemStyleDone
																  target:self
																  action:@selector(clickBtnToRegister)];
	
	leftButton.tintColor = [UIColor blackColor];
	
	//设置导航栏内容
	[navigationItem setTitle:@"病号单"];
	
	//把导航栏集合添加入导航栏中，设置动画关闭
	[navBar pushNavigationItem:navigationItem animated:NO];
	
	//把左右两个按钮添加入导航栏集合中
	[navigationItem setRightBarButtonItem:rightButton];
	[navigationItem setLeftBarButtonItem:leftButton];
	//把导航栏添加到视图中
	[self.view addSubview:navBar];
	
}
//初始化控件
- (void)initWithUI{
	self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 70, ScreenWidth, ScreenHeight - 60)];
	self.bgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1.png"]];
	[self.view addSubview:self.bgView];
	
	//定义列表
	aTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 75, ScreenWidth,ScreenHeight - 105) style:UITableViewStyleGrouped];
	aTableView.dataSource = self;
	aTableView.delegate = self;
	aTableView.backgroundColor = [UIColor clearColor];
	[self.view addSubview:aTableView];
	
	//定义搜索栏
	self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
	self.searchBar.barTintColor = [UIColor whiteColor];
	self.searchBar.placeholder = @"搜索";
	self.searchBar.alpha = 0.3;
	self.searchBar.delegate = self;
	aTableView.tableHeaderView = self.searchBar;
	//[self.view addSubview:self.searchBar];
	
}

#pragma mark -- tableView dataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	if (isSearch) {
		return searchData.count;
	}else{
		return [self.patients count];
	}
	
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
	if (isSearch) {
		patient = [searchData objectAtIndex:indexPath.row];
	}else{
		patient = [self.patients objectAtIndex:indexPath.row];
	}
	
	UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 60, 20)];
	nameLabel.font = [UIFont boldSystemFontOfSize:13];
	nameLabel.text = patient.name;
	[cell.contentView addSubview:nameLabel];
	
	UILabel *illnessLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 30, ScreenWidth - 10, 20)];
	illnessLabel.font = [UIFont boldSystemFontOfSize:11];
	illnessLabel.text = patient.illnessName;
	[cell.contentView addSubview:illnessLabel];
	
	UILabel *addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 5, ScreenWidth-80, 20)];
	addressLabel.font = [UIFont boldSystemFontOfSize:13];
	addressLabel.text = [NSString stringWithFormat:@"地址%@",patient.address];
	[cell.contentView addSubview:addressLabel];
	
	MedButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[aButton setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
	aButton.frame = CGRectMake(ScreenWidth - 80, 0,40, 50);
	[aButton addTarget:self action:@selector(clickBtnToDelete:) forControlEvents:UIControlEventTouchUpInside];
	[cell.contentView addSubview:aButton];
	
	cell.backgroundColor = [UIColor clearColor];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
	if (cell.accessoryType == UITableViewCellAccessoryDisclosureIndicator) {
		
		Patient *aPatient = [self.patients objectAtIndex:indexPath.row];
		NewPatientViewController *addPatient = [[NewPatientViewController alloc]init];
		addPatient.flag = 2;
		addPatient.aPtient = aPatient;
		[self presentViewController:addPatient animated:NO completion:NULL];
	}
}

#pragma mark -- searchBarDelegate
//- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
//	isSearch = NO;
//	[aTableView reloadData];
//}
//
//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
//	[self filterBySubstring:searchText];
//}
//
//- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar{
//	[self filterBySubstring:searchBar.text];
//	[searchBar resignFirstResponder];
//}
//
//- (void)filterBySubstring:(NSString *)subStr{
//	isSearch = YES;
//	NSPredicate* pred = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@",subStr];
//	searchData = [self.patients filteredArrayUsingPredicate:pred];
//	[aTableView reloadData];
//}

//按钮触发事件
#pragma mark -- clickBtton
- (void)clickBtnToAdd{
	NewPatientViewController *addPatient = [[NewPatientViewController alloc]init];
	addPatient.flag = 1;
	[self presentViewController:addPatient animated:NO completion:NULL];
}

- (void)clickBtnToDelete:(UIButton*)sender{
   UIView * v=[sender superview];
   UITableViewCell *cell=(UITableViewCell *)[v superview];//找到cell
	NSIndexPath *indexPath=[aTableView indexPathForCell:cell];//找到cell所在的行
   	Patient *aPatient = [self.patients objectAtIndex:indexPath.row];
	if ([dbPatient deleteDataOfName:aPatient.name]) {
		NSLog(@"删除病号成功");
	}
	[self.patients removeObjectAtIndex:indexPath.row];
	[aTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)clickBtnToRegister{
	SystemViewController *registerVC = [[SystemViewController alloc]init];
	[self presentViewController:registerVC animated:NO completion:NULL];
}

@end
