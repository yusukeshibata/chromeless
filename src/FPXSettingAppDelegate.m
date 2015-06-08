#import "FPXSettingAppDelegate.h"
#import "FPXPlist.h"

@implementation FPXSettingAppDelegate

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    if([FPXPlist exists]) {
        NSDictionary *dic = [FPXPlist retrieve];
        self.x = [dic objectForKey:@"x"];
        self.y = [dic objectForKey:@"y"];
        self.w = [dic objectForKey:@"w"];
        self.h = [dic objectForKey:@"h"];
        self.url = [dic objectForKey:@"url"];
        self.dontmakeordertop = [dic objectForKey:@"dontmakeordertop"];
        self.hidecursor = [dic objectForKey:@"hidecursor"];
        self.removeshadow = [dic objectForKey:@"removeshadow"];
        self.interactiondisabled = [dic objectForKey:@"interactiondisabled"];
    } else {
        NSRect rect = [[NSScreen mainScreen] frame];
        self.x = [NSString stringWithFormat:@"%d",(int)rect.origin.x];
        self.y = [NSString stringWithFormat:@"%d",(int)rect.origin.y];
        self.w = [NSString stringWithFormat:@"%d",(int)rect.size.width];
        self.h = [NSString stringWithFormat:@"%d",(int)rect.size.height];
        self.url = @"";
    }
}

- (BOOL)windowShouldClose:(id)sender {
    [NSApp terminate:self];
    return YES;
}

- (IBAction)apply:(id)sender {
    
    if(self.x.length == 0 ||
       self.y.length == 0 ||
       self.w.length == 0 ||
       self.h.length == 0 ||
       self.url.length == 0) {
        NSRunAlertPanel(@"Alert", @"Fill in the blanks.", @"OK", nil,nil);
        return;
    }
    
    NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
    [dic setValue:self.x forKey:@"x"];
    [dic setValue:self.y forKey:@"y"];
    [dic setValue:self.w forKey:@"w"];
    [dic setValue:self.h forKey:@"h"];
    [dic setValue:self.url forKey:@"url"];
    [dic setValue:self.dontmakeordertop forKey:@"dontmakeordertop"];
    [dic setValue:self.hidecursor forKey:@"hidecursor"];
    [dic setValue:self.removeshadow forKey:@"removeshadow"];
    [dic setValue:self.interactiondisabled forKey:@"interactiondisabled"];
    
    [FPXPlist store:dic];
    
    NSArray *arguments = [NSArray arrayWithObjects:
                          @"--relaunch",
                          nil];
    NSTask *t = [[[NSTask alloc] init] autorelease];
    [t setLaunchPath:[[NSBundle mainBundle] executablePath]];
    [t setArguments:arguments];
    [t launch];
    
    [NSApp terminate:self];
}

- (IBAction)cancel:(id)sender {
    [NSApp terminate:self];
}

- (IBAction)selectFile:(id)sender {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setCanChooseDirectories:NO];
    [panel setShowsHiddenFiles:YES];
    [panel setTreatsFilePackagesAsDirectories:NO];
    long res = [panel runModal];
    if(res == NSFileHandlingPanelOKButton) {
        self.url = panel.URL.path;
    }
   
}

@end
