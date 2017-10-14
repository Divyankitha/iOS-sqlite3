//
//  ViewController.m
//  SQLite
//
//  Created by Divyankitha Raghava Urs on 9/20/17.
//  Copyright © 2017 Divyankitha Raghava Urs. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(
                    NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    _databasePath = [[NSString alloc]
                     initWithString: [docsDir stringByAppendingPathComponent:
                                      @"ContactDetails.db"]];
    
    
    NSLog(@"\nDBPath %@\n", docsDir);
    
    
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: _databasePath ] == NO)
    {
        const char *dbpath = [_databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK) //Create new table
        {
            char *error;
            const char *sql_stmt =
            "CREATE TABLE IF NOT EXISTS CONTACTS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, LOCATION TEXT, ADDRESS TEXT, PHONE TEXT, EMAIL TEXT)";
            
            if (sqlite3_exec(_contactDB, sql_stmt, NULL, NULL, &error) != SQLITE_OK)
            {
                _status.text = @"Failed to create Contact Table";
            }
            sqlite3_close(_contactDB);
        } else {
            _status.text = @"Failed to open/create database";
        }
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)Save:(id)sender {
    sqlite3_stmt    *statement;
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO CONTACTS (name, location, address, phone, email) VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\")",
                               _ContactName.text, _location.text, _address.text, _PhNumber.text, _email.text];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_contactDB, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            _status.text = @"Contact added successfully!";
            _ContactName.text = @"";
            _address.text = @"";
            _PhNumber.text = @"";
            _location.text = @"";
            _email.text =@"";
        } else {
            _status.text = @"Failed to add contact";
        }
        sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
    }

}

- (IBAction)cancel:(id)sender
{
    _status.text = @"Contact addition cancelled!";
    _ContactName.text = @"";
    _address.text = @"";
    _PhNumber.text = @"";
    _location.text = @"";
    _email.text =@"";
}
@end
