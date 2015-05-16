//
//  MainViewController.m
//  fitment
//
//  Created by mac on 15/3/19.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "MainViewController.h"
#import "TotalPatientViewController.h"
#import "TotalCostViewController.h"
#import "PatientOutViewController.h"
#import "PatientMedViewController.h"
#import "PatientStateViewController.h"
#import "SystemViewController.h"


@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
	}
	return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
	[self initViewController];
}

#pragma mark - UI
- (void) initViewController{
	totalPatientCtrl = [[TotalPatientViewController alloc]init];
	TotalCostViewController *costCtrl = [[TotalCostViewController alloc]init];
	PatientMedViewController *medCtrl = [[PatientMedViewController alloc]init];
	PatientStateViewController *stateCtrl = [[PatientStateViewController alloc]init];
	PatientOutViewController *outCtrl = [[PatientOutViewController alloc]init];
	NSArray *controllers = @[costCtrl,medCtrl,totalPatientCtrl,stateCtrl,outCtrl];
	tabBarcontroller = [[UITabBarController alloc]init];
	
	tabBarcontroller.viewControllers = controllers;
	
	//[newPatientCtrl.tabBarItem setTitle:@"主页"];
	totalPatientCtrl.tabBarItem.image = [[UIImage imageNamed:@"tabbar_mainbtn.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	totalPatientCtrl.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_mainbtn.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	
	[costCtrl.tabBarItem setTitle:@"费用管理"];
//	costCtrl.tabBarItem.image = [[UIImage imageNamed:@"tabbar_message_center.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//	costCtrl.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_message_center_highlighted.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	
	[medCtrl.tabBarItem setTitle:@"药物管理"];
//	medCtrl.tabBarItem.image = [[UIImage imageNamed:@"tabbar_discover.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//	medCtrl.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_discover_highlighted.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	
	[stateCtrl.tabBarItem setTitle:@"病情管理"];
//	stateCtrl.tabBarItem.image = [[UIImage imageNamed:@"tabbar_discover.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//	stateCtrl.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_discover_highlighted.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	
	[outCtrl.tabBarItem setTitle:@"出院管理"];
//	outCtrl.tabBarItem.image = [[UIImage imageNamed:@"tabbar_profile.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//	outCtrl.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_profile_highlighted.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	
	self.viewControllers = tabBarcontroller.viewControllers;

	
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
