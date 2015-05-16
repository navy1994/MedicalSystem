//
//  AboutViewController.h
//  MedicalSystem
//
//  Created by mac on 15/4/1.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController

@property (strong, nonatomic) UIView *bgView;
- (void) initWithNavigation;
- (void) initWithUI;

- (void) clickBtnToBack;
@end
