#import <Preferences/PSListController.h>
#import <Preferences/PSTableCell.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSListItemsController.h>

@interface OPESubPageController : PSListController
@property (nonatomic, retain) NSMutableArray *chosenLabels;
@property (nonatomic, retain) NSMutableDictionary *mySavedSpecifiers;
@end

@interface PSListController (iOS12Plus)
-(BOOL)containsSpecifier:(id)arg1;
@end
