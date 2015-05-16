//
//  FellowDB.h
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
#import "FellowModel.h"

@interface FellowDB : NSObject

- (NSMutableArray*) getAllData;
- (void) closeDatabase;
- (void) initializeDatabase;
- (void) insertToDB:(FellowModel*)fellow;
- (BOOL) deleteDataOfName:(NSString*)name;
- (BOOL) updateDataOfName:(NSString*)name andMedModel:(FellowModel*)fellow;
- (FellowModel*) searchPatientOfName:(NSString*)name;

@end
