//
//  NewPatientViewController.h
//  MedicalSystem
//
//  Created by mac on 15/3/23.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRadioButton.h"
#import "Patient.h"
#import "MedTextFiled.h"
#import "PatientDB.h"
#import "PatientCostDB.h"
#import "StateDB.h"

@interface NewPatientViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,QRadioButtonDelegate,UITextFieldDelegate>{
	UITableView *aTableView;
	PatientDB *dbPatient;
	PatientCostDB *dbPatientCost;
	StateDB *dbState;
}

@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) UIButton *okButton;
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) NSArray *aArray1;
@property (strong, nonatomic) NSArray *aArray2;
@property (strong, nonatomic) NSArray *aArray3;
@property (strong, nonatomic) NSString *getSexString;
@property (strong, nonatomic) Patient *aPtient;
@property (nonatomic) int flag;

@property(strong, nonatomic) UILabel *patientSexLb;
@property(strong, nonatomic) UILabel *patientAddressLb;
@property(strong, nonatomic) UILabel *patientPhoneLb;
@property(strong, nonatomic) QRadioButton *radio1;
@property(strong, nonatomic) QRadioButton *radio2;

@property(strong, nonatomic) MedTextFiled *patientNameTf;
@property(strong, nonatomic) MedTextFiled *patientAgeTf;
@property(strong, nonatomic) MedTextFiled *patientAddressTf;
@property(strong, nonatomic) MedTextFiled *patientPhoneTf;
@property(strong, nonatomic) MedTextFiled *familyNameTf;
@property(strong, nonatomic) MedTextFiled *familyPhoneTf;
@property(strong, nonatomic) MedTextFiled *illnessNameTf;


- (void) clickBtnToBack;
- (void) clickBtnToOK;

- (void) initWithNavigation;
- (void) initWithUI;
@end
