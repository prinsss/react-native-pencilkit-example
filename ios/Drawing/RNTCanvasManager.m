//
//  RNTCanvasManager.m
//  Drawing
//
//  Created by Prin S. on 2022/3/6.
//

#import "React/RCTViewManager.h"
#import "React/RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(RNTCanvasManager, RCTViewManager)

RCT_EXTERN_METHOD(getDrawingData: (RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(setDrawingData: (NSString)base64
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)

@end
