//
//  MyListViewController.m
//  18_我的通讯录
//
//  Created by wxhl on 16-4-21.
//  Copyright (c) 2016年 wxhl. All rights reserved.
//

#import "MyListViewController.h"
#import "MyAddViewController.h"
#import "MyMainModel.h"
#import "MyEditViewController.h"

#define myFilePath [ NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"myMainModel.data"]

@interface MyListViewController ()<UIActionSheetDelegate>
@property (nonatomic, strong) NSMutableArray *models;
@end

@implementation MyListViewController
- (NSMutableArray *)models
{
    if (_models == nil) {
        
        // 读取数据
        _models = [NSKeyedUnarchiver unarchiveObjectWithFile:myFilePath];
        
        // 判断下有没有读取数据
        if (_models == nil) {
            _models = [NSMutableArray array];
        }
        
        
    }
    return _models;
}
//点击注销按钮
- (IBAction)cancelAction:(id)sender {
    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:@"是否注销" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"注销" otherButtonTitles:nil, nil];
    [sheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//跳转之前调用
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    // 给添加控制器传递联系人控制器属性，这个联系人控制器就是当前所在的控制器
    MyAddViewController *myAddVc=segue.destinationViewController;
    
// block传值
    myAddVc.block = ^(MyMainModel *myModel){
        
        // 1.联系人添加到数组
        [self.models addObject:myModel];
        
        
        // 2.刷新表格
        [self.tableView reloadData];//先刷新表格编辑改后的数据会存档，下次进来时会是编辑后的数据
        
        // 3.保存联系人,注意：如果归档数组，底层会遍历数组元素一个一个归档
        [NSKeyedArchiver archiveRootObject:self.models toFile:myFilePath];
        
    };
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // tableView有数据的时候才需要分割线
    
    // 开发小技巧:快速取消分割线
    self.tableView.tableFooterView = [[UIView alloc] init];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
   
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *str=@"asdfg";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
        
    }
    
    MyMainModel *model=self.models[indexPath.row];
    cell.textLabel.text=model.name;
    cell.detailTextLabel.text=model.phone;
    
    return cell;
}
//点击单元格时调用
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
// 加载storybord，因为MyEditViewController控制器是在storybord中创建的
    UIStoryboard *storybord=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
// 在storybord中根据标识符创建MyEditViewController控制器
    MyEditViewController *editVc=[storybord instantiateViewControllerWithIdentifier:@"edit"];
    
    editVc.data=self.models[indexPath.row];//顺传数据
    
    editVc.block=^(){
        [self.tableView reloadData];//在来源控制器中点击按钮后调用block,block中执行的内容是刷新数据
        
        //先刷新表格编辑改后的数据会存档，下次进来时会是编辑后的数据
        
        // 3.保存联系人,注意：如果归档数组，底层会遍历数组元素一个一个归档
         [NSKeyedArchiver archiveRootObject:self.models toFile:myFilePath];
    };
    
    [self.navigationController pushViewController:editVc animated:YES];
    
}

//左化编辑数据时会调用这个方法（系统自动出现一个删除按钮）
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
//  这里不写在下面自定义一个
   
    //   点击按钮要做的事情
    
//    // 删除模型数据
//    [self.models removeObjectAtIndex:indexPath.row];
//    
//    // 删除tableViewCell
//    
//    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//
}
-(NSArray*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        // 点击增加的时候调用
        NSLog(@"删除");
        //   点击按钮要做的事情
        
        // 删除模型数据
        [self.models removeObjectAtIndex:indexPath.row];
        
        // 删除tableViewCell
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }];
    
    
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"置顶" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        // 点击增加的时候调用
        NSLog(@"置顶");
        
//  更新调换数据
        [self.models exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
//   更新UI
        NSIndexPath *firstIndexPath =[NSIndexPath indexPathForRow:0 inSection:indexPath.section];
        [tableView moveRowAtIndexPath:indexPath toIndexPath:firstIndexPath];
       
//   刷新单元格
        [self.tableView reloadData];
        
    }];
    action.backgroundColor = [UIColor lightGrayColor];
    
// 数组中第一个元素对应最右边的按钮
    return @[action1,action];

    
}
@end
