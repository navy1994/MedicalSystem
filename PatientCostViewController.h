//
//  PatientCostViewController.h
//  MedicalSystem
//
//  Created by mac on 15/3/23.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MedCostDB.h"
#import "PatientCostDB.h"
#import "TotalCostViewController.h"
#import "MedCostModel.h"
#import "PatientCostModel.h"
#import "MedModelView.h"
#import "MedCostModel.h"
#import "MedCostDB.h"
#import "MedDB.h"

@interface PatientCostViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
	UITableView *aTableView;
	UITextField *dataTf,*medNametf,*medSumTf;
	MedCostDB *dbMedCost;
	MedDB *dbMed;
}

@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) UIView *aView;
@property (nonatomic) float total;

@property (strong, nonatomic) NSMutableArray *medCosts;
@property (strong, nonatomic) PatientCostModel *paCost;
@property(strong, nonatomic) MedCostModel *med1;
@property(strong, nonatomic) MedCostModel *med2;
@property (nonatomic) NSInteger row;
@property(strong, nonatomic) NSArray *insert;


@property(strong, nonatomic) UILabel *medSumLb;
@property(strong, nonatomic) UILabel *medPricesLb;
@property(strong, nonatomic) UILabel *medTotalPricesLb;
@property (strong, nonatomic) MedModelView *addMedView;
@property (strong, nonatomic) UIButton *okBtn;
@property (strong, nonatomic) UIButton *cancelBtn;

- (void) clickBtnToBack;
- (void) initWithNavigation;
- (void) initWithUI;
- (void) initConsume;

- (void) clickBtnToAdd;
- (void) clickBtnToOK;
- (void) clickBtnToCancel;
- (void) initModelView;
- (void) addMedModel;

@end
