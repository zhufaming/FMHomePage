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

@property (strong, nonatomic)  UIImageView *topImgV;

@property (nonatomic, assign) CGFloat alphaMemory;

@end

@implementation FMHomeViewController
static NSString *const Identfier=@"TableCellID";


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView *headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, 300)];
    headerView.backgroundColor=[UIColor clearColor];
    self.mainTableView.tableHeaderView=headerView;
    
    self.topImgV=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, 300)];
    self.topImgV.image=[UIImage imageNamed:@"meinv"];
    [self.view insertSubview:self.topImgV belowSubview:self.mainTableView];
    self.topImgV.contentMode=UIViewContentModeScaleAspectFill;
    self.topImgV.clipsToBounds=YES;
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:37.0/255 green:180.0/255 blue:237.0/255 alpha:1]];
   // self.navigationController.navigationBar.hidden=YES;
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:_alphaMemory];
    
    //    [self.navigationItem.leftBarButtonItem setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -100) forBarMetrics:UIBarMetricsDefault];
    
    //    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    
    if (_alphaMemory == 0) {
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    }
    else {
        self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    }

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
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    CGRect frame=self.topImgV.frame;
   
    if (offsetY>=0) {
        
        frame.origin.y=-offsetY;
        //重新赋值 frame
        self.topImgV.frame=frame;
        if (offsetY<=300) {
            self.navigationController.navigationBar.tintColor = [UIColor blackColor];
            
            _alphaMemory = offsetY/(300) >= 1 ? 1 : offsetY/(300);
            
            [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:_alphaMemory];
            
        }else if (offsetY>300){
            
            _alphaMemory = 1;
            [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
            
        }
        
       
    }else{
        
        _topImgV.transform =  CGAffineTransformMakeScale(1 + offsetY/(-300), 1 + offsetY/(-300));
        CGRect frame1=self.topImgV.frame;
        frame1.origin.y = 0;
        self.topImgV.frame=frame1;
    }
  
    

}



@end
