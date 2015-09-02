//
//  PluginObject.h
//  Weppy
//
//  Created by Nate Weaver on 2015-08-29.
//
//

#ifndef Weppy_PluginObject_h
#define Weppy_PluginObject_h

// Structure for per-instance storage
typedef struct PluginObject
{
	NPP npp;

	NPWindow window;

	NPBool shouldUseCocoa;
	CALayer *caLayer;
	NPBool shouldInvalidateCALayer;
	NSMutableData *streamedData;
	CGImageRef theImage;
	NPBool drawCentered;

	NPBool isFullWindow;
	NSURL *url;

	MenuHandler	*menuHandler;
} PluginObject;

#endif
