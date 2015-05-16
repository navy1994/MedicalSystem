//
//  MedDB.h
//  MedicalSystem
//
//  Created by mac on 15/3/25.
//  Copyright (c) 2015年 xiatei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MedModel.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabasePool.h"
#import "FMDatabaseQueue.h"

@interface MedDB : NSObject

- (NSMutableArray*) getAllData;
- (void) closeDatabase;
- (void) initializeDatabase;
- (void) insertToDB:(MedModel*)med;
- (void) deleteDataOfName:(NSString*)name;
- (BOOL) updateDataOfName:(NSString*)name andMedModel:(MedModel*)med;
- (NSString*) searchPrice:(NSString*)medName;

@end
