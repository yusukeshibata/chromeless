#import "FPXAppDelegate.h"
#import "FPXPlist.h"
#import <CoreGraphics/CGDirectDisplay.h>

@implementation FPXAppDelegate

@synthesize window;
@synthesize webview;

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    NSDictionary *dic = [FPXPlist retrieve];
    [window setFrame:NSMakeRect([[dic objectForKey:@"x"] intValue],
                                [[dic objectForKey:@"y"] intValue],
                                [[dic objectForKey:@"w"] intValue],
                                [[dic objectForKey:@"h"] intValue]) display:YES];
    BOOL dontmakeordertop = [[dic objectForKey:@"dontmakeordertop"] boolValue];
    if(dontmakeordertop) {
        [NSMenu setMenuBarVisible:NO];
        [window makeKeyAndOrderFront:nil];
    } else {
        [window setLevel:NSScreenSaverWindowLevel + 1];
        [window orderFront:nil];
    }
    if([[dic objectForKey:@"hidecursor"] boolValue])
        CGDisplayHideCursor(kCGDirectMainDisplay);
    
    [webview setMainFrameURL:[dic objectForKey:@"url"]];
    
    NSLog(@"%@", [FPXPlist name]);
    
}

@end
