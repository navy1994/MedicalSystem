//
//  PatientMedViewController.h
//  MedicalSystem
//
//  Created by mac on 15/3/23.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MedModel.h"
#import "MedDB.h"
#import "MedModelView.h"

@interface PatientMedViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
	int flag;
	UITableView *aTableView;
	MedDB *dbMed;
	UITextField *medNametf,*medSumTf,*medPriceTf;
}


@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) MedModelView *addMedView;
@property (strong, nonatomic) UIButton *okBtn;
@property (strong, nonatomic) UIButton *cancelBtn;
@property (strong, nonatomic) UIButton *editBtn;

@property (nonatomic) NSInteger selectTag;
@property (strong, nonatomic) NSMutableArray *patientMeds;
@property (strong ,nonatomic) NSArray *searchResult;

@property(strong, nonatomic) MedModel *med1;
@property(strong, nonatomic) MedModel *med2;
@property(strong, nonatomic) NSString *aName;

- (void) clickBtnToAdd;
- (void) clickBtnToOK;
- (void) clickBtnToCancel;
- (void) clickBtnToEdit:(id)sender;

- (void) initWithNavigation;
- (void) initWithUI;
- (void) initModelView;
- (void) addMedModel;

@end
