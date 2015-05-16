//
//  MedTextFiled.h
//  MedicalSystem
//
//  Created by mac on 15/3/31.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MedTextFiled : UITextField
- (id)initWithFrame:(CGRect)frame andFontOfSize:(CGFloat)fontSize;
- (id)initWithArray:(NSArray*)array andRow:(NSInteger)row;
@end
