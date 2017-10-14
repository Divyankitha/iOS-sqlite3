//
//  ViewController.h
//  SQLite
//
//  Created by Divyankitha Raghava Urs on 9/20/17.
//  Copyright © 2017 Divyankitha Raghava Urs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *ContactName;
@property (weak, nonatomic) IBOutlet UITextField *location;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *PhNumber;
@property (weak, nonatomic) IBOutlet UITextField *email;

@property (weak, nonatomic) IBOutlet UILabel *status;
- (IBAction)Save:(id)sender;
- (IBAction)cancel:(id)sender;

@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *contactDB;

@end

