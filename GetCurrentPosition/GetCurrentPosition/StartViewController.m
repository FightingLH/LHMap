//
//  StartViewController.m
//  GetCurrentPosition
//
//  Created by lh on 16/8/26.
//  Copyright © 2016年 lh. All rights reserved.
//

#import "StartViewController.h"
#import "ViewController.h"
#import "ViewController01.h"
#import "ViewController02.h"
@interface StartViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataArray;//数组
@end

@implementation StartViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self prepareDataArray];
    [self uiConfig];
    // Do any additional setup after loading the view.
}

#pragma mark -数组
-(void)prepareDataArray{
    self.dataArray = @[@"使用时定位(自定义大头针)",@"固定点路径规划(自定义大头针)",@"前后台定位(并且传事实位置)",@"通过位置进行导航"];
}

-(void)uiConfig{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {//前后台定位并且上传实时位置
        ViewController *v1 = [[ViewController alloc]init];
        [self.navigationController pushViewController:v1 animated:YES];
    }else if(indexPath.row == 1){
        ViewController01 *v1 = [[ViewController01 alloc]init];
        [self.navigationController pushViewController:v1 animated:YES];
    }else if(indexPath.row == 3){
        ViewController02 *v2 = [[ViewController02 alloc]init];
        [self.navigationController pushViewController:v2 animated:YES];
    }
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
