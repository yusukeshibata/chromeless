#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface FPXAppDelegate : NSObject <NSApplicationDelegate,WebUIDelegate,WebFrameLoadDelegate> {
    NSWindow *window;
    WebView *webview;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet WebView *webview;

@end
