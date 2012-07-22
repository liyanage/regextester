//
//  AppDelegate.h
//  RegexTester
//
//  Created by Marc Liyanage on 7/21/12.
//
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *regexTextField;

@property (strong) IBOutlet NSTextView *inputTextView;

@property (strong) NSString *regexString;
@property (strong) NSString *inputString;
@property (readonly) NSString *resultString;
@property (readonly) NSImage *regexStatusImage;

@property (assign) BOOL optionCaseInsensitive;
@property (assign) BOOL optionAllowCommentsAndWhitespace;
@property (assign) BOOL optionIgnoreMetacharacters;
@property (assign) BOOL optionDotMatchesLineSeparators;
@property (assign) BOOL optionAnchorsMatchLines;
@property (assign) BOOL optionUseUnixLineSeparators;
@property (assign) BOOL optionUseUnicodeWordBoundaries;

@property (weak) IBOutlet NSObjectController *controller;

@end
