//
//  MenuHandler.m
//  Weppy
//
//  Created by Nate Weaver on 2015-08-28.
//
//

#import "MenuHandler.h"

@interface MenuHandler ()

@property (assign)	NPNetscapeFuncs	*browser;
@property (assign)	NPP				instance;
@property (strong)	NSMenu			*menu;

@end

@implementation MenuHandler

- (instancetype)initWithBrowserFuncs:(NPNetscapeFuncs *)browserFuncs instance:(NPP)instance URL:(NSURL *)url {
	self = [super init];

	if (self) {
		_browser = browserFuncs;
		_instance = instance;
		_sourceURL = [url copy];

		_menu = [[NSMenu alloc] init];

		NSBundle *bundle = [NSBundle bundleForClass:[self class]];

		NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:[bundle localizedStringForKey:@"VIEW_IMAGE" value:nil table:nil] action:@selector(viewImage:) keyEquivalent:@""];
		item.target = self;
		[_menu addItem:item];
		[item release];

		item = [[NSMenuItem alloc] initWithTitle:[bundle localizedStringForKey:@"COPY_ADDRESS" value:nil table:nil] action:@selector(copyURL:) keyEquivalent:@""];
		item.target = self;
		[_menu addItem:item];
		[item release];

	}

	return self;
}

- (instancetype)initWithBrowserFuncs:(NPNetscapeFuncs *)browserFuncs instance:(NPP)instance {
	return [self initWithBrowserFuncs:browserFuncs instance:instance URL:nil];
}

- (void)dealloc {
	[_menu release];
	[_sourceURL release];
	[super dealloc];
}

- (void)viewImage:(id)sender {
//	[[NSWorkspace sharedWorkspace] openURL:self.sourceURL];
	//_browser->pushpopupsenabledstate(_instance, FALSE);
	NPError error = _browser->geturl(_instance, self.sourceURL.absoluteString.UTF8String, "_top");
	//_browser->poppopupsenabledstate(_instance);
	NSLog(@"open url %s: %d", self.sourceURL.absoluteString.UTF8String, error);
}

- (void)copyURL:(id)sender {
	NSPasteboard *pboard = [NSPasteboard generalPasteboard];
	[pboard clearContents];
	[pboard writeObjects:@[self.sourceURL]];
}

@end
