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
    NSScreen *screen = [[NSScreen screens] objectAtIndex:0];
    NSRect screenrect = [screen frame];
    [window setFrame:NSMakeRect([[dic objectForKey:@"x"] intValue],
                                screenrect.size.height - [[dic objectForKey:@"y"] intValue] - [[dic objectForKey:@"h"] intValue],
                                [[dic objectForKey:@"w"] intValue],
                                [[dic objectForKey:@"h"] intValue]) display:YES];
    BOOL dontmakeordertop = [[dic objectForKey:@"dontmakeordertop"] boolValue];
    BOOL removeshadow = [[dic objectForKey:@"removeshadow"] boolValue];
    BOOL interactiondisabled = [[dic objectForKey:@"interactiondisabled"] boolValue];
    if(dontmakeordertop) {
        [NSMenu setMenuBarVisible:NO];
        [window makeKeyAndOrderFront:nil];
    } else {
        [window setLevel:NSScreenSaverWindowLevel + 1];
        [window orderFront:nil];
    }
    if(removeshadow) {
        [window setHasShadow:NO];
    }
    if([[dic objectForKey:@"hidecursor"] boolValue])
        CGDisplayHideCursor(kCGDirectMainDisplay);
    
    [webview setMainFrameURL:[dic objectForKey:@"url"]];
    if(interactiondisabled) {
        [webview setUIDelegate:self];
        [webview setEditingDelegate:self];
        [[[webview mainFrame] frameView] setAllowsScrolling:NO];
    }
}
- (NSArray *)webView:(WebView *)sender contextMenuItemsForElement:(NSDictionary *)element
    defaultMenuItems:(NSArray *)defaultMenuItems {
    // disable right-click context menu
    return nil;
}
- (BOOL)webView:(WebView *)webView shouldChangeSelectedDOMRange:(DOMRange *)currentRange
     toDOMRange:(DOMRange *)proposedRange
       affinity:(NSSelectionAffinity)selectionAffinity
 stillSelecting:(BOOL)flag {
    // disable text selection
    return NO;
}
- (NSUInteger)webView:(WebView *)sender dragSourceActionMaskForPoint:(NSPoint)point {
    return WebDragSourceActionNone; // Disable any WebView content drag
}
- (NSUInteger)webView:(WebView *)sender dragDestinationActionMaskForDraggingInfo:(id <NSDraggingInfo>)draggingInfo {
    return WebDragDestinationActionNone; // Disable any WebView content drop
}
@end
