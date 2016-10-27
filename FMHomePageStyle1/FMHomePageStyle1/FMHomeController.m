//
//  FMHomeController.m
//  FMHomePageStyle1
//
//  Created by zhufaming on 2016/10/27.
//  Copyright © 2016年 zhufaming. All rights reserved.
//

#import "FMHomeController.h"
#import "TableCell.h"

@interface FMHomeController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *mainTableView;
//tableVIiew header
@property (strong, nonatomic) IBOutlet UIView *headerView;

@property (nonatomic, strong) UIImageView * topImageView;

@property (nonatomic, assign) CGFloat receiveAlpha;

@end

@implementation FMHomeController
static NSString *const Identfier=@"TableCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mainTableView.tableHeaderView=_headerView;
    
    UIView * topBkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 78, 44)];
    topBkView.backgroundColor = [UIColor clearColor];
    
    _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 78, 78)];
    _topImageView.backgroundColor = [UIColor whiteColor];
    _topImageView.layer.cornerRadius = _topImageView.bounds.size.width / 2.;
    _topImageView.layer.masksToBounds = YES;
    _topImageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    _topImageView.image = [UIImage imageNamed:@"header"];
    [topBkView addSubview:_topImageView];
    
    self.navigationItem.titleView = topBkView;

    
    
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

#pragma mark - 滑动代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    // NSLog(@"%f",scrollView.contentOffset.y );
    
    CGFloat offsetY = scrollView.contentOffset.y;//注意
    NSLog(@"%f",offsetY);
    
    if (offsetY < 0 && offsetY >= -80) {
        _topImageView.transform = CGAffineTransformMakeScale(1 + offsetY/(-160), 1 + offsetY/(-160));
        //        _topImageView.layer.anchorPoint = CGPointMake(0.5, offsetY/600. + 0.5);
        //        NSLog(@"%lf - %lf", offsetY, 1 + offsetY/(-300));
    }
    else if (offsetY >= 0 && offsetY <= 80) {
        _topImageView.transform = CGAffineTransformMakeScale(1 - offsetY/160, 1 - offsetY/160);
        //        _topImageView.layer.anchorPoint = CGPointMake(0.5, 0.5 + offsetY/600.);
    }
    else if (offsetY > 80) {
        _topImageView.transform = CGAffineTransformMakeScale(0.45, 0.45);
        //        _topImageView.layer.anchorPoint = CGPointMake(0.5, 1);
    }
    else if (offsetY < -80) {
        _topImageView.transform = CGAffineTransformMakeScale(1.5, 1.5);
        //        _topImageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    }
    
    CGRect frame = _topImageView.frame;
    frame.origin.y = 0;
    _topImageView.frame = frame;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
