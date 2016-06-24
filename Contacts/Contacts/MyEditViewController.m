//
//  MyEditViewController.m
//  18_我的通讯录
//
//  Created by wxhl on 16-4-24.
//  Copyright (c) 2016年 wxhl. All rights reserved.
//

#import "MyEditViewController.h"
#import "MyListViewController.h"
@interface MyEditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UIButton *save;

@end

@implementation MyEditViewController
//重写set方法调用模型
-(void)setData:(MyMainModel *)data{
    _data=data;
}
- (void)viewDidLoad {
    [super viewDidLoad];
// 创建导航栏和右边编辑按钮
    self.title=@"查看/编辑联系人";
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"编辑" style: UIBarButtonItemStyleDone target:self action:@selector(buttonAction:)];
    
// 将模型数据给文本框
    self.name.text=_data.name;
    self.phone.text=_data.phone;
    
}


-(void)buttonAction:(UIBarButtonItem*)item{
// 实现点击编辑按钮时按钮字变为“取消”且弹出键盘
    if ([item.title isEqualToString:@"编辑"]) {
        self.name.enabled=YES;
        self.phone.enabled=YES;
        item.title=@"取消";
        [_name becomeFirstResponder];
        
        
        _save.hidden=NO;//按钮显示出来
    }else{
        item.title=@"编辑";//当点击取消按钮时文本框不可编辑，没保存的数据还原为编辑之前数据
        
        [self.view endEditing:YES];
        self.name.enabled=NO;
        self.phone.enabled=NO;
        self.name.text=_data.name;
        self.phone.text=_data.phone;

        _save.hidden=YES;//按钮还原隐藏状态
    }
    
}
- (IBAction)saveAction:(id)sender {
   
 //点击按钮时数据重新赋给模型
    _data.name=_name.text;
    _data.phone=_phone.text;
    
    if (_block) {
        _block();
    }//点击按钮时调用block 让block做事情
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
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
