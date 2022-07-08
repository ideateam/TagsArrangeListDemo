//
//  ViewController.m
//  TagsArrangeListDemo
//
//  Created by mac on 2022/5/18.
//

#import "ViewController.h"
#import "TagsAarrangeListView.h"
#import <SDAutoLayout.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    double ScreenWidth = [UIScreen mainScreen].bounds.size.width;
    double contentWidth = (ScreenWidth - 12 - 12 - 10) / 2 + 200;
    TagsAarrangeListView *view = [[TagsAarrangeListView alloc] init];
    NSArray *titleArr = @[@"1件7.92折1",@"每20减2",@"每500减1003",@"返佣2元4",@"开发中为了测试能够快速看到效果5",@"返佣2元6",@"开发中为了测开发中为了测开发中为了测开发中为了测试能够快速看到效果7",@"开发中为了测试能够快速看到效果8",@"每500减1009",@"1件7.92折10",@"每200减2011",@"每500减10012",@"返佣2元13",@"开发中为了测试能够快速看到效果14",@"返佣2元15",@"开发中为了测试能够快速看到效果16",@"开发中为了测试能够快速看到效果17",@"每500减10018"];

    double height = [view calculateHeightWithParentContentWidth:contentWidth titleArr:titleArr];
    [view setUIWithParentContentWidth:contentWidth titleArr:titleArr];
    
    [self.view addSubview:view];
    view.backgroundColor = [UIColor orangeColor];
    
    view.sd_layout.leftSpaceToView(self.view, 0).topSpaceToView(self.view, 100).widthIs(contentWidth).heightIs(height);
    //视图
}


@end
