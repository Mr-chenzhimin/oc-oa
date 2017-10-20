//
//  DocexContextViewController.m
//  hongdabaopo
//
//  Created by admin on 14-8-1.
//  Copyright (c) 2014年 dengfan. All rights reserved.
//

#import "DocexContextViewController.h"

@interface DocexContextViewController ()
{
    float app_width;
    float app_height;
}

@end

@implementation DocexContextViewController


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
//    if(iPhone5){
//        app_width = 320;
//        app_height = 363;
//    }else{
//        app_width = 320;
//        app_height = 480;
//        
//        CGRect bodyFrame = self.contextTxt.frame;
//        bodyFrame.size.height = app_height;
//        self.contextTxt.frame = bodyFrame;
//    }

    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[self.docexContext dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    self.contextTxt.attributedText=attributedString;
    self.contextTxt.editable = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
