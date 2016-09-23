//
//  AddressEditTableController.m
//  BEE QUICK
//
//  Created by 侯仕奇 on 16/9/9.
//  Copyright © 2016年 HSQI. All rights reserved.
//

#import "AddressEditTableController.h"
#import "AddressEditNormalTableCell.h"
#import "AddressEditSelectTableCell.h"
#import "AddressEditDeleteTableCell.h"


@interface AddressEditTableController () <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UIAlertViewDelegate>

@property(nonatomic,weak)UITextField *secfield;

@property(nonatomic,strong)UIPickerView *cityPickerView;

@property(nonatomic,strong)UIToolbar *myToolbar;

@property(nonatomic,strong)NSArray *nameArray;

@end

@implementation AddressEditTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 导航栏标题
    self.navigationItem.title = @"修改地址";
    // 左上角返回按钮渲染颜色
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    // 右上角'保存'按钮
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    // 注册cell
    [self registerCell];
    
    // 初始化pickerView & toolbar
    [self loadPickerViewAndToolbar];

}
// 注册cell
- (void)registerCell {
    [self.tableView registerNib:[UINib nibWithNibName:@"AddressEditNormalTableCell" bundle:nil] forCellReuseIdentifier:@"cellid_normal"];
    [self.tableView registerClass:[AddressEditDeleteTableCell class] forCellReuseIdentifier:@"cellid_delete"];
    [self.tableView registerNib:[UINib nibWithNibName:@"AddressEditSelectTableCell" bundle:nil] forCellReuseIdentifier:@"cellid_select"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 6;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // delete button
    if (indexPath.section == 1) {
        AddressEditDeleteTableCell *cell_delete = [tableView dequeueReusableCellWithIdentifier:@"cellid_delete" forIndexPath:indexPath];
        // 添加监听
        [cell_delete.deleteBtn addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        
        return cell_delete;
    }
    // sex select
    if (indexPath.row == 1) {
        AddressEditSelectTableCell *cell_select = [tableView dequeueReusableCellWithIdentifier:@"cellid_select" forIndexPath:indexPath];
        if (_model.isMan == 0) {
            [cell_select.manBtn setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateNormal];
            [cell_select.womanBtn setImage:[UIImage imageNamed:@"未勾选"] forState:UIControlStateNormal];
        } else {
            [cell_select.manBtn setImage:[UIImage imageNamed:@"未勾选"] forState:UIControlStateNormal];
            [cell_select.womanBtn setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateNormal];
        }
        
        return cell_select;
    }
    // normal cell
    AddressEditNormalTableCell *cell_normal = [tableView dequeueReusableCellWithIdentifier:@"cellid_normal" forIndexPath:indexPath];

    switch (indexPath.row) {
        case 0:
            cell_normal.firLabel.text = @"联系人";
            cell_normal.secfield.text = _model.name;
            break;

        case 2:
            cell_normal.firLabel.text = @"手机号码";
            cell_normal.secfield.text = _model.number;
            cell_normal.secfield.keyboardType = UIKeyboardTypeNumberPad;
            break;
        case 3:
            cell_normal.firLabel.text = @"所在城市";
            cell_normal.secfield.text = _model.city;
            self.secfield = cell_normal.secfield;
            cell_normal.secfield.delegate = self;
            cell_normal.secfield.inputView = self.cityPickerView;
            cell_normal.secfield.inputAccessoryView = self.myToolbar;
            break;
        case 4:
            cell_normal.firLabel.text = @"所在地区";
            cell_normal.secfield.text = _model.region;
            break;
        case 5:
            cell_normal.firLabel.text = @"详细地址";
            cell_normal.secfield.text = _model.address;
            break;
            
        default:
            break;
    }
    
    
    return cell_normal;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 12;
}

#pragma mark - selector

- (void)saveClick {
    // 保存数据到模型
    AddressEditNormalTableCell *cell1 = (AddressEditNormalTableCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    _model.name = cell1.secfield.text;
    
    AddressEditSelectTableCell *cell2 = (AddressEditSelectTableCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    _model.isMan = cell2.sexRecord;
    
    AddressEditNormalTableCell *cell3 = (AddressEditNormalTableCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    _model.number = cell3.secfield.text;
    
    AddressEditNormalTableCell *cell4 = (AddressEditNormalTableCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    _model.city = cell4.secfield.text;
    
    AddressEditNormalTableCell *cell5 = (AddressEditNormalTableCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    _model.region = cell5.secfield.text;
    
    AddressEditNormalTableCell *cell6 = (AddressEditNormalTableCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    _model.address = cell6.secfield.text;
    
    
    
    // 逆向传递数据
    _saveBlock(_model);
    // 回跳
    [self.navigationController popViewControllerAnimated:YES];

    
}

// deleteBtn
- (void)deleteClick {
    
    
    // 回跳
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"数据删除后不可恢复,是否确认?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    

}

#pragma mark - 初始化_cityPickerView & _myToolbar

- (void)loadPickerViewAndToolbar {
    
    /* ------ pickerView ------ */
    
    self.nameArray = [NSArray arrayWithObjects:@"qfeung", @"十万大山", @"通辽", @"南疆", @"上海", @"广州", @"深圳", @"重庆", @"武汉", @"天津", nil];
    
    // 创建pickerView
    self.cityPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 200)];
    self.cityPickerView.backgroundColor = [UIColor lightGrayColor];
    
    // 代理 & 数据源 ------ cityPickerView
    self.cityPickerView.delegate = self;
    self.cityPickerView.dataSource = self;
    
    /* ------ tool bar ------ */
    
    UIBarButtonItem *doneBBI = [[UIBarButtonItem alloc]
                                initWithTitle:@"确定"
                                style:UIBarButtonItemStyleDone
                                target:self
                                action:@selector(doneClick)];

    UIBarButtonItem *cancelBBI = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelClick)];
    UIBarButtonItem *flexibleBBI = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    self.myToolbar = [[UIToolbar alloc]initWithFrame:
                      CGRectMake(0, self.view.frame.size.height-
                                 self.cityPickerView.frame.size.height-20, self.view.bounds.size.width, 40)];
    [self.myToolbar setBarStyle:UIBarStyleBlackOpaque];
    NSArray *toolbarItems = [NSArray arrayWithObjects:cancelBBI, flexibleBBI, doneBBI, nil];
    [self.myToolbar setItems:toolbarItems];
    
}

#pragma mark - Picker view data source

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _nameArray.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 30;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.view.bounds.size.width;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    if (!view) {
        view = [[UIView alloc] init];
    }
    UILabel *textlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
    textlabel.textAlignment = NSTextAlignmentCenter;
    textlabel.text = _nameArray[row];
    textlabel.font = [UIFont systemFontOfSize:19];
    [view addSubview:textlabel];
    return view;
}

// didSelectRow
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.secfield.text = self.nameArray[row];
}

#pragma mark - tool bar 上按钮的点击事件

- (void)doneClick {
    if ( [self.secfield isFirstResponder] ) {
        [self.secfield resignFirstResponder];
    }
}

- (void)cancelClick {
    [self doneClick];
}

#pragma mark - UIAlertViewDelegate

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 1:
            _deleteBlock(_indexRow);
            
            [self.navigationController popViewControllerAnimated:YES];
            break;
            
        default:
            break;
    }
}

// Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
// If not defined in the delegate, we simulate a click in the cancel button
- (void)alertViewCancel:(UIAlertView *)alertView {
    
}

@end
