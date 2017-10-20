//
//  appDetailViewController.m
//  OA
//
//  Created by admin on 16/7/14.
//  Copyright © 2016年 dengfan. All rights reserved.
//

#import "appDetailViewController.h"
#import "Utils.h"
#import <CommonCrypto/CommonDigest.h>



@interface appDetailViewController ()
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) JSContext *jsContext;

@end

@implementation appDetailViewController


- (NSString *) md5:(NSString *) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

- (UIWebView *)webView {
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 55, UIScreenWidth, UIScreenHeight-55)];
        
        _webView.scalesPageToFit = YES;
        
        NSString *link =[self.data objectForKey:@"link"];
        
        NSString *username = [Utils getCacheForKey:@"userName"];
        
        NSString *userPwd = [Utils getCacheForKey:@"password"];
        NSString *MD5pwd = [self md5:userPwd];
        
        NSString *userid =[Utils getCacheForKey:@"userId"];
        
        NSString *loginId = [Utils getCacheForKey:@"loginId"];
        NSString *deptName = [Utils getCacheForKey:@"deptName"];
        
        NSString * viewURL = [NSString stringWithFormat:@"%@?username=%@&userpwd=%@&userid=%@&loginid=%@&deptName=%@",link,username,MD5pwd,userid,loginId,deptName];
        viewURL = [viewURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *url =[[NSURL alloc] initWithString:viewURL];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        [_webView loadRequest:request];
        _webView.delegate = self;
    }
    
    return _webView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *titleName =[self.data objectForKey:@"name"];
    self.mytitle.text =titleName;
    [self.view addSubview:self.webView];
    
}
- (NSString *)getPersonLoginID:(NSString *)title{
    NSString *loginId = [Utils getCacheForKey:@"loginId"];
    title =loginId;
    return title;
}

- (NSString *)getPersonInfo:(NSString *)title{
    
    NSString *username = [Utils getCacheForKey:@"userName"];
    title = username;
    
    return title;
}

- (NSString *)getPersonUID:(NSString *)title{
    NSString *userid =[Utils getCacheForKey:@"userId"];
    title = userid;
    return title;
}

- (NSString *)getPersonPwd:(NSString *)title{
    NSString *userPwd = [Utils getCacheForKey:@"password"];
    NSString *MD5pwd = [self md5:userPwd];
    title = MD5pwd;
    return title;
}

- (NSString *)getDeptName:(NSString *)title{
    title =[Utils getCacheForKey:@"deptName"];
    return title;
}
- (void)close{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)hideTitleBar{
    self.webView.frame = CGRectMake(0, 0, UIScreenWidth, UIScreenHeight-55);
    self.topView.hidden =YES;
}

- (void)showTitleBar{
    self.webView.frame = CGRectMake(0, 55, UIScreenWidth, UIScreenHeight-55);
    self.topView.hidden =NO;
}

- (NSString *)setTitleBar:(NSString *)title{
    
    self.mytitle.text =title;
    return title;

}
//- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    
//    
//    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    self.jsContext[@"mobileJsBridge"] = self;
//}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsContext[@"mobileJsBridge"] = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)backBtn:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
