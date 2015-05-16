//
//  MedModelView.m
//  MedicalSystem
//
//  Created by mac on 15/3/26.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "MedModelView.h"
#import "MedicalPrefix.pch"

@implementation MedModelView

- (id) init:(NSArray*)array{
	self = [super init];
	if (self != nil) {
		_tfArray = [[NSMutableArray alloc]init];
		self.backgroundColor = [UIColor colorWithRed:38.0/255.0 green:140.0/255.0 blue:233.0/255.0 alpha:1.0];
		
		for (int i = 0; i < [array count]; i++) {
			UITextField *tf = [self createTextField:[array objectAtIndex:i] withFrame:CGRectMake(22, 55+45*i, ScreenWidth/3+50, 36)];
			[_tfArray addObject:tf];
			[self addSubview:tf];
		}
	}
	return self;
}

//- (void)layoutSubviews{
//	[super layoutSubviews];     // 当override父类的方法时，要注意一下是否需要调用父类的该方法
//	
////	for (UIView* view in self.subviews) {
////		// 搜索AlertView底部的按钮，然后将其位置下移
////		// IOS5以前按钮类是UIButton, IOS5里该按钮类是UIThreePartButton
////		if ([view isKindOfClass:[UIButton class]] ||
////			[view isKindOfClass:NSClassFromString(@"UIThreePartButton")]) {
////			CGRect btnBounds = view.frame;
////			btnBounds.origin.y = self.medPriceTf.frame.origin.y + self.medPriceTf.frame.size.height + 7;
////			view.frame = btnBounds;
////		}
////	}
////	
////	// 定义AlertView的大小
////	CGRect bounds = self.frame;
////	bounds.size.height = 260;
////	self.frame = bounds;
//	self.frame = CGRectMake(0, 100, 200, 200);
//}

- (UITextField*)createTextField:(NSString *)placeholder withFrame:(CGRect)frame{
	UITextField* field = [[UITextField alloc] initWithFrame:frame];
	field.placeholder = placeholder;
	//field.secureTextEntry = YES;
	field.backgroundColor = [UIColor whiteColor];
	field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	
	return field;
}
@end
