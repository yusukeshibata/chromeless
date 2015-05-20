#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface FPXAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
    WebView *webview;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet WebView *webview;

@end
