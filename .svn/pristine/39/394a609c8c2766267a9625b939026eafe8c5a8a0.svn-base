//
//  AppListViewController.m
//  OA
//
//  Created by admin on 16/7/12.
//  Copyright © 2016年 dengfan. All rights reserved.
//

#import "AppListViewController.h"
#import "ApplistCollectionViewCell.h"
#import "appDetailViewController.h"
#import "ASIHTTPRequest.h"
#import "Utils.h"
#import "SBJson.h"

@interface AppListViewController (){

    int ID;
    UIImage *image;
}

@end

@implementation AppListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.MyTitleLabel.text=@"我的应用";
//    [self loadData];
    
//     [self.AppCollectView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"ApplistCollectionViewCell"];
}


- (void)viewWillAppear:(BOOL)animated{
    [self loadData];
}

-(void) loadData{
    
    //mobile/workflowModule /attachs?fid=xx&s=0&c=12
    
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    NSString * urlAddress = [NSString stringWithFormat:@"%@/mobile/userapp/userapplist",serverAddress];
    
    
    
    NSLog(@"urlAddress=%@",urlAddress);
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
    [headers setObject:@"application/json" forKey:@"Content-type"];
    
    NSString *tokenId = [Utils getCacheForKey:@"tokenId"];
    [headers setObject:tokenId forKey:@"token"];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestHeaders:headers];
    
//    [[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetResult:)];
    [request setDidFailSelector:@selector(GetErr:)];
    [request startAsynchronous];
    
    
}

- (void)GetResult:(ASIHTTPRequest *)request{
    
    NSData *data =[request responseData];
    
    NSString * aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"aStr=%@",aStr);
    
    NSMutableDictionary *result = [[[SBJsonParser alloc] init] objectWithData:data];
    
    NSMutableDictionary *rspHeader = [result objectForKey:@"rspHeader"];
    NSMutableDictionary *body = [result objectForKey:@"rspBody"];
   
    int code = [[rspHeader objectForKey:@"code"] intValue];
    
    
    if(code != 0){
        
    }else{
        
        self.listData = [body objectForKey:@"linktreeLinkVOs"];
    }
//    NSString *title = [body objectForKey:@"linkType"];
//    self.MyTitleLabel.text = title;
    
   [self.AppCollectView reloadData];
 
}

-(void) loadDataId: (NSString *)path{
    
    //mobile/workflowModule /attachs?fid=xx&s=0&c=12
    
    NSString * serverAddress = [Utils getCacheForKey:@"serverAddress"];
    
    
    NSString * urlAddress = [NSString stringWithFormat:@"%@%@",serverAddress,path];
    
    NSLog(@"urlAddress=%@",urlAddress);
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSMutableDictionary * headers = [[NSMutableDictionary alloc] init];
    [headers setObject:@"application/json" forKey:@"Content-type"];
    
    NSString *tokenId = [Utils getCacheForKey:@"tokenId"];
    [headers setObject:tokenId forKey:@"token"];
    
    
    NSString * filename = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:[NSString stringWithFormat:@"%d.png",ID]] ;
    
    image =[UIImage imageWithContentsOfFile:filename];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDownloadDestinationPath:filename];
    
    
    [request setRequestHeaders:headers];
    [request startAsynchronous];
    

    
    
}

- (void) GetErr:(ASIHTTPRequest *)request{
    
    NSLog(@"服务器连接不上！");
    
    NSLog(@"%@", [request error]);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.listData.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *collectionCellID = @"ApplistCollectionViewCell";
    

    
    ApplistCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    NSDictionary *dic= [self.listData objectAtIndex:indexPath.row];
    NSString *title = [dic objectForKey:@"name"];
    cell.AppName.text=title;
    
    NSString *imgurl = [dic objectForKey:@"thumbnail_pic"];
    ID = [[dic objectForKey:@"id"]integerValue];
    [self loadDataId:imgurl];
    cell.AppImage.image=image;
    
    return cell;
  
};




-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *data = [self.listData objectAtIndex:indexPath.row];
    
    appDetailViewController *vc =[[appDetailViewController alloc]initWithNibName:@"appDetailViewController" bundle:nil];
    
    vc.data = data;
    [self presentViewController:vc animated:NO completion:nil];
    
    
}

- (IBAction)backBtn:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
