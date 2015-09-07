//
//  MenuHandler.m
//  Weppy
//
//  Created by Nate Weaver on 2015-08-28.
//
//

#import "MenuHandler.h"
#import "PluginObject.h"

@interface MenuHandler ()

@property (assign)	NPNetscapeFuncs	*browser;
@property (assign)	NPP				instance;
@property (strong)	NSMenu			*menu;

@end

@implementation MenuHandler

- (instancetype)initWithBrowserFuncs:(NPNetscapeFuncs *)browserFuncs instance:(NPP)instance {
	self = [super init];

	if (self) {
		_browser = browserFuncs;
		_instance = instance;

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

		item = [[NSMenuItem alloc] initWithTitle:[bundle localizedStringForKey:@"COPY_IMAGE" value:nil table:nil] action:@selector(copyImage:) keyEquivalent:@""];
		item.target = self;
		[_menu addItem:item];
		[item release];
	}

	return self;
}

- (void)dealloc {
	[_menu release];
	[super dealloc];
}

- (void)viewImage:(id)sender {
	// push/pop popup enabled state doesn't work in mac WebKit so we have to open it in
	// _top instead of _blank unless popup blocking is disabled

	//_browser->pushpopupsenabledstate(_instance, FALSE);

	NPP instance = self.instance;

	//NSString *bundleid = [[NSBundle mainBundle] bundleIdentifier];
	PluginObject *obj = instance->pdata;

//	if ([bundleid hasPrefix:@"com.apple.WebKit.Plugin"]) {
//		[[NSWorkspace sharedWorkspace] openURLs:@[obj->url] withAppBundleIdentifier:@"com.apple.Safari" options:0 additionalEventParamDescripstor:nil launchIdentifiers:nil];
//	} else {
		_browser->geturl(instance, obj->url.absoluteString.UTF8String, "_top");
	//}


//
//	NPObject *windowObject = NULL;
//	_browser->getvalue(instance, NPNVWindowNPObject, &windowObject);
//
//	NPVariant urlVariant;
//	STRINGZ_TO_NPVARIANT(obj->url.absoluteString.UTF8String, urlVariant);
//
//	NPVariant nameVariant;
//	STRINGZ_TO_NPVARIANT("image", nameVariant);
//
//	NPVariant args[] = { urlVariant, nameVariant };
//
//	NPVariant result;
//
//	NPIdentifier method = _browser->getstringidentifier("open");
//	_browser->invoke(instance, windowObject, method, args, sizeof(args) / sizeof(args[0]), &result);

	//_browser->poppopupsenabledstate(_instance);
}

- (void)copyURL:(id)sender {
	NSPasteboard *pboard = [NSPasteboard generalPasteboard];
	[pboard clearContents];
	PluginObject *obj = self.instance->pdata;

	[pboard writeObjects:@[obj->url]];
}

- (void)copyImage:(id)sender {
	PluginObject *obj = self.instance->pdata;
	CGImageRef cgImage = obj->theImage;
	NSImage *image = [[NSImage alloc] initWithCGImage:cgImage size:NSZeroSize];
	NSPasteboard *pboard = [NSPasteboard generalPasteboard];
	[pboard clearContents];
	[pboard writeObjects:@[image, obj->url]];
	[image release];
}

@end
