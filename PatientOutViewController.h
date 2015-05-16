//
//  PatientOutViewController.h
//  MedicalSystem
//
//  Created by mac on 15/3/23.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PatientDB.h"
#import "StateDB.h"
#import "Patient.h"
#import "State.h"

@interface PatientOutViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
	UITableView *aTableView;
	PatientDB *dbPatient;
	StateDB *dbState;
}

@property (strong, nonatomic) UISearchBar *searchBar;

@property (strong, nonatomic) UIView *bgView;

@property (strong, nonatomic) NSMutableArray *patients;
@property (strong, nonatomic) NSMutableArray *states;


- (void) initWithNavigation;
- (void) initWithUI;

@end
