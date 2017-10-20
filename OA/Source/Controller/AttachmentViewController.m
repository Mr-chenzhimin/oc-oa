//
//  AttachmentViewController.m
//  OA
//
//  Created by APPLE on 13-12-29.
//  Copyright (c) 2013年 dengfan. All rights reserved.
//

#import "AttachmentViewController.h"

#import "ASIHTTPRequest.h"

#import "Utils.h"

@interface AttachmentViewController (){
    ASIHTTPRequest *request;
}

@end

@implementation AttachmentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.progressView setProgress:0];
    self.progressView.hidden = NO;
    
    self.topMenuView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"head背景.png"]];
    
    NSURL *reqUrl = [NSURL URLWithString:self.path];
    
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
    [headers setObject:@"application/json" forKey:@"Content-type"];
    
    NSString *tokenId = [Utils getCacheForKey:@"tokenId"];
    [headers setObject:tokenId forKey:@"token"];
    
     NSString * filename = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",self.fileId,self.ext]];
    
    
	request = [ASIHTTPRequest requestWithURL:reqUrl];
	[request setDownloadDestinationPath:filename];
    
    
	[request setDownloadProgressDelegate:self.progressView];
    [request setUserInfo:[NSDictionary dictionaryWithObject:@"request1" forKey:@"name"]];
    [request setRequestHeaders:headers];
    
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetResult:)];
    [request setDidFailSelector:@selector(GetErr:)];
    [request startAsynchronous];
    
//    [request setValue:self.token forKey:@"token"];
    
//   [self.detailWebView  loadRequest:request];

    
}

-(void)viewWillDisappear:(BOOL)animated{
    [request cancel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)GetResult:(ASIHTTPRequest *)request{
    
    NSString * filename = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",self.fileId,self.ext]];
    
    NSURL * fileurl =[NSURL fileURLWithPath: filename];//[NSURL URLWithString:filename];

    NSURLRequest *req = [NSURLRequest requestWithURL:fileurl];
    self.detailWebView.scalesPageToFit=YES;

    [self.detailWebView loadRequest:req];

    self.progressView.hidden = YES;
    
}

- (void) GetErr:(ASIHTTPRequest *)request{
    
    NSLog(@"%@", [request error]);
    NSLog(@"服务器连接不上！");
    self.progressView.hidden = YES;
    
}




-(IBAction)returnBtnClick:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^(void){}];
    
}



- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    
    return UIDeviceOrientationPortraitUpsideDown;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIDeviceOrientationPortrait); // 只支持向左横向, YES 表示支持所有方向
}


@end
