//
//  UserDB.m
//  MedicalSystem
//
//  Created by mac on 15/4/1.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import "UserDB.h"

@implementation UserDB
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
		NSLog(@"我进入了用户表");
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
	NSMutableArray *users = [[NSMutableArray alloc]init];
	FMResultSet *set = [db executeQuery:@"select * from userTable"];
	while ([set next]) {
		UserModel *user = [[UserModel alloc]init];
		user.ID = [set intForColumn:@"ID"];
		user.userName = [set stringForColumn:@"username"];
		user.password = [set stringForColumn:@"password"];
		user.safeQuestion = [set stringForColumn:@"safequestion"];
		user.safeResult = [set stringForColumn:@"saferesult"];
		NSData *data = [set dataForColumn:@"image"];
		
		user.image = [UIImage imageWithData:data];
		[users addObject:user];
	}
	return users;
}

- (void)insertToDB:(UserModel*)user{
	NSData *data = UIImagePNGRepresentation(user.image);
	NSString *imgStr = [NSString stringWithFormat:@"%@",data];
	if ([db executeUpdate:@"insert into userTable(username,password,safequestion,saferesult,image) values(?,?,?,?,?)",user.userName,user.password,user.safeQuestion,user.safeResult,imgStr]) {
		NSLog(@"插入数据成功");
		
	}
}

- (BOOL) deleteDataOfName:(NSString *)name
{
	BOOL isOk;
	if ([db executeUpdate:@"delete from userTable where username=?",name]) {
		NSLog(@"用户删除数据成功");
		isOk = YES;
	}else{
		isOk = NO;
	}
	return isOk;
}

- (BOOL) updateDataOfName:(NSString *)name andSet:(NSString *)string1 andNew:(NSString *)string2{
	bool isOK;
	NSString *sql = [NSString stringWithFormat:@"updata userTable set %@=?, where username=?",string1];
	if ([db executeUpdate:sql,string2,name]) {
		isOK = YES;
		NSLog(@"更新数据成功");
	}
	else{
		NSLog(@"更新数据失败");
		isOK = NO;
	}
	return isOK;
}

- (UserModel*)searchUserOfName:(NSString *)name{
	NSLog(@"-----------name=%@",name);
	UserModel* user = [[UserModel alloc]init];
	FMResultSet *set = [db executeQuery:@"select * from userTable where username=?",name];
	NSLog(@"[set next]=%d",[set next]);
	while ([set next]) {
		user.ID = [set intForColumn:@"ID"];
		user.userName = [set stringForColumn:@"username"];
		user.password = [set stringForColumn:@"password"];
		user.safeQuestion = [set stringForColumn:@"safequestion"];
		user.safeResult = [set stringForColumn:@"saferesult"];
//		NSData *data = [set dataForColumn:@"image"];
//		
//		user.image = [UIImage imageWithData:data];
		NSLog(@"name=%@",user.userName);
	}
	return user;
}

- (UIImage*)searchImage:(NSString *)name{
	UIImage *image = [[UIImage alloc]init];
	
	FMResultSet *set = [db executeQuery:@"select image from userTable where username=?",name];
	NSLog(@"[set next]=%d",[set next]);
	while ([set next]) {
		NSData *data = [set dataForColumn:@"image"];
		NSLog(@"data=%@",data);
		image = [UIImage imageWithData:data];
		NSLog(@"name=%@",image);
	}
	return image;

}

@end
