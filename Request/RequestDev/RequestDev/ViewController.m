//
//  ViewController.m
//  RequestDev
//
//  Created by jilei on 2017/6/6.
//
//

#import "ViewController.h"
#import <RequestSDK/RequestTool.h>
#import "LoginModel.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [LoginModel Login];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
