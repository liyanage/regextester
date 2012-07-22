//
//  AppDelegate.m
//  RegexTester
//
//  Created by Marc Liyanage on 7/21/12.
//
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize regexTextField;
@synthesize inputTextView;
@synthesize controller;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	[self.inputTextView setContinuousSpellCheckingEnabled:NO];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key
{
	NSMutableSet *paths = [NSMutableSet setWithSet:[super keyPathsForValuesAffectingValueForKey:key]];
	if ([key isEqualToString:@"resultString"]) {
		[paths addObjectsFromArray:@[
		 @"regexString",
		 @"inputString",
		 @"optionCaseInsensitive",
		 @"optionAllowCommentsAndWhitespace",
		 @"optionIgnoreMetacharacters",
		 @"optionDotMatchesLineSeparators",
		 @"optionAnchorsMatchLines",
		 @"optionUseUnixLineSeparators",
		 @"optionUseUnicodeWordBoundaries",
		 ]];
	} else if ([key isEqualToString:@"regexStatusImage"]) {
		[paths addObject:@"regexString"];
	}
	return paths;
}

- (NSString *)resultString
{
	NSRegularExpression *regex = [self regularExpression];
	if (!regex) {
		return nil;
	}
	
	NSString *inputString = self.inputString ? self.inputString : @"";

	NSMutableArray *outputLines = [NSMutableArray array];
	__block NSInteger resultCount = 1;
	[regex enumerateMatchesInString:inputString options:0 range:NSMakeRange(0, [inputString length]) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
		NSString *overallMatch = [inputString substringWithRange:[result range]];
		[outputLines addObject:[NSString stringWithFormat:@"Match %ld: “%@”", resultCount, overallMatch]];
		for (NSUInteger index = 1; index < [result numberOfRanges]; index++) {
			NSString *subMatch = [inputString substringWithRange:[result rangeAtIndex:index]];
			[outputLines addObject:[NSString stringWithFormat:@"Capture group %ld: “%@”", index, subMatch]];
		}
		resultCount++;
	}];
	if (![outputLines count]) {
		[outputLines addObject:@"(no match)"];
	}
	return [outputLines componentsJoinedByString:@"\n"];
}


- (NSRegularExpression *)regularExpression
{
	if (!self.regexString) {
		return nil;
	}
	
	NSRegularExpressionOptions options =
	self.optionCaseInsensitive            << 0 |
	self.optionAllowCommentsAndWhitespace << 1 |
	self.optionIgnoreMetacharacters       << 2 |
	self.optionDotMatchesLineSeparators   << 3 |
	self.optionAnchorsMatchLines          << 4 |
	self.optionUseUnixLineSeparators      << 5 |
	self.optionUseUnicodeWordBoundaries   << 6;
	
	return [NSRegularExpression regularExpressionWithPattern:self.regexString options:options error:nil];
}


- (NSImage *)regexStatusImage
{
	if (!self.regexString) {
		return [NSImage imageNamed:@"status-none"];
	}
	return [NSImage imageNamed:[self regularExpression] ? @"status-valid" : @"status-invalid"];
}

@end
