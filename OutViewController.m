//
//  OutViewController.m
//  MedicalSystem
//
//  Created by mac on 15/3/27.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "OutViewController.h"
#import "MedicalPrefix.pch"
#import "NavigationBar.h"
#import "MainViewController.h"

@interface OutViewController ()

@end

@implementation OutViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	dbPatient = [[PatientDB alloc]init];
	self.aPatient = [dbPatient searchPatientOfName:self.aState.patientName];
	dbMedCost = [[MedCostDB alloc]init];
	self.medCosts = [dbMedCost getAllData:self.aState.patientName];
	dbPatientCost = [[PatientCostDB alloc]init];
	self.patientCost = [dbPatientCost searchPatientCostOfName:self.aState.patientName];
	dbState = [[StateDB alloc]init];
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
	
	//创建一个右边按钮
	UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationbar_back_highlighted.png"]
																   style:UIBarButtonItemStyleDone
																  target:self
																  action:@selector(clickBtnToBack)];
	
	leftButton.tintColor = [UIColor blackColor];
	//设置导航栏内容
	[navigationItem setTitle:@"消费单"];
	
	//把导航栏集合添加入导航栏中，设置动画关闭
	[navBar pushNavigationItem:navigationItem animated:NO];
	
	//把左右两个按钮添加入导航栏集合中
	[navigationItem setLeftBarButtonItem:leftButton];
	
	//把导航栏添加到视图中
	[self.view addSubview:navBar];
}

- (void) initWithUI{
	self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 70, ScreenWidth, ScreenHeight - 60)];
	self.bgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1.png"]];
	[self.view addSubview:self.bgView];
	
	UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 130, ScreenWidth, ScreenHeight - 290)];
	view.backgroundColor = [UIColor blackColor];
	view.alpha = 0.1;
	[self.view addSubview:view];
	
	self.patientNameLb = [[UILabel alloc]initWithFrame:CGRectMake(5, 70, 100, 30)];
	self.patientNameLb.text = [NSString stringWithFormat:@"姓名:%@",self.aPatient.name];
	self.patientNameLb.font = [UIFont boldSystemFontOfSize:14];
	[self.view addSubview:self.patientNameLb];
	self.patientAgeLb = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth - 100, 70, 100, 30)];
	self.patientAgeLb.text = [NSString stringWithFormat:@"年龄:%@",self.aPatient.age];
	self.patientAgeLb.font = [UIFont boldSystemFontOfSize:14];
	[self.view addSubview:self.patientAgeLb];
	self.illnessLb = [[UILabel alloc]initWithFrame:CGRectMake(5, 100, ScreenWidth-5, 30)];
	self.illnessLb.text = [NSString stringWithFormat:@"住院病由:%@",self.aPatient.illnessName];
	self.illnessLb.font = [UIFont boldSystemFontOfSize:14];
	[self.view addSubview:self.illnessLb];
	
	aTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 130, ScreenWidth, ScreenHeight - 290) style:UITableViewStyleGrouped];
	aTableView.backgroundColor = [UIColor clearColor];
	aTableView.delegate = self;
	aTableView.dataSource = self;
	[self.view addSubview:aTableView];
	
	self.outBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	self.outBtn.frame = CGRectMake(0, ScreenHeight - 60, ScreenWidth, 60);
	[self.outBtn setTitle:@"确定出院" forState:UIControlStateNormal];
	self.outBtn.backgroundColor = [UIColor colorWithRed:41.0/250.0 green:140.0/250.0 blue:232.0/250.0 alpha:1];
	[self.outBtn addTarget:self action:@selector(clickBtnToOut) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:self.outBtn];
}

- (void)initConsume{
	self.cashLb = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-100, ScreenHeight - 160, 100, 30)];
	self.cashLb.text = [NSString stringWithFormat:@"押金:%@",self.patientCost.cash];
	NSLog(@"cash = %@",self.patientCost.cash);
	self.cashLb.textColor = [UIColor whiteColor];
	self.cashLb.font = [UIFont boldSystemFontOfSize:14];
	[self.view addSubview:self.cashLb];
	self.xiaofeiLb = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-100, ScreenHeight - 130, 100, 30)];
	self.xiaofeiLb.text = [NSString stringWithFormat:@"消费额:%f",self.total];
	self.xiaofeiLb.textColor = [UIColor whiteColor];
	self.xiaofeiLb.font = [UIFont boldSystemFontOfSize:14];
	[self.view addSubview:self.xiaofeiLb];
	self.yueLb = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth -100, ScreenHeight - 100, 100, 30)];
	self.yueLb.text = [NSString stringWithFormat:@"余额:%f",[self.patientCost.cash floatValue] - _total];
	self.yueLb.textColor = [UIColor whiteColor];
	self.yueLb.font = [UIFont boldSystemFontOfSize:14];
	[self.view addSubview:self.yueLb];

}


#pragma mark --- UITableViewDateSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [self.medCosts count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 40;
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	return @"用药时间\t\t药品名\t\t\t数量\t\t\t单价";
}

#pragma mark -- UITableViewDelegate
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *CellIndentifier = @"Cell";
	UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIndentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIndentifier];
	}
	MedCostModel *medCost = [self.medCosts objectAtIndex:indexPath.row];
	UILabel *dataLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, 70, 30)];
	dataLabel.font = [UIFont boldSystemFontOfSize:13];
	dataLabel.text = medCost.medDate;
	[cell.contentView addSubview:dataLabel];
	UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 5, 130, 30)];
	nameLabel.font = [UIFont boldSystemFontOfSize:13];
	nameLabel.text = medCost.medName;
	[cell.contentView addSubview:nameLabel];
	UILabel *sumLabel = [[UILabel alloc]initWithFrame:CGRectMake(220, 5, 80, 30)];
	sumLabel.font = [UIFont boldSystemFontOfSize:13];
	sumLabel.text = medCost.sum;
	[cell.contentView addSubview:sumLabel];
	UILabel *jiageLabel = [[UILabel alloc]initWithFrame:CGRectMake(300, 5, 80, 30)];
	jiageLabel.font = [UIFont boldSystemFontOfSize:13];
	jiageLabel.text = medCost.jiage;
	[cell.contentView addSubview:jiageLabel];
	_total += [medCost.sum floatValue]*[medCost.jiage floatValue];
	
	if (indexPath.row+1 == [self.medCosts count]) {
		[self initConsume];
	}
	
	cell.backgroundColor = [UIColor clearColor];
	return cell;
}

#pragma mark --- clickBtn
- (void)clickBtnToBack{
	MainViewController *mainCtl = [[MainViewController alloc]init];
	mainCtl.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_background.png"];
	[mainCtl setSelectedIndex:4];
	[self presentViewController:mainCtl animated:NO completion:NULL];
}

- (void)clickBtnToOut{
	if ([self.patientCost.cash floatValue] - _total < 0) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"您的支出已经超额\n您还需要另付%f",_total - [self.patientCost.cash floatValue]]  delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
		[alert show];
	}
	if ([dbPatient deleteDataOfName:self.aState.patientName] &&
		[dbPatientCost deleteDataOfName:self.aState.patientName] &&
		[dbState deleteDataOfName:self.aState.patientName] &&
		[dbMedCost deleteDataOfName:self.aState.patientName]){
	  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您已完成出院,祝您健康O(∩_∩)O哈哈~"  delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
	  [alert show];
	}
	MainViewController *mainCtl = [[MainViewController alloc]init];
	mainCtl.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_background.png"];
	[mainCtl setSelectedIndex:4];
	[self presentViewController:mainCtl animated:NO completion:NULL];
}

@end
