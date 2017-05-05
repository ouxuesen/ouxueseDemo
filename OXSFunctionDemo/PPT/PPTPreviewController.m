//
//  PPTPreviewController.m
//  OXSFunctionDemo
//
//  Created by ouxuesen on 2017/4/24.
//  Copyright © 2017年 ouxuesen. All rights reserved.
//

#import "PPTPreviewController.h"

@interface PPTPreviewController ()<QLPreviewControllerDelegate,QLPreviewControllerDataSource>

@end
@implementation PPTPreviewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
-(void)viewDidLoad
{
    self.delegate  = self;
    self.dataSource = self;
}

- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index

{
    if (index) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Sampleclass" ofType:@"pptx"];//需要在线预览的文件
        
        return [NSURL fileURLWithPath:path];
    }else{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"教师APP" ofType:@"pdf"];//需要在线预览的文件
        
        return [NSURL fileURLWithPath:path];
    }

    
}
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller

{
    
    return 2;
}

@end
