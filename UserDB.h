//
//  UserDB.h
//  MedicalSystem
//
//  Created by mac on 15/4/1.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabasePool.h"
#import "FMDatabaseQueue.h"
#import "UserModel.h"

@interface UserDB : NSObject
- (void) closeDatabase;
- (void) initializeDatabase;
- (NSMutableArray*) getAllData;
- (void) insertToDB:(UserModel*)user;
- (BOOL) deleteDataOfName:(NSString*)name;
- (BOOL) updateDataOfName:(NSString*)name andSet:(NSString*)string1 andNew:(NSString*)string2;
- (UserModel*) searchUserOfName:(NSString*)name;
- (UIImage*) searchImage:(NSString*)name;

@end
