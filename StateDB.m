//
//  StateDB.m
//  MedicalSystem
//
//  Created by mac on 15/3/27.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "StateDB.h"
#import "State.h"

@implementation StateDB
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
	NSMutableArray *outs = [[NSMutableArray alloc]init];
	FMResultSet *set = [db executeQuery:@"select * from patientStateTable"];
	while ([set next]) {
		State *state = [[State alloc]init];
		state.Id = [set intForColumn:@"Id"];
		state.patientName = [set stringForColumn:@"name"];
		state.illState = [set stringForColumn:@"illState"];
		state.patientOut = [set stringForColumn:@"out"];
		
		[outs addObject:state];
	}
	return outs;
}

- (void)insertName:(NSString *)name illState:(NSString *)state Out:(NSString *)patientOut{
	if ([db executeUpdate:@"insert into patientStateTable(name,illstate,out) values(?,?,?)",name,state,patientOut]) {
		NSLog(@"插入数据成功");
	}
}

- (BOOL) deleteDataOfName:(NSString *)name
{
    BOOL isOk;
	if ([db executeUpdate:@"delete from patientStateTable where name=?",name]) {
		NSLog(@"病情删除数据成功");
		isOk = YES;
	}else{
	    NSLog(@"病情删除数据失败");
		isOk = NO;
	}
	return isOk;
}

- (BOOL) updateDataOfName:(NSString *)name setState:(State *)state{
	BOOL isOK;
	if ([db executeUpdate:@"updata patientStateTable set illstate=?,out=? where name=?",state.patientName,state.illState,state.patientOut,name]) {
		isOK = YES;
		NSLog(@"更新数据成功");
	}else{
		isOK = NO;
	}
	return isOK;
}

@end
