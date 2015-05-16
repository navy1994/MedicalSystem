//
//  MedDB.m
//  MedicalSystem
//
//  Created by mac on 15/3/25.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "MedDB.h"
#import "MedModel.h"

@implementation MedDB
FMDatabase *db;

- (id) init{
	
	if ((self = [super init])) {
		[self initializeDatabase];
	}
	return self;
}

- (void) initializeDatabase{
	NSString *path = [[NSBundle mainBundle] pathForResource:@"MedicalSystem" ofType:@"sqlite"];
	
	//open the database
	db =[FMDatabase databaseWithPath:path];
	if ([db open]) {
		NSLog(@"open database success");
	}
	else{
		[self closeDatabase];
	}
}

- (void) closeDatabase
{
	[db close];
}

- (NSMutableArray*)getAllData{
	NSMutableArray *meds = [[NSMutableArray alloc]init];
	FMResultSet *set = [db executeQuery:@"select * from medTable"];
	while ([set next]) {
		MedModel *med = [[MedModel alloc]init];
		med.Id = [set intForColumn:@"Id"];
		med.medName = [set stringForColumn:@"medName"];
		med.sum = [set stringForColumn:@"sum"];
		med.price = [set stringForColumn:@"price"];
		[meds addObject:med];
	}
   return meds;
}

- (void)insertToDB:(MedModel*)med{
		if ([db executeUpdate:@"insert into medTable(medname,sum,price) values(?,?,?)",med.medName,med.sum,med.price]) {
			NSLog(@"插入数据成功");
		}
}

- (void) deleteDataOfName:(NSString *)name
{
	if ([db executeUpdate:@"delete from medTable where medname = ?",name]) {
		NSLog(@"删除数据成功");
	}
}

- (BOOL) updateDataOfName:(NSString *)name andMedModel:(MedModel *)med{
	bool isOK;
	if ([db executeUpdate:@"updata medTable set medname=?,sum=?,price=? where medname = ?",med.medName,med.sum,med.price,name]) {
		isOK = YES;
		NSLog(@"更新数据成功");
	}
	else{
		NSLog(@"更新数据失败");
		isOK = NO;
	}
	return isOK;
}

- (NSString*)searchPrice:(NSString *)medName{
	NSString *price;
	FMResultSet *set = [db executeQuery:@"select price from medTable where medname=?",medName];
	while ([set next]) {
		price = [set stringForColumn:@"price"];
	}
	return price;
}

@end
