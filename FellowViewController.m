//
//  FellowViewController.m
//  MedicalSystem
//
//  Created by mac on 15/4/1.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "FellowViewController.h"
#import "NavigationBar.h"
#import "MedicalPrefix.pch"
#import "SystemViewController.h"

@interface FellowViewController ()

@end

@implementation FellowViewController
@synthesize fellow1;
@synthesize fellow2;



- (void)viewDidLoad {
	[super viewDidLoad];
	dbFellow = [[FellowDB alloc]init];
	self.fellows = [dbFellow getAllData];
	[self initWithNavigation];
	[self initWithUI];
	
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
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
	UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationbar_back_highlighted.png"]
																   style:UIBarButtonItemStyleDone
																  target:self
																  action:@selector(clickBtnToBack)];
	
	leftButton.tintColor = [UIColor blackColor];
	
	//设置导航栏内容
	[navigationItem setTitle:@"我的同事"];
	
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
	self.bgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg4.png"]];
	[self.view addSubview:self.bgView];
	
	//定义搜索栏
	self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 5, ScreenWidth, 30)];
	self.searchBar.barTintColor = [UIColor whiteColor];
	self.searchBar.alpha = 0.3;
	[self.bgView addSubview:self.searchBar];
	
	//定义列表
	aTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 35, ScreenWidth, ScreenHeight - 105) style:UITableViewStyleGrouped];
	aTableView.backgroundColor = [UIColor clearColor];
	[aTableView setEditing:YES];
	aTableView.dataSource = self;
	aTableView.delegate = self;
	
	[self.bgView addSubview:aTableView];
	
}

#pragma mark -- tableView dataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [self.fellows count];
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
	
	FellowModel *fellow = [self.fellows objectAtIndex:indexPath.row];
	UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 10, 150, 30)];
	nameLabel.font = [UIFont boldSystemFontOfSize:13];
	nameLabel.text = fellow.name;
	[nameLabel setTextColor:[UIColor whiteColor]];
	[cell.contentView addSubview:nameLabel];
	UILabel *postLabel = [[UILabel alloc]initWithFrame:CGRectMake(155, 10, 60, 30)];
	postLabel.font = [UIFont boldSystemFontOfSize:13];
	postLabel.text = [NSString stringWithFormat:@"职位:%@",fellow.post];
	[postLabel setTextColor:[UIColor whiteColor]];
	[cell.contentView addSubview:postLabel];
	UILabel *schoolLabel = [[UILabel alloc]initWithFrame:CGRectMake(215, 10, 60, 30)];
	schoolLabel.font = [UIFont boldSystemFontOfSize:13];
	schoolLabel.text = [NSString stringWithFormat:@"毕业院校:%@",fellow.school];
	[schoolLabel setTextColor:[UIColor whiteColor]];
	[cell.contentView addSubview:schoolLabel];
	UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[aButton setTitle:@"edit" forState:UIControlStateNormal];
	aButton.frame = CGRectMake(ScreenWidth - 80, 0,40, 50);
	aButton.backgroundColor = [UIColor colorWithRed:38.0/255.0 green:140.0/255.0 blue:233.0/255.0 alpha:1.0];
	[aButton setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
	[aButton addTarget:self action:@selector(clickBtnToEdit:) forControlEvents:UIControlEventTouchUpInside];
	[aButton setTag:indexPath.row];
	[cell.contentView addSubview:aButton];
	cell.backgroundColor = [UIColor clearColor];
	return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		FellowModel *fellow = [self.fellows objectAtIndex:indexPath.row];
		[dbFellow deleteDataOfName:fellow.name];
		[self.fellows removeObjectAtIndex:indexPath.row];
		[aTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
	}
}

#pragma mark -- search on tableView

#pragma mark -- initMedModel
- (void)addMedModel{
	fellow1 = [[FellowModel alloc]init];
	nametf = _addMedView.tfArray[0];
	postTf = _addMedView.tfArray[1];
	schoolTf = _addMedView.tfArray[2];
	fellow1.name = nametf.text;
	fellow1.post = postTf.text;
	fellow1.school = schoolTf.text;
}

//按钮触发事件
#pragma mark -- clickBtton
- (void)clickBtnToAdd{
	[self initModelView];
	flag = 1;
	UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth - 160)/2, 10, 70, 30)];
	title.text = @"添加新同事";
	[_addMedView addSubview:title];
}


- (void)clickBtnToOK{
	if (flag == 1) {
		[self addMedModel];
		if (![nametf.text isEqual: @""] && ![postTf.text isEqual:@""] && ![schoolTf.text isEqual: @""]) {
			[dbFellow insertToDB:fellow1];
			[self.fellows addObject:fellow1];
			[aTableView reloadData];
			[_addMedView removeFromSuperview];
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"添加同事成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
			[alert show];
		}else{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请填满信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
			[alert show];
		}
	}else if(flag == 2){
		[self addMedModel];
		fellow2 = [[FellowModel alloc]init];
		fellow2 = [self.fellows objectAtIndex:self.selectTag];
		_aName = fellow2.name;
		NSString *aString;
		if (![nametf.text isEqual: @""] && ![postTf.text isEqual:@""] && ![schoolTf.text isEqual: @""]) {
			if ([dbFellow updateDataOfName:_aName andMedModel:fellow1]) {
				aString = @"修改同事信息成功";
			}else{
				aString = @"修改同事信息失败";
			}
			[aTableView reloadData];
			[_addMedView removeFromSuperview];
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:aString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
			[alert show];
		}else{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请填满信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
			[alert show];
		}
		
	}else{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"无此操作" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
		[alert show];
		
	}
	
}

- (void)clickBtnToEdit:(id)sender{
	flag = 2;
	self.selectTag = [sender tag];
	NSLog(@"tag=%ld",self.selectTag);
	[self initModelView];
	UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth - 160)/2, 10, 70, 30)];
	title.text = @"修改同事信息";
	[_addMedView addSubview:title];
	
}

- (void)clickBtnToCancel{
	[_addMedView removeFromSuperview];
}

- (void)clickBtnToBack{
	SystemViewController *systemCtl = [[SystemViewController alloc]init];
	[self presentViewController:systemCtl animated:NO completion:NULL];
}

#pragma mark -- initModelView
- (void)initModelView{
	NSArray *array = @[@"姓名",@"职位",@"毕业院校"];
	_addMedView = [[MedModelView alloc]init:array];
	_addMedView.frame = CGRectMake(45, 100, ScreenWidth - 90, 250);
	_okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[_okBtn setTitle:@"确定" forState:UIControlStateNormal];
	_okBtn.backgroundColor = [UIColor colorWithRed:38.0/255.0 green:140.0/255.0 blue:233.0/255.0 alpha:1.0];
	_okBtn.frame = CGRectMake((ScreenWidth - 105)/2+10, 200,(ScreenWidth - 105)/2, 30);
	[_okBtn addTarget:self action:@selector(clickBtnToOK) forControlEvents:UIControlEventTouchUpInside];
	[_addMedView addSubview:_okBtn];
	_cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
	_cancelBtn.backgroundColor = [UIColor colorWithRed:38.0/255.0 green:140.0/255.0 blue:233.0/255.0 alpha:1.0];
	_cancelBtn.frame = CGRectMake(5, 200, (ScreenWidth - 105)/2, 30);
	[_cancelBtn addTarget:self action:@selector(clickBtnToCancel) forControlEvents:UIControlEventTouchUpInside];
	[_addMedView addSubview:_cancelBtn];
	[self.bgView addSubview:_addMedView];
}
@end
