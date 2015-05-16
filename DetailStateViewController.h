//
//  DetailStateViewController.h
//  MedicalSystem
//
//  Created by mac on 15/3/27.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StateDB.h"
#import "PatientStateViewController.h"
#import "State.h"
#import "QRadioButton.h"
#import "MedTextFiled.h"

@interface DetailStateViewController : UIViewController<QRadioButtonDelegate>{
	StateDB *dbState;
	PatientStateViewController *patientStateVC;
}


@property (strong, nonatomic) UIView *bgView;
@property(strong, nonatomic) QRadioButton *radio1;
@property(strong, nonatomic) QRadioButton *radio2;

@property (strong, nonatomic) NSMutableArray *states;
@property (strong, nonatomic) NSString *getSexString;
@property (strong, nonatomic) State *aState;
@property (strong, nonatomic) MedTextFiled *state;

- (void) initWithNavigation;
- (void) initWithUI;
- (void) clickBtnToBack;
- (void) clickBtnToSave;
@end
