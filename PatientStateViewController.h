//
//  PatientStateViewController.h
//  MedicalSystem
//
//  Created by mac on 15/3/23.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StateDB.h"

@interface PatientStateViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
	UITableView *aTableView;
	StateDB *dbState;
}

@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) UISearchBar *searchBar;

@property (strong, nonatomic) NSMutableArray *patientStates;

- (void) initWithNavigation;
- (void) initWithUI;
@end
