//
//  AddressAddTableController.m
//  BEE QUICK
//
//  Created by 侯仕奇 on 16/9/10.
//  Copyright © 2016年 HSQI. All rights reserved.
//

#import "AddressAddTableController.h"
#import "AddressEditSelectTableCell.h"
#import "AddressEditNormalTableCell.h"

@interface AddressAddTableController () <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>

@property(nonatomic,weak)UITextField *secfield;

@property(nonatomic,strong)UIPickerView *cityPickerView;

@property(nonatomic,strong)UIToolbar *myToolbar;

@property(nonatomic,strong)NSArray *nameArray;

@end

@implementation AddressAddTableController 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // register cell
    [self registerCell];
    
    // 初始化pickerView & toolbar
    [self loadPickerViewAndToolbar];
}


#pragma mark - 加载选择器&toolbar

- (void)loadPickerViewAndToolbar {
    
    // --- pickerView ---
    
    self.nameArray = [NSArray arrayWithObjects:@"qfeung", @"十万大山", @"通辽", @"南疆", @"上海", @"广州", @"深圳", @"重庆", @"武汉", @"天津", nil];
    
    // 创建pickerView
    self.cityPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 200)];
    self.cityPickerView.backgroundColor = [UIColor lightGrayColor];
    
    // 代理
    self.cityPickerView.delegate = self;
    self.cityPickerView.dataSource = self;
    
    // --- tool bar ---
    
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
/**
 //- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
 //    NSString *str = [NSString stringWithString:_nameArray[row]];
 //    return str;
 //}
 */// <???>不知道有什么用?
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

// register
- (void)registerCell {
    [self.tableView registerNib:[UINib nibWithNibName:@"AddressEditNormalTableCell" bundle:nil] forCellReuseIdentifier:@"cellid_normal"];
    [self.tableView registerNib:[UINib nibWithNibName:@"AddressEditSelectTableCell" bundle:nil] forCellReuseIdentifier:@"cellid_select"];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // sex select
    if (indexPath.row == 1) {
            AddressEditSelectTableCell *cell_select = [tableView dequeueReusableCellWithIdentifier:@"cellid_select" forIndexPath:indexPath];
        
        return cell_select;
    }
    // normal cell
    AddressEditNormalTableCell *cell_normal = [tableView dequeueReusableCellWithIdentifier:@"cellid_normal" forIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:
            cell_normal.firLabel.text = @"联系人";
            cell_normal.secfield.placeholder = @"收货人姓名";
            break;
        case 2:
            cell_normal.firLabel.text = @"手机号码";
            cell_normal.secfield.placeholder = @"蜜蜂侠联系你的电话";
            cell_normal.secfield.keyboardType = UIKeyboardTypeNumberPad; 
            break;
        case 3:
            cell_normal.firLabel.text = @"所在城市";
            cell_normal.secfield.placeholder = @"请选择城市";
            
            cell_normal.secfield.delegate = self;
            
            cell_normal.secfield.inputView = self.cityPickerView;
            cell_normal.secfield.inputAccessoryView = self.myToolbar;
            
            self.secfield = cell_normal.secfield;
            
            break;
        case 4:
            cell_normal.firLabel.text = @"所在地区";
            cell_normal.secfield.placeholder = @"请选择你的住宅,大厦或学校";
            break;
        case 5:
            cell_normal.firLabel.text = @"详细地址";
            cell_normal.secfield.placeholder = @"请输入楼号门牌号等详细信息";
            break;
            
        default:
            break;
    }
    
    // Configure the cell...
    
    
    return cell_normal;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 12;
}



#pragma mark - Text field delegates

//-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    if ([textField.text isEqualToString:@""]) {
    
        
        // 加载pickerView
//        [self.addressAddVC loadPickerViewAndToolbar];
//        self.addressAddVC.pickerView.hidden = NO;
//        self.addressAddVC.toolBar.hidden = NO;
//    }
//    [self.addressAddVC.mytextField becomeFirstResponder];
//}


#pragma mark - tool bar 上按钮的点击事件

- (void)doneClick {
    if ( [self.secfield isFirstResponder] ) {
        [self.secfield resignFirstResponder];
    }
}

- (void)cancelClick {
    [self doneClick];
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//}

@end
