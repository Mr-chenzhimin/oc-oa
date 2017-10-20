//
//  DocexReplyViewController.h
//  hongdabaopo
//
//  Created by admin on 14-8-2.
//  Copyright (c) 2014年 dengfan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DocexReplyViewController : UIViewController<UITextViewDelegate>{
    NSMutableArray * dataArray;
    NSMutableArray * optiondata;
   // UIButton *_loginBtn;
    
}

//@property (strong,nonatomic)UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *filebtnset;

@property (weak, nonatomic) IBOutlet UITextField *FileName;

- (IBAction)FileBtnUpdata:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *replytext;

@property (nonatomic,strong) NSString * Replyid;

@property (nonatomic,strong) IBOutlet UIView * topMenuView;
-(IBAction)backgroundClick:(id)sender;

- (IBAction)returnbtnclick:(id)sender;


- (IBAction)finishbtn:(id)sender;

@end
