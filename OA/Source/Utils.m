//
//  Utils.m
//  
//
//  Created by  longmap on 12-3-11.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//
#define DOCSFOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
#import "Utils.h" 
#import <SystemConfiguration/SystemConfiguration.h> 
#import <netdb.h>
#import <QuartzCore/QuartzCore.h>

#import "Reachability.h"


#import "AppDelegate.h"

@implementation Utils

+(void)resetPushInfoWithKey:(NSString *)key value:(NSString *)value{
	//保存推送消息
	NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
	//NSString *login_uid=[Utils getString:[defaults valueForKey:@"login_uid"]];
	NSDictionary *defaults_push_info=[defaults valueForKey:@"push_info"];
	NSMutableDictionary *push_info=[[NSMutableDictionary alloc] init];
	if ([defaults_push_info isKindOfClass:NSDictionary.class]&&[[defaults_push_info allKeys] count]>0) {
		[push_info setValuesForKeysWithDictionary:defaults_push_info];
	}
	
	if ([[push_info allKeys] count]>0) {
		[push_info setValue:value forKey:key];
		[defaults setValue:push_info forKey:@"push_info"];//保存信息
		[defaults synchronize];
	}
	NSLog(@"key=%@,value=%@",key,value);
	NSLog(@"push_info=%@",push_info);
	[[NSNotificationCenter defaultCenter] postNotificationName:@"checkShowNoticeFooter" object:nil];
 
}

+(BOOL)canInit{
	
	NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
	NSString *init_time=[Utils getString:[defaults valueForKey:@"init_time"]];
    NSLog(@"init_time=%@",init_time);
	if ([init_time isEqualToString:@""]) {
		
		return YES;
	}else {
		NSDate *datenow = [NSDate date];
		NSString *now_timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
		int offset=[now_timeSp intValue]-[init_time intValue];
		
		NSLog(@"offset:%d",offset); //时间戳的值
		if (offset>=24*60*60) {
			return YES;
		}else {
			return NO;
		}
	}
}
//+(UIImage * )getPhotoViewWithImg:(UIImage *)img ImgSize:(CGSize)maxSize{
//	
//	float cur_width=img.size.width;
//	float cur_height=img.size.height;
//	
//	float org_y=0.0f;
//	
//	float scan=maxSize.width/img.size.width;
//	float newHeight=scan*img.size.height;
//	float org_x=0.0f;
//	if (img.size.width>=maxSize.width) {
//		cur_width=maxSize.width;
//		if (newHeight>=maxSize.height) {
//			org_y=(newHeight-maxSize.height)/2.0f;
//			cur_height=maxSize.height;
//		}
//
//	}else{
//	    if (cur_height>=maxSize.height) {
//			org_y=(img.size.height-maxSize.height)/2.0f;
//			cur_height=maxSize.height;
//		}
//        newHeight=img.size.height;
//	}
//	img=[img imageByScalingToSize:CGSizeMake(cur_width, newHeight)];
//	
//   
//	CGRect rect = CGRectMake(org_x, org_y, cur_width, cur_height);//创建矩形框 
//	img=[UIImage imageWithCGImage:CGImageCreateWithImageInRect([img CGImage], rect)]; 
//	
//    return img;
//	
//}

+(NSString * )getScanSize:(CGSize)maxSize img:(UIImage *)img{
		BOOL isZoom=NO;//是否缩放
		
		float newWidth=0.0f;//新宽
		float newHeight=0.0f;//新高
		float maxwidth=maxSize.width;//限制宽
		float maxheight=maxSize.height;//限制高
		CGFloat srcWidth =img.size.width;//原始宽
		CGFloat srcHeight = img.size.height;////原始高
		NSLog(@"srcWidth=%f,srcHeight=%f",srcWidth,srcHeight);
		if (srcWidth>0&&srcHeight>0) {
			isZoom=YES;
		}
		if (isZoom) {
			if (srcWidth/srcHeight>=maxwidth/maxheight) {
				//比较高宽比例，确定以宽或者是高为基准进行计算。
				if (srcWidth>maxwidth) {
					////以宽为基准开始计算，
					//当宽度大于限定宽度，开始缩放
					newWidth=maxwidth;
					newHeight=(srcHeight*maxwidth)/srcWidth;
				}else {
					//当宽度小于限定宽度，直接返回原始数值。
					
					newWidth=srcWidth;
					newHeight=srcHeight;
				}
				
			}else {
				if (srcHeight>maxheight) {
					//以高为基准，进行计算
					//当高度大于限定高度，开始缩放。
					
					newHeight=maxheight;
					newWidth=(srcWidth*maxheight)/srcHeight;
				}else {
					//当高度小于限定高度，直接返回原始数值。
					newWidth=srcWidth;
					newHeight=srcHeight;
				}
				
			}
			
		}else {
			//不正常，返回0
			newWidth=0;
			newHeight=0;
		}
		//return CGSizeMake(maxwidth, maxheight);
	return NSStringFromCGSize(CGSizeMake(newWidth, newHeight));
	 
}

+(NSString *)flattenHTML:(NSString *)html {
	if (html!=nil) {
		if ([html isKindOfClass:NSString.class]) {
			NSScanner *theScanner;
			NSString *text = nil;
			
			theScanner = [NSScanner scannerWithString:html];
			
			while ([theScanner isAtEnd] == NO) {
				
				// find start of tag
				[theScanner scanUpToString:@"<" intoString:NULL] ;
				
				// find end of tag
				[theScanner scanUpToString:@">" intoString:&text] ;
				
				// replace the found tag with a space
				//(you can filter multi-spaces out later if you wish)
				html = [html stringByReplacingOccurrencesOfString:
						[ NSString stringWithFormat:@"%@>", text]
													   withString:@" "];
				
			} // while //
			
			return [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		}else {
			return @"";
		}
	}else {
		return @"";
	}
}
/**
 *bt_recvorsend:收到的瓶子还是扔出的瓶子。收到的（0）、扔出的（1）
 **/
+(NSDictionary *)getBottleTypeurWithBttypeid:(int)type_id{
	//DraftBottlesAppDelegate *application=[DraftBottlesAppDelegate shareApplication];
	NSString *url=@"";
	NSMutableDictionary *bottleDict=[[NSMutableDictionary alloc] init];

//	NSArray *array= application.bttypes_list;
//		for (int i=0; i<[array count]; i++) {
//			NSDictionary *dict=[array objectAtIndex:i];
//			int bttypeid=[[dict valueForKey:@"bttypeid"] intValue];
//			if (bttypeid==type_id) {
//				
//				[bottleDict setValuesForKeysWithDictionary:dict];
//				break;
//			}
//			
//		}
	return bottleDict;
	
}
+(BOOL )isGif:(NSString *)url{
	NSArray *sarray = [url componentsSeparatedByString:@"/"];
	if ([sarray count]>0) {
		NSString *filename= [sarray objectAtIndex:([sarray count]-1)];
		NSArray *sarray2 = [filename componentsSeparatedByString:@"."];
		if ([[sarray2 objectAtIndex:[sarray2 count]-1] isEqualToString:@"gif"]) {
			return YES;
		}else {
			return NO;
		}

	}else {
		return NO;
	}
}
+(NSString *)getFileName:(NSString *)url{
     NSArray *sarray = [url componentsSeparatedByString:@"/"];
	if ([sarray count]>0) {
		return [sarray objectAtIndex:([sarray count]-1)];
	}else {
		return @"";
	}
}
+(void)setAppLanguage:(NSString *)language{
	NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
	[defaults setValue:language forKey:@"AppLanguage"];
}
+(NSString *)getAppLanguage{
   NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
	return [defaults valueForKey:@"AppLanguage"];
}



+(void) cache:(id)obj forKey:(NSString *) key{
	NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
	[defaults setObject:obj forKey:key];
    [defaults synchronize];
    
}

+(id) getCacheForKey:(NSString*) key{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
	return [defaults objectForKey:key];
}


+(BOOL)is_zhLanguage{
   NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
   NSString *language= [defaults valueForKey:@"AppLanguage"];
	if ([language isEqualToString:@"zh-Hans"]) {
		return YES;
	}else {
		return NO;
	}
}
+(NSString *)localizedStringForKey:(NSString*) key language:(NSString *)lang{
   if (lang==nil||[lang isEqualToString:@""]) {
	   NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
	   lang=[defaults valueForKey:@"AppLanguage"];
   }
	NSString *path;
	//NSLog(@"lang=%@,key=%@",lang,key);
	if ([lang isEqualToString:@"zh-Hans"]) {
		path = [[NSBundle mainBundle] pathForResource:@"zh-Hans" ofType:@"lproj"];
	}else {
		path = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
	}
   	NSBundle* languageBundle = [NSBundle bundleWithPath:path];
	NSString* str=[languageBundle localizedStringForKey:key value:@"" table:nil];
	return str;
}
+(NSString *)interfaceURL:(NSString *)url{
//    return [NSString stringWithFormat:@"%@%@",BaseURL,url];
    return nil;
}
+(NSString *)getString:(NSString *)str{
	if (str!=nil) {
		if ([str isKindOfClass:NSString.class]) {
			return str;
		}else {
			return @"";
		}

	}else {
		return @"";
	}
}
+(NSString *)getLocalFromDict:(NSDictionary *)dict key:(NSString *)a_key{
	NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
	NSString *language= [defaults valueForKey:@"AppLanguage"];
	NSString *search_key=@"";
	if ([language isEqualToString:@"zh-Hans"]) {
		search_key = [NSString stringWithFormat:@"%@_cn",a_key];
	}else {
		search_key = [NSString stringWithFormat:@"%@_en",a_key];
	}
	//NSLog(@"key=%@",search_key);
	NSString *value=[dict valueForKey:search_key];
	if (value==nil) {
		return @"";
	}
	return value;
}
+(UIImage *)getCacheImage:(NSString *)imageName{
//	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSArray *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);   
    NSString *cachePath = [cache objectAtIndex:0] ;   
	NSString *iconDirectory = [cachePath stringByAppendingPathComponent:@"icon"];
	
	NSString *path =[iconDirectory stringByAppendingString:[NSString stringWithFormat:@"/%@",imageName]];
	return [UIImage imageWithContentsOfFile:path];
}
+(BOOL)checkFileExist:(NSString *)filename{
//	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	NSArray *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);   
    NSString *cachePath = [cache objectAtIndex:0] ;   
	NSString *iconDirectory = [cachePath stringByAppendingPathComponent:@"icon"];
	
	NSString *path =[iconDirectory stringByAppendingString:[NSString stringWithFormat:@"/%@",filename]];
	NSFileManager *fm=[NSFileManager defaultManager];
	BOOL flag= [fm fileExistsAtPath:path];
 
	return flag;
}
+(BOOL)deleteCacheImgWithName:(NSString *)imagename{
	NSArray *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);   
    NSString *cachePath = [cache objectAtIndex:0] ;   
	NSString *iconDirectory = [cachePath stringByAppendingPathComponent:@"icon"];
	NSString *imgPath = [iconDirectory stringByAppendingPathComponent:imagename];
	NSFileManager *fileManager=[NSFileManager defaultManager];
	BOOL isDir;
	if ([fileManager fileExistsAtPath:iconDirectory isDirectory:&isDir]) {
		NSURL *fileUrl=[NSURL fileURLWithPath:imgPath];
		return [[NSFileManager defaultManager] removeItemAtURL:fileUrl error:nil];
		
	}
	return NO;
}
+(UIImage *)getResourcePngImage:(NSString *)imageName{
	NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
	return [UIImage imageWithContentsOfFile:path];
}
+(BOOL)writeToCacheWithFileName:(NSString *)filename saveImage:(UIImage *)image{
//  	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
//	NSString *document=[paths objectAtIndex:0];
	NSArray *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);   
    NSString *cachePath = [cache objectAtIndex:0] ;   
	NSString *iconDirectory = [cachePath stringByAppendingPathComponent:@"icon"];
	NSFileManager *fileManager=[NSFileManager defaultManager];
	BOOL isDir=YES;
	if (![fileManager fileExistsAtPath:iconDirectory isDirectory:&isDir]) {
		NSError* error = nil;
		[fileManager createDirectoryAtPath:iconDirectory withIntermediateDirectories:YES attributes:nil error:&error];
	}
	//并给文件起个文件名
	NSString *uniquePath=[iconDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",filename]];
	//NSLog(@"-----path=%@",uniquePath);
	BOOL result=[UIImagePNGRepresentation(image)writeToFile: uniquePath    atomically:YES];
	return result;
}
+(UIImage *)getIconFileName:(NSString *)iconURL{
//	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
//	NSString *document=[paths objectAtIndex:0];
	NSArray *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);   
    NSString *cachePath = [cache objectAtIndex:0] ;   
	
	NSString *iconDirectory = [cachePath stringByAppendingPathComponent:@"icon"];
	NSString *uniquePath=[iconDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",iconURL]];
   return [UIImage imageWithContentsOfFile:uniquePath];
	
}

+(NSString *)getIconFileNamePath:(NSString *)iconURL{
    //	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    //	NSString *document=[paths objectAtIndex:0];
	NSArray *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cache objectAtIndex:0] ;
	
	NSString *iconDirectory = [cachePath stringByAppendingPathComponent:@"icon"];
	NSString *uniquePath=[iconDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",iconURL]];
    return uniquePath;
	
}


+(NSString *)getUrlFormateName:(NSString *)url{
	if (url!=nil) {
		NSString *a_url=[url stringByReplacingOccurrencesOfString:@"://" withString:@"_"];
		a_url=[a_url stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
		NSArray  * array= [a_url componentsSeparatedByString:@"?"];
		NSString *filename=@"";
		for (int i=[array count]-1; i>=0; i--) {
			filename=[NSString stringWithFormat:@"%@%@",filename,[array objectAtIndex:i]];
		}
		return filename;
		
	}else {
		return @"";
	}
}
+(void)clearCacheFiles
{
	NSArray *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);   
    NSString *cachePath = [cache objectAtIndex:0] ; 
    NSString *iconDirectory = [cachePath stringByAppendingPathComponent:@"icon"];
	NSFileManager *fileManager=[NSFileManager defaultManager];
	BOOL isDir;
	if ([fileManager fileExistsAtPath:iconDirectory isDirectory:&isDir]) {
		//NSLog(@"iconDirectory=%@",iconDirectory);
		NSArray *fileList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:iconDirectory error:nil];
		for(int i=0;i<[fileList count]-1; i++){
			
			NSString *filePath = [iconDirectory stringByAppendingPathComponent:[fileList objectAtIndex:i]];
			
			NSURL *filepaht1=[NSURL fileURLWithPath:filePath];
			
			[[NSFileManager defaultManager] removeItemAtURL:filepaht1 error:nil];
		}
	}
	
}

+(BOOL)writeIconWithFileName:(NSString *)iconURL saveImage:(UIImage *)image{
	
	
//  	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
//	NSString *document=[paths objectAtIndex:0];
	
	NSArray *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);   
    NSString *cachePath = [cache objectAtIndex:0] ;  
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString *iconDirectory = [cachePath stringByAppendingPathComponent:@"icon"];
	if (![fileManager fileExistsAtPath:iconDirectory]) {
		NSError* error = nil;
        [fileManager createDirectoryAtPath:iconDirectory 
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:&error];
        if( error != nil ){
            NSLog(@"Can not create directory %@.  Error is %@.", iconDirectory,
                  [error description]);
            return NO;
        }
		
	}
	
	NSString *uniquePath=[iconDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",iconURL]];
	BOOL result=[UIImagePNGRepresentation(image)writeToFile: uniquePath    atomically:YES];
	
	//NSLog(@"result=%d,uniquePath=%@",result,uniquePath);
	return result;
}
//是否可以连接到网络，使用Socket连接
+ (BOOL)connectedToNetwork
{
    // Create zero addy
    //定义结构体sockaddr,使用Socket连接
    struct sockaddr_in zeroAddress;
    //初始化该结构体
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    //创建 SCNetworkReachabilityRef结构体
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);    
    SCNetworkReachabilityFlags flags;
    
    //是否可以接收数据
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        printf("Error. Could not recover network reachability flags\n");
        return NO;
    }
    // 是否可以Reachable
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    //是否需要Connection
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    //最后,既可以Reachable又不需要Connection,即表示已经连接到网络
    return (isReachable && !needsConnection) ? YES : NO;
}





+(void)showURL:(NSString *)url postData:(NSMutableArray *)postData{
    NSLog(@"postData.cunt=%d",[postData count]);
    NSString *dataStr=@"";
	for (int i=0; i<[postData count]; i++) {
		NSDictionary *dict=[postData objectAtIndex:i];
		dataStr=[NSString stringWithFormat:@"%@&%@=%@",dataStr,[dict valueForKey:@"key"],[dict valueForKey:@"value"]];
	}
	NSString *urlstr=[NSString stringWithFormat:@"%@?%@",url,dataStr];
	NSLog(@"请求地址urlstr %@",urlstr);
}

@end
