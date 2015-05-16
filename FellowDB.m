//
//  FellowDB.m
//  MedicalSystem
//
//  Created by mac on 15/4/1.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "FellowDB.h"

@implementation FellowDB
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
	NSMutableArray *fellows = [[NSMutableArray alloc]init];
	FMResultSet *set = [db executeQuery:@"select * from fellowTable"];
	while ([set next]) {
		FellowModel *fellow = [[FellowModel alloc]init];
		fellow.ID = [set intForColumn:@"ID"];
		fellow.name = [set stringForColumn:@"name"];
		fellow.post = [set stringForColumn:@"post"];
		fellow.school = [set stringForColumn:@"school"];
		[fellows addObject:fellow];
	}
	return fellows;
}

- (void)insertToDB:(FellowModel*)fellow{
	if ([db executeUpdate:@"insert into fellowTable(name,post,school) values(?,?,?)",fellow.name,fellow.post,fellow.school]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"添加同事成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
		[alert show];
		NSLog(@"插入数据成功");
		
	}
}

- (BOOL) deleteDataOfName:(NSString *)name
{
	BOOL isOk;
	if ([db executeUpdate:@"delete from fellowTable where name=?",name]) {
		NSLog(@"病号删除数据成功");
		isOk = YES;
	}else{
		isOk = NO;
	}
	return isOk;
}

- (BOOL) updateDataOfName:(NSString *)name andMedModel:(FellowModel*)fellow{
	bool isOK;
	if ([db executeUpdate:@"updata fellowTable set name=?,post=?,school=? where name=?",fellow.name,fellow.post,fellow.school,name]) {
		isOK = YES;
		NSLog(@"更新数据成功");
	}
	else{
		NSLog(@"更新数据失败");
		isOK = NO;
	}
	return isOK;
}

- (FellowModel*)searchPatientOfName:(NSString *)name{
	FellowModel *fellow = [[FellowModel alloc]init];
	FMResultSet *set = [db executeQuery:@"select * from fellowTable where name=?",name];
	while ([set next]) {
		fellow.ID = [set intForColumn:@"ID"];
		fellow.name = [set stringForColumn:@"name"];
		fellow.post = [set stringForColumn:@"post"];
		fellow.school = [set stringForColumn:@"school"];
	}
	return fellow;
}
@end
