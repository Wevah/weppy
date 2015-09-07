//
//  MenuHandler.h
//  Weppy
//
//  Created by Nate Weaver on 2015-08-28.
//
//

#import <Foundation/Foundation.h>
#import "npapi/npapi.h"
#import "npapi/npfunctions.h"

@interface MenuHandler : NSObject

- (instancetype)initWithBrowserFuncs:(NPNetscapeFuncs *)browserFuncs instance:(NPP)instance;
- (instancetype)initWithBrowserFuncs:(NPNetscapeFuncs *)browserFuncs instance:(NPP)instance;

@property (readonly)	NSMenu	*menu;

@end
