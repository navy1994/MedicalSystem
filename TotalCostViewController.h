//
//  TotalCostViewController.h
//  MedicalSystem
//
//  Created by mac on 15/3/27.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MedModelView.h"
#import "PatientCostDB.h"
#import "MedCostDB.h"

@interface TotalCostViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
	UITableView *aTableView;
	PatientCostDB *dbPatientCost;
	MedCostDB *dbMedCost;
	UITextField *patientNametf,*cashTf;
}

@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) MedModelView *addMedView;
@property (strong, nonatomic) UIButton *okBtn;
@property (strong, nonatomic) UIButton *cancelBtn;
@property (strong, nonatomic) UIButton *editBtn;

@property (strong, nonatomic) NSMutableArray *patientCosts;
@property (strong, nonatomic) NSMutableArray *medCosts;

- (void) clickBtnToAdd;
- (void) clickBtnToOK;
- (void) clickBtnToCancel;

- (void) initWithNavigation;
- (void) initWithUI;
- (void) initModelView;

@end
