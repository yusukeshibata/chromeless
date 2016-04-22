#import <Foundation/Foundation.h>

@interface CLSettingAppDelegate : NSObject <NSApplicationDelegate>

- (IBAction)apply:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)selectFile:(id)sender;

@property (assign) IBOutlet NSWindow *window;

@property (retain,nonatomic) IBOutlet NSString *x;
@property (retain,nonatomic) IBOutlet NSString *y;
@property (retain,nonatomic) IBOutlet NSString *w;
@property (retain,nonatomic) IBOutlet NSString *h;
@property (retain,nonatomic) IBOutlet NSString *url;
@property (retain,nonatomic) IBOutlet NSNumber *dontmakeordertop;
@property (retain,nonatomic) IBOutlet NSNumber *hidecursor;
@property (retain,nonatomic) IBOutlet NSNumber *removeshadow;
@property (retain,nonatomic) IBOutlet NSNumber *interactiondisabled;

@end
