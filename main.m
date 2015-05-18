#import <Cocoa/Cocoa.h>
#import "FPXPlist.h"

int main(int argc, char *argv[])
{
    if(argc == 2 && strcmp(argv[1],"--relaunch")==0) {
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        
        // wait parent process finish
        while(getppid() > 1) {
            usleep(100);
        }
        NSBundle *mb = [NSBundle mainBundle];
        
        // relaunch
        [[NSWorkspace sharedWorkspace]
         launchApplicationAtURL:[mb bundleURL]
         options:NSWorkspaceLaunchDefault
         configuration:nil
         error:nil];
        
        [pool release];
        return 0;
    }
    else if(argc == 3 && strcmp(argv[1],"--update")==0) {
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        
        // wait parent process finish
        while(getppid() > 1) {
            usleep(100);
        }
        NSBundle *mb = [NSBundle mainBundle];
        
        // rename executable
        NSString *name = [NSString stringWithCString:argv[2] encoding:NSUTF8StringEncoding];
        NSString *name_current = [[mb executableURL] lastPathComponent];
        if([name isEqual:name_current]) goto END;
        NSURL *exeURL = [mb executableURL];
        NSURL *newExeURL= [[exeURL URLByDeletingLastPathComponent]
                           URLByAppendingPathComponent:name];
        if([[NSFileManager defaultManager] moveItemAtURL:exeURL toURL:newExeURL error:nil] == NO) {
            NSLog(@"Fatal:Rename executable failed:[%@]->[%@]", exeURL, newExeURL);
            goto END;
        }
        // update Info.plist
        NSURL *plistURL = [[[mb bundleURL]
                            URLByAppendingPathComponent:@"Contents"]
                           URLByAppendingPathComponent:@"Info.plist"];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfURL:plistURL];
        NSString *bi = [NSString stringWithFormat:@"jp.yusukeshibata.fpx.%@", name];
        [dic setValue:name forKey:@"CFBundleExecutable"];
        [dic setValue:name forKey:@"CFBundleName"];
        [dic setValue:bi forKey:@"CFBundleIdentifier"];
//        if([[NSFileManager defaultManager] removeItemAtURL:plistURL error:nil] == NO) {
//            NSError *nserr = [NSError errorWithDomain:NSPOSIXErrorDomain code:errno userInfo:NULL];
//            NSLog(@"Fatal:Update Info.plist failed:[remove %@]:%@", plistURL,[nserr localizedDescription]);
//            goto END;
//        }
        if([dic writeToURL:plistURL atomically:YES] == NO) {
            NSError *nserr = [NSError errorWithDomain:NSPOSIXErrorDomain code:errno userInfo:NULL];
            NSLog(@"Fatal:Update Info.plist failed:[write to %@]:%@", plistURL,[nserr localizedDescription]);
            goto END;
        }
        
        NSDictionary *attr = [NSDictionary dictionaryWithObjectsAndKeys: [NSDate date],
                              NSFileModificationDate, NULL];
        [[NSFileManager defaultManager] setAttributes:attr ofItemAtPath:[mb bundlePath] error: nil];
    END:
        
        // relaunch
        [[NSWorkspace sharedWorkspace]
         launchApplicationAtURL:[mb bundleURL]
         options:NSWorkspaceLaunchDefault
         configuration:nil
         error:nil];
        
        [pool release];
        return 0;
    }
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    NSString *name_current = [[[NSBundle mainBundle] executablePath] lastPathComponent];
    if([name_current isEqual:[FPXPlist name]] == NO) {
        NSArray *arguments = [NSArray arrayWithObjects:
                              @"--update",
                              [FPXPlist name],
                              nil];
        NSTask *t = [[[NSTask alloc] init] autorelease];
        [t setLaunchPath:[[NSBundle mainBundle] executablePath]];
        [t setArguments:arguments];
        [t launch];
        [pool release];
        return 0;
    }
    NSUInteger modifierFlags = [NSEvent modifierFlags];
    BOOL settingMode = [[NSNumber numberWithInt:(modifierFlags & NSCommandKeyMask)] boolValue];
    [NSApplication sharedApplication];
    NSString *nibName = settingMode == NO && [FPXPlist exists] ? @"MainMenu" : @"SettingMenu";
    [NSBundle loadNibNamed:nibName owner:NSApp];
    [NSApp run];
    [pool release];
}
