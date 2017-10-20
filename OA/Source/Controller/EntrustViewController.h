//
//  EntrustViewController.h
//  
//
//  Created by admin on 15/12/28.
//
//

#import <UIKit/UIKit.h>

@interface EntrustViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{

    NSMutableArray * selectUserArray;
    NSMutableArray * selectDocArray;
}

@property (strong, nonatomic) NSArray *list;

@property (strong, nonatomic) IBOutlet UIView *topMenuView;

- (IBAction)backBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *sendBtn;
- (IBAction)sendClick:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *tabview;
@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) UILabel *starLabel;
@property (strong, nonatomic) UILabel *endLabel;
@property (strong, nonatomic) UILabel *userLabel;
@property (strong, nonatomic) UIImageView *startime;
@property (strong, nonatomic) UIImageView *endtime;
@property (strong, nonatomic) UIImageView *people;
@property (strong, nonatomic) NSString *flowid;
@property (strong, nonatomic) NSMutableArray * selectEntArray;


@end
