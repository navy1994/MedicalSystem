//
//  MedCostDB.m
//  MedicalSystem
//
//  Created by mac on 15/3/27.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "MedCostDB.h"
#import "MedCostModel.h"

@implementation MedCostDB
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

- (NSMutableArray*)getAllData:(NSString*)patientName{
	NSMutableArray *medCosts = [[NSMutableArray alloc]init];
	FMResultSet *set = [db executeQuery:@"select * from medcostTable where patientname=?",patientName];
	while ([set next]) {
		MedCostModel *medCost = [[MedCostModel alloc]init];
		medCost.Id = [set intForColumn:@"Id"];
		medCost.medDate = [set stringForColumn:@"meddata"];
		medCost.medName = [set stringForColumn:@"name"];
		medCost.sum = [set stringForColumn:@"sum"];
		medCost.jiage = [set stringForColumn:@"jiage"];
		medCost.patientName = [set stringForColumn:@"patientname"];
		
		
		[medCosts addObject:medCost];
	}
	return medCosts;
}

- (void)insertMedData:(MedCostModel*)medCost{
	if ([db executeUpdate:@"insert into medcostTable(meddata,name,sum,jiage,patientname) values(?,?,?,?,?)",medCost.medDate,medCost.medName,medCost.sum,medCost.jiage,medCost.patientName]) {
		NSLog(@"插入数据成功");
	}
}

- (BOOL) deleteDataOfName:(NSString *)name
{
	BOOL isOk;
	if ([db executeUpdate:@"delete from medcostTable where patientname=?",name]) {
		NSLog(@"病号药品消费删除数据成功");
		isOk = YES;
	}else{
	    NSLog(@"病号药品消费删除数据失败");
		isOk = NO;
	}
	return isOk;
}

- (void) updateDataOfName:(NSString *)name{
	if ([db executeUpdate:@"updata medcostTable set name = ? where name = ?",name,@"123"]) {
		NSLog(@"更新数据成功");
	}
}

@end
