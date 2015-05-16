//
//  PatientDB.m
//  MedicalSystem
//
//  Created by mac on 15/3/24.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "PatientDB.h"

@implementation PatientDB

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
	NSMutableArray *patients = [[NSMutableArray alloc]init];
	FMResultSet *set = [db executeQuery:@"select * from patientTable"];
	while ([set next]) {
		Patient *patient = [[Patient alloc]init];
		patient.ID = [set intForColumn:@"ID"];
		patient.name = [set stringForColumn:@"name"];
		patient.age = [set stringForColumn:@"age"];
		patient.sex = [set stringForColumn:@"sex"];
		patient.phone = [set stringForColumn:@"phone"];
		patient.address = [set stringForColumn:@"address"];
		patient.familyName = [set stringForColumn:@"familyname"];
		patient.familPhone = [set stringForColumn:@"familyphone"];
		patient.illnessName = [set stringForColumn:@"illnessname"];
		[patients addObject:patient];
	}
	return patients;
}

- (void)insertToDB:(Patient*)patient{
	if ([db executeUpdate:@"insert into patientTable(name,age,sex,phone,address,familyname,familyphone,illnessname) values(?,?,?,?,?,?,?,?)",patient.name,patient.age,patient.sex,patient.phone,patient.address,patient.familyName,patient.familPhone,patient.illnessName]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"添加病号成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
		[alert show];
		NSLog(@"插入数据成功");
		
	}
}

- (BOOL) deleteDataOfName:(NSString *)name
{
	BOOL isOk;
	if ([db executeUpdate:@"delete from patientTable where name=?",name]) {
		NSLog(@"病号删除数据成功");
		isOk = YES;
	}else{
		isOk = NO;
	}
	return isOk;
}

- (BOOL) updateDataOfName:(NSString *)name andMedModel:(Patient *)patient{
	bool isOK;
	if ([db executeUpdate:@"updata patientTable set name=?,age=?,sex=?,phone=?,address=?,familyname=?,familyphone=?,illnessname=? where name=?",patient.name,patient.age,patient.sex,patient.phone,patient.address,patient.familyName,patient.familPhone,patient.illnessName,name]) {
		isOK = YES;
		NSLog(@"更新数据成功");
	}
	else{
		NSLog(@"更新数据失败");
		isOK = NO;
	}
	return isOK;
}

- (Patient*)searchPatientOfName:(NSString *)name{
    Patient *patient = [[Patient alloc]init];
	FMResultSet *set = [db executeQuery:@"select * from patientTable where name=?",name];
	while ([set next]) {
		patient.ID = [set intForColumn:@"ID"];
		patient.name = [set stringForColumn:@"name"];
		patient.age = [set stringForColumn:@"age"];
		patient.sex = [set stringForColumn:@"sex"];
		patient.phone = [set stringForColumn:@"phone"];
		patient.address = [set stringForColumn:@"address"];
		patient.familyName = [set stringForColumn:@"familyname"];
		patient.familPhone = [set stringForColumn:@"familyphone"];
		patient.illnessName = [set stringForColumn:@"illnessname"];
	}
	return patient;
}
@end
