//
//  appDetailViewController.h
//  OA
//
//  Created by admin on 16/7/14.
//  Copyright © 2016年 dengfan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JavaScriptObjectiveCDelegate <JSExport>

// JS调用此方法来调用OC
- (void)close;
- (void)hideTitleBar;
- (void)showTitleBar;
- (NSString *)setTitleBar:(NSString *)title;
- (NSString *)getPersonLoginID:(NSString *)title;
- (NSString *)getPersonInfo:(NSString *)title;
- (NSString *)getPersonUID:(NSString *)title;
- (NSString *)getPersonPwd:(NSString *)title;
- (NSString *)getDeptName:(NSString *)title;
@end

//// 此模型用于注入JS的模型，这样就可以通过模型来调用方法。
//@interface HYBJsObjCModel : NSObject <JavaScriptObjectiveCDelegate>
//
//@property (nonatomic, weak) JSContext *jsContext;
//@property (nonatomic, weak) UIWebView *webView;
//
//@end

//@implementation HYBJsObjCModel
//
//- (void)callWithDict:(NSDictionary *)params {
//    NSLog(@"Js调用了OC的方法，参数为：%@", params);
//}
//
//// Js调用了callSystemCamera
//- (void)callSystemCamera {
//    NSLog(@"JS调用了OC的方法，调起系统相册");
//    
//    // JS调用后OC后，又通过OC调用JS，但是这个是没有传参数的
//    JSValue *jsFunc = self.jsContext[@"jsFunc"];
//    [jsFunc callWithArguments:nil];
//}
//
//- (void)jsCallObjcAndObjcCallJsWithDict:(NSDictionary *)params {
//    NSLog(@"jsCallObjcAndObjcCallJsWithDict was called, params is %@", params);
//    
//    // 调用JS的方法
//    JSValue *jsParamFunc = self.jsContext[@"jsParamFunc"];
//    [jsParamFunc callWithArguments:@[@{@"age": @10, @"name": @"lili", @"height": @158}]];
//}
//
//- (void)showAlert:(NSString *)title msg:(NSString *)msg {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        UIAlertView *a = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//        [a show];
//    });
//}
//
//
//@end





@interface appDetailViewController : UIViewController<JavaScriptObjectiveCDelegate,UIWebViewDelegate>

@property (strong, nonatomic) NSDictionary *data;

@property (strong, nonatomic) IBOutlet UILabel *mytitle;

@property (strong, nonatomic) IBOutlet UIWebView *appWebView;

@property (strong, nonatomic) IBOutlet UIView *topView;


- (IBAction)backBtn:(id)sender;



@end
