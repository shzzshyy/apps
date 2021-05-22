//
//  ViewController.m
//  带小数点数字键盘
//
//  Created by IOS on 16/8/12.
//  Copyright © 2016年 琅琊榜. All rights reserved.
//

#import "ViewController.h"
#import "RYNumberKeyboard.h"
@interface ViewController ()<UITextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITextField *myText=[[UITextField alloc]initWithFrame:CGRectMake((self.view.frame.size.width-200)/2, 100, 200, 40)];
    myText.keyboardType = UIKeyboardTypeEmailAddress;
    myText.delegate=self;
    myText.placeholder=@"带小数点的键盘";
    myText.clearButtonMode=UITextFieldViewModeWhileEditing;
    myText.textAlignment=NSTextAlignmentLeft;
    myText.layer.borderColor=[UIColor grayColor].CGColor;
    myText.layer.borderWidth=1;
    myText.layer.masksToBounds=YES;
    myText.layer.cornerRadius=4;
    [self.view addSubview:myText];
    
    [myText addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventAllEvents];
 
    
//    RYNumberKeyboard *tNumberKb = [[RYNumberKeyboard alloc] init];
//    tNumberKb.textFiled = myText;
//
//    myText.inputView = tNumberKb;
    
}
- (void)textChange:(UITextField*)textfield{
     NSLog(@"~~~~%@",textfield.text);
}


@end
