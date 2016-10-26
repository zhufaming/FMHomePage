//
//  FMHomeViewController.m
//  FMHomePage
//
//  Created by zhufaming on 2016/10/26.
//  Copyright © 2016年 zhufaming. All rights reserved.
//

#import "FMHomeViewController.h"
#import "TableCell.h"

#define SCR_WIDTH   [UIScreen mainScreen].bounds.size.width

@interface FMHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *mainTableView;

@property (strong, nonatomic) IBOutlet UIView *topView;

@property (strong, nonatomic)  UIImageView *topImgV;

@end

@implementation FMHomeViewController
static NSString *const Identfier=@"TableCellID";


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView *headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, 200)];
    headerView.backgroundColor=[UIColor clearColor];
    self.mainTableView.tableHeaderView=headerView;
    
    self.topImgV=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, 200)];
    self.topImgV.image=[UIImage imageNamed:@"meinv"];
    [self.topView addSubview:self.topImgV];
    self.topImgV.contentMode=UIViewContentModeScaleAspectFill;
    self.topImgV.clipsToBounds=YES;
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor lightGrayColor]];
   // self.navigationController.navigationBar.hidden=YES;
     [self.navigationController setNavigationBarHidden:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TableCell *cell=[tableView dequeueReusableCellWithIdentifier:Identfier forIndexPath:indexPath];
    return cell;
    
}

 //MARK: tableView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSLog(@"%.f",_mainTableView.contentOffset.y);
    
    CGRect frame=self.topView.frame;
   
    
    if (_mainTableView.contentOffset.y>=0) {
        
        frame.origin.y=-(_mainTableView.contentOffset.y);
        
        if (_mainTableView.contentOffset.y>136) {
            
            [self.navigationController setNavigationBarHidden:NO];
        }
        
    }else{
        
        
        frame.size.height=200-(_mainTableView.contentOffset.y);
        [self.navigationController setNavigationBarHidden:YES];

        
        
    }
    
    _topView.frame=frame;
    
    CGRect frame1=self.topImgV.frame;
    frame1.size.width=frame.size.width;
    frame1.size.height=frame.size.height;
    
    self.topImgV.frame=frame1;
    

}



@end
