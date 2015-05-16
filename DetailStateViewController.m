//
//  DetailStateViewController.m
//  MedicalSystem
//
//  Created by mac on 15/3/27.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "DetailStateViewController.h"
#import "NavigationBar.h"
#import "MedicalPrefix.pch"
#import "MainViewController.h"
#import "State.h"

@interface DetailStateViewController ()

@end

@implementation DetailStateViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	dbState = [[StateDB alloc]init];
	self.states = [dbState getAllData];
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
	//设置导航栏内容
	[navigationItem setTitle:@"病情详情"];
	
	//把导航栏集合添加入导航栏中，设置动画关闭
	[navBar pushNavigationItem:navigationItem animated:NO];
	
	//把左右两个按钮添加入导航栏集合中
	[navigationItem setLeftBarButtonItem:leftButton];
	
	//把导航栏添加到视图中
	[self.view addSubview:navBar];

	
}

- (void)initWithUI{
	self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 70, ScreenWidth, ScreenHeight - 60)];
	self.bgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1.png"]];
	[self.view addSubview:self.bgView];
	UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(0, 70, 100, 527)];
	view4.backgroundColor = [UIColor greenColor];
	view4.alpha = 0.3;
	[self.view addSubview:view4];
	
	UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 70, ScreenWidth, 70)];
	view1.backgroundColor = [UIColor yellowColor];
	view1.alpha = 0.3;
	[self.view addSubview:view1];
	UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 140, ScreenWidth, 387)];
	view2.backgroundColor = [UIColor redColor];
	view2.alpha = 0.3;
	[self.view addSubview:view2];
	UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(0, 527, ScreenWidth, 70)];
	view3.backgroundColor = [UIColor orangeColor];
	view3.alpha = 0.3;
	[self.view addSubview:view3];
	UIView *view5 = [[UIView alloc]initWithFrame:CGRectMake(0, 597, ScreenWidth, 70)];
	view5.backgroundColor = [UIColor purpleColor];
	view5.alpha = 0.3;
	[self.view addSubview:view5];
	
	UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(20, 70, 200, 70)];
	name.text = [NSString stringWithFormat:@"姓名:\t\t%@",self.aState.patientName];
	name.backgroundColor = [UIColor clearColor];
	[self.view addSubview:name];
	
	UILabel *ill = [[UILabel alloc]initWithFrame:CGRectMake(20, 140+387/2, 60, 70)];
	ill.text = @"病情:";
	ill.backgroundColor = [UIColor clearColor];
	[self.view addSubview:ill];
	
	self.state = [[MedTextFiled alloc] initWithFrame:CGRectMake(100, 140, ScreenWidth - 100, 387) andFontOfSize:15];
	self.state.text = self.aState.illState;
	self.state.backgroundColor = [UIColor clearColor];
	[self.view addSubview:self.state];
	
	UILabel *outHos = [[UILabel alloc]initWithFrame:CGRectMake(20, 527, 80, 70)];
	outHos.text = @"能否出院:";
	outHos.backgroundColor = [UIColor clearColor];
	[self.view addSubview:outHos];
	
	_radio1 = [[QRadioButton alloc] initWithDelegate:self groupId:@"groupId1"];
	_radio1.frame = CGRectMake(130, 527, 40, 70);
	[_radio1 setTitle:@"是" forState:UIControlStateNormal];
	[_radio1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[self.view addSubview:_radio1];
	_radio2 = [[QRadioButton alloc] initWithDelegate:self groupId:@"groupId1"];
	_radio2.frame = CGRectMake(200, 527, 40, 70);
	[_radio2 setTitle:@"否" forState:UIControlStateNormal];
	[_radio2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[self.view addSubview:_radio2];
	if ([self.aState.patientOut isEqual: @"是"]) {
		[_radio1 setChecked:YES];
	}else{
		[_radio2 setChecked:YES];
	}
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = CGRectMake(0, 597, ScreenWidth, 70);
	[button setTitle:@"保存" forState:UIControlStateNormal];
	[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	button.backgroundColor = [UIColor clearColor];
	[button addTarget:self action:@selector(clickBtnToSave) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:button];

}

#pragma mark - QRadioButtonDelegate
- (void)didSelectedRadioButton:(QRadioButton *)radio groupId:(NSString *)groupId {
	NSLog(@"did selected radio:%@ groupId:%@", radio.titleLabel.text, groupId);
	self.getSexString = radio.titleLabel.text;
}

#pragma mark --- clickBtn
- (void)clickBtnToBack{
	MainViewController *mainCtl = [[MainViewController alloc]init];
	mainCtl.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_background.png"];
	[mainCtl setSelectedIndex:3];
	[self presentViewController:mainCtl animated:NO completion:NULL];
}

- (void)clickBtnToSave{
	[self.state setEnabled:NO];
	State *editState = [[State alloc]init];
	editState.illState = self.state.text;
	editState.patientOut = self.getSexString;
	if (![dbState updateDataOfName:self.aState.patientName setState:editState]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"修改病情成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
		[alert show];
	}else{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"修改病情失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
		[alert show];
	}
	MainViewController *mainCtl = [[MainViewController alloc]init];
	mainCtl.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_background.png"];
	[mainCtl setSelectedIndex:3];
	[self presentViewController:mainCtl animated:NO completion:NULL];

}

@end
