//
//  TotalPatientViewController.h
//  MedicalSystem
//
//  Created by mac on 15/3/24.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PatientDB.h"
#import "Patient.h"

@interface TotalPatientViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>{
	UITableView *aTableView;
	PatientDB *dbPatient;
	NSArray *searchData;
	BOOL isSearch;
	Patient *patient;
}

@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) UISearchBar *searchBar;

@property (strong, nonatomic) NSMutableArray *patients;
@property (nonatomic, retain) NSIndexPath *selectIndex;

- (void) clickBtnToAdd;
- (void) clickBtnToDelete:(UIButton*)sender;
- (void) clickBtnToRegister;
- (void) filterBySubstring:(NSString*)subStr;

- (void) initWithNavigation;
- (void) initWithUI;

@end
