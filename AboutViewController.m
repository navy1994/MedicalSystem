//
//  AboutViewController.m
//  MedicalSystem
//
//  Created by mac on 15/4/1.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "AboutViewController.h"
#import "NavigationBar.h"
#import "MedicalPrefix.pch"
#import "SystemViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
	[navigationItem setTitle:@"关于"];
	
	//把导航栏集合添加入导航栏中，设置动画关闭
	[navBar pushNavigationItem:navigationItem animated:NO];
	
	//把左右两个按钮添加入导航栏集合中
	[navigationItem setLeftBarButtonItem:leftButton];
	
	//把导航栏添加到视图中
	[self.view addSubview:navBar];
	
}

- (void)initWithUI{
	self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 70, ScreenWidth, ScreenHeight - 60)];
	self.bgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg6.png"]];
	[self.view addSubview:self.bgView];
	
	UITextView *aTextView = [[UITextView alloc]initWithFrame:CGRectMake(5, 90, ScreenWidth-10, 300)];
	aTextView.text = @"本系统作为医务人员管理病员的系统，本系统可以添加新病员，处理药品信息，管理病员费用，并对病员病情的变化进行记录，待病员康复之后，对病员进行出院处理。";
	aTextView.font = [UIFont boldSystemFontOfSize:15];
	aTextView.backgroundColor = [UIColor clearColor];
	[self.view addSubview:aTextView];

}

- (void)clickBtnToBack
{
	SystemViewController *systemCtl = [[SystemViewController alloc]init];
	[self presentViewController:systemCtl animated:NO completion:NULL];
}


@end
