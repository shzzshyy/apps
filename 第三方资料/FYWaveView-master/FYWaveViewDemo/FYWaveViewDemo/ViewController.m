//
//  ViewController.m
//  FYWaveViewDemo
//
//  Created by 曹运 on 2016/11/20.
//  Copyright © 2016年 曹运. All rights reserved.
//

#import "ViewController.h"
#import "FYWaveProgressController.h"
#import "FYTopViewController.h"
#import "FYUserPhotoController.h"
@interface ViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSArray *titleArray;
@end

@implementation ViewController
- (NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@"波浪进度条",@"顶部波浪线(仿淘宝)",@"头像随波浪浮动"];
    }
    return _titleArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSInteger row = indexPath.row;
    switch (row) {
        case 0:
        {
            [self.navigationController pushViewController:[FYWaveProgressController new] animated:YES];
        }
            break;
        case 1:
        {
            [self.navigationController pushViewController:[FYTopViewController new] animated:YES];
        }
            break;
        case 2:
        {
            [self.navigationController pushViewController:[FYUserPhotoController new] animated:YES];
        }
            break;
            
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
