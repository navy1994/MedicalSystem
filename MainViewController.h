//
//  MainViewController.h
//  fitment
//
//  Created by mac on 15/3/19.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TotalPatientViewController;
@interface MainViewController : UITabBarController<UINavigationControllerDelegate>{
	UITabBarController *tabBarcontroller;
	TotalPatientViewController *totalPatientCtrl;
}

- (void) initViewController;

@end
