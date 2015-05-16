//
//  FellowViewController.h
//  MedicalSystem
//
//  Created by mac on 15/4/1.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FellowDB.h"
#import "MedModelView.h"
#import "FellowModel.h"

@interface FellowViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
	UITableView *aTableView;
	FellowDB *dbFellow;
	int flag;
	UITextField *nametf,*postTf,*schoolTf;

}
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) MedModelView *addMedView;
@property (strong, nonatomic) UIButton *okBtn;
@property (strong, nonatomic) UIButton *cancelBtn;
@property (strong, nonatomic) UIButton *editBtn;

@property (nonatomic) NSInteger selectTag;
@property (strong, nonatomic) NSMutableArray *fellows;
@property (strong ,nonatomic) NSArray *searchResult;

@property(strong, nonatomic) FellowModel *fellow1;
@property(strong, nonatomic) FellowModel *fellow2;
@property(strong, nonatomic) NSString *aName;

- (void) clickBtnToAdd;
- (void) clickBtnToOK;
- (void) clickBtnToCancel;
- (void) clickBtnToEdit:(id)sender;
- (void) clickBtnToBack;

- (void) initWithNavigation;
- (void) initWithUI;
- (void) initModelView;
- (void) addMedModel;

@end
