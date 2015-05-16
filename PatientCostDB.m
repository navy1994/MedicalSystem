//
//  PatientCostDB.m
//  MedicalSystem
//
//  Created by mac on 15/3/27.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "PatientCostDB.h"
#import "PatientCostModel.h"

@implementation PatientCostDB
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
	NSMutableArray *patientCosts = [[NSMutableArray alloc]init];
	FMResultSet *set = [db executeQuery:@"select * from patientcostTable"];
	while ([set next]) {
		PatientCostModel *patientCost = [[PatientCostModel alloc]init];
		patientCost.Id = [set intForColumn:@"Id"];
		patientCost.patientName = [set stringForColumn:@"name"];
		patientCost.cash = [set stringForColumn:@"cash"];
		[patientCosts addObject:patientCost];
	}
	return patientCosts;
}

- (void)insertName:(NSString *)name cash:(NSString *)cash{
	if ([db executeUpdate:@"insert into patientcostTable(name,cash) values(?,?)",name,cash]) {
		NSLog(@"插入数据成功");
	}
}

- (BOOL) deleteDataOfName:(NSString *)name
{
	BOOL isOk;
	if ([db executeUpdate:@"delete from patientcostTable where name = ?",name]) {
		NSLog(@"病号消费删除数据成功");
		isOk = YES;
	}else{
		isOk = NO;
	}
	return isOk;
}

- (void) updateDataOfName:(NSString *)name{
	if ([db executeUpdate:@"updata patientcostTable set name = ? where name = ?",name,@"123"]) {
		NSLog(@"更新数据成功");
	}
}

- (PatientCostModel*)searchPatientCostOfName:(NSString *)name{
	PatientCostModel *patientCost = [[PatientCostModel alloc]init];
	FMResultSet *set = [db executeQuery:@"select * from patientcostTable where name=?",name];
	while ([set next]) {
		patientCost.Id = [set intForColumn:@"Id"];
		patientCost.patientName = [set stringForColumn:@"name"];
		patientCost.cash = [set stringForColumn:@"cash"];
	}
	return patientCost;
}

@end
