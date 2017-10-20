//
//  Utils.h
//  
//
//  Created by longmap yu on 12-3-11.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Reachability.h"

@interface Utils : NSObject {

}
+(BOOL)canInit;

+(BOOL)connectedToNetwork;
+(void)resetPushInfoWithKey:(NSString *)key value:(NSString *)value;

+(void)clearDocument;
+(NSString * )getScanSize:(CGSize)maxSize img:(UIImage *)img;
+(BOOL )isGif:(NSString *)url;
+(BOOL)checkFileExist:(NSString *)filename;
+(NSString *)getFileName:(NSString *)url;
+(void)setAppLanguage:(NSString *)language;
+(NSString *)getAppLanguage;
+(BOOL)is_zhLanguage;
+(NSString *)localizedStringForKey:(NSString*) key language:(NSString *)lang;
+(NSString *)interfaceURL:(NSString *)url;
+(NSString *)getString:(NSString *)str;
+(BOOL)deleteCacheImgWithName:(NSString *)imagename;
+(NSString *)getLocalFromDict:(NSDictionary *)dict key:(NSString *)a_key;
+(UIImage *)getResourcePngImage:(NSString *)imageName;
+(UIImage *)getCacheImage:(NSString *)imageName;
+(BOOL)writeToCacheWithFileName:(NSString *)filename saveImage:(UIImage *)image;
+(UIImage *)getIconFileName:(NSString *)iconURL;
+(NSString *)getIconFileNamePath:(NSString *)iconURL;

+(NSString *)getUrlFormateName:(NSString *)url;
+(BOOL)writeIconWithFileName:(NSString *)iconURL saveImage:(UIImage *)image;

+(void)showURL:(NSString *)url postData:(NSMutableArray *)postData;

+(void) cache:(id)obj forKey:(NSString *) key;
+(id) getCacheForKey:(NSString*) key;

@end
