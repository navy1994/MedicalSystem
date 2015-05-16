//
//  PatientCostViewController.m
//  MedicalSystem
//
//  Created by mac on 15/3/23.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "PatientCostViewController.h"
#import "NavigationBar.h"
#import "MedicalPrefix.pch"
#import "MainViewController.h"


@interface PatientCostViewController ()

@end

@implementation PatientCostViewController
@synthesize med1;
@synthesize med2;


- (void)viewDidLoad {
    [super viewDidLoad];
	dbMedCost = [[MedCostDB alloc]init];
	dbMed = [[MedDB alloc]init];
	NSLog(@"cash=%@",self.paCost.cash);
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
	
	//创建一个左边按钮
	UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationbar_back_highlighted.png"]
																   style:UIBarButtonItemStyleDone
																  target:self
																  action:@selector(clickBtnToBack)];
	
	leftButton.tintColor = [UIColor blackColor];
	//创建一个右边按钮
	UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd 																         target:self
																				 action:@selector(clickBtnToAdd)];
	rightButton.tintColor = [UIColor blackColor];

	
	//设置导航栏内容
	[navigationItem setTitle:@"消费明细"];
	
	//把导航栏集合添加入导航栏中，设置动画关闭
	[navBar pushNavigationItem:navigationItem animated:NO];
	
	//把左右两个按钮添加入导航栏集合中
	[navigationItem setLeftBarButtonItem:leftButton];
	[navigationItem setRightBarButtonItem:rightButton];
	//把导航栏添加到视图中
	[self.view addSubview:navBar];

}

- (void) initWithUI{
	self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 70, ScreenWidth, ScreenHeight - 60)];
	self.bgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg6.png"]];
	[self.view addSubview:self.bgView];
	UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 70, ScreenWidth, ScreenHeight - 160)];
	view.backgroundColor = [UIColor blackColor];
	view.alpha = 0.1;
	[self.view addSubview:view];
	//定义列表
	aTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 70, ScreenWidth, ScreenHeight - 160) style:UITableViewStyleGrouped];
	aTableView.backgroundColor = [UIColor clearColor];
	aTableView.dataSource = self;
	aTableView.delegate = self;
	[self.view addSubview:aTableView];
	if (![self.medCosts count]) {
		[self initConsume];
	}
}

- (void)initConsume{
	UILabel *cash = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-120, ScreenHeight - 90, 120, 30)];
	cash.text = [NSString stringWithFormat:@"押金:%@",self.paCost.cash];
	NSLog(@"cash=%@",self.paCost.cash);
	[self.view addSubview:cash];
	
	UILabel *xiaofei = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-120, ScreenHeight - 60, 120, 30)];
	xiaofei.text = [NSString stringWithFormat:@"消费额:%f",self.total];
	NSLog(@"xiaofei=%f",_total);
	[self.view addSubview:xiaofei];
	
	UILabel *yue = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth -120, ScreenHeight - 30, 120, 30)];
	yue.text = [NSString stringWithFormat:@"余额:%f",[self.paCost.cash floatValue] - _total];
	[self.view addSubview:yue];

}

#pragma mark -- tableView dataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	NSLog(@"count=%ld",self.medCosts.count);
	return [self.medCosts count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
return 40;
}

#pragma mark -- tableView delegate

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	return @"用药时间\t\t药品名\t\t\t数量\t\t\t单价";
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
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
	NSLog(@"sum=%@",medCost.sum);
	[cell.contentView addSubview:sumLabel];
	UILabel *jiageLabel = [[UILabel alloc]initWithFrame:CGRectMake(300, 5, 80, 30)];
	jiageLabel.font = [UIFont boldSystemFontOfSize:13];
	jiageLabel.text = medCost.jiage;
	[cell.contentView addSubview:jiageLabel];
	_total += [medCost.sum floatValue]*[medCost.jiage floatValue];
	NSLog(@"_total=%f",_total);
	
	if (indexPath.row+1 == [self.medCosts count]) {
		[self initConsume];
	}
	
	cell.backgroundColor = [UIColor clearColor];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	return cell;
}

#pragma mark -- initMedModel
- (void)addMedModel{
	med1 = [[MedCostModel alloc]init];
	med2 = [self.medCosts objectAtIndex:0];
	dataTf = _addMedView.tfArray[0];
	medNametf = _addMedView.tfArray[1];
	medSumTf = _addMedView.tfArray[2];
	med1.medDate = dataTf.text;
	med1.medName = medNametf.text;
	med1.sum = medSumTf.text;
	med1.jiage = [dbMed searchPrice:medNametf.text];
	med1.patientName = med2.patientName;
}

//按钮触发事件
#pragma mark -- clickBtton
- (void)clickBtnToAdd{
	[self initModelView];
	UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth - 140)/2, 10, 70, 30)];
	title.text = @"用药";
	[_addMedView addSubview:title];
}

- (void)clickBtnToBack{
	MainViewController *mainCtl = [[MainViewController alloc]init];
	mainCtl.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_background.png"];
	[mainCtl setSelectedIndex:0];
	[self presentViewController:mainCtl animated:NO completion:NULL];
}

#pragma mark -- initModelVie

- (void)clickBtnToOK{
		[self addMedModel];
		if (![dataTf.text isEqual:@""] && ![medNametf.text isEqual: @""] && ![medSumTf.text isEqual:@""]) {
			[dbMedCost insertMedData:med1];
			[self.medCosts addObject:med1];
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

- (void)initModelView{
	NSArray *array = @[@"用药时间",@"药品名称",@"数量"];
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
	[self.view addSubview:_addMedView];}



@end
