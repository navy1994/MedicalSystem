//
//  OutViewController.h
//  MedicalSystem
//
//  Created by mac on 15/3/27.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PatientDB.h"
#import "PatientCostDB.h"
#import "MedCostDB.h"
#import "StateDB.h"
#import "State.h"
#import "PatientCostModel.H"

@interface OutViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
	UITableView *aTableView;
	PatientDB *dbPatient;
	StateDB *dbState;
	PatientCostDB *dbPatientCost;
	MedCostDB *dbMedCost;
}

@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) UILabel *patientNameLb;
@property (strong, nonatomic) UILabel *patientAgeLb;
@property (strong, nonatomic) UILabel *illnessLb;
@property (strong, nonatomic) UILabel *cashLb;
@property (strong, nonatomic) UILabel *xiaofeiLb;
@property (strong, nonatomic) UILabel *yueLb;

@property (strong, nonatomic) UIButton *outBtn;

@property (nonatomic) float total;
@property (strong, nonatomic) State *aState;
@property (strong, nonatomic) Patient *aPatient;
@property (strong, nonatomic) PatientCostModel *patientCost;
@property (strong, nonatomic) NSMutableArray *medCosts;

- (void) initWithNavigation;
- (void) initWithUI;
- (void) clickBtnToBack;
- (void) clickBtnToOut;

- (void) initConsume;

@end
