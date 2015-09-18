//
//  ViewController.m
//  CoreParser
//
//  Created by baidu on 15/9/17.
//  Copyright © 2015年 dzpqzb. All rights reserved.
//

#import "ViewController.h"
#import "CPParser.h"
#import "CPToken.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CPParser* parser = [CPParser new];
    
    NSArray* tokens = [parser parserWithString:@"(xxxdukajhhkdfhjsjhdhfhjasdfj+xxx-cos(333)*33);" error:nil];
    
    for (CPToken* t  in tokens) {
        NSLog(@"%@",t.text);
    }

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
