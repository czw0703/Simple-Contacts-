//
//  MyAddViewController.m
//  18_我的通讯录
//
//  Created by wxhl on 16-4-23.
//  Copyright (c) 2016年 wxhl. All rights reserved.
//

#import "MyAddViewController.h"
#import "MyMainModel.h"
@interface MyAddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UIButton *addBution;
@property (weak, nonatomic) IBOutlet UITextField *phion;

@end

@implementation MyAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//  两个文本框添加监听方法
    [self.name addTarget:self action:@selector(valueChange) forControlEvents:UIControlEventEditingChanged];
     [self.phion addTarget:self action:@selector(valueChange) forControlEvents:UIControlEventEditingChanged];
    
}
//点击添加按钮后调用
- (IBAction)buttonAction:(id)sender {
// 把文本框内容包装成数据模型
    MyMainModel *model=[MyMainModel contactWithName:_name.text withPhone:_phion.text];
    
    // 把联系人添加到联系人控制器的数组，让联系人控制器刷新表格
    if (_block) {
        _block(model);
    }
    
     [self.navigationController popViewControllerAnimated:YES];
}
//当两个文本框监听到自己文本宽有内容的时候
-(void)valueChange{
    if (self.name.text.length&&self.phion.text.length) {
        self.addBution.enabled=YES;//添加按钮为可点击状态
    }
}
//视图已经出现时候调用
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.name becomeFirstResponder];//让文本框成为第一响应者
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
