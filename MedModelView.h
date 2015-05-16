//
//  MedModelView.h
//  MedicalSystem
//
//  Created by mac on 15/3/26.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MedModelView : UIView


@property(nonatomic,retain) NSMutableArray *tfArray;

- (id) init:(NSArray*)array;
- (UITextField *)createTextField:(NSString*)placeholder withFrame:(CGRect)frame;

@end
