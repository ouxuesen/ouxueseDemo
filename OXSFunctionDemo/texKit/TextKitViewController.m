//
//  TextKitViewController.m
//  仿京东 月份选择
//
//  Created by 欧学森 on 16/5/30.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

#import "TextKitViewController.h"
#import "ShowMessageButton.h"
@interface TextKitViewController ()

@end

@implementation TextKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setAttributeStringLabel];
  
//    [self chageTextView];
//    [self htmlFilelaout];
    ShowMessageButton *buton = [[ShowMessageButton alloc] init];
    buton.frame = CGRectMake(0, 100, 100, 30);
    buton.backgroundColor = [UIColor redColor];
    [self.view addSubview:buton];
    
    buton.beginBlock = ^{
        
    };
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//html文件的
-(void)htmlFilelaout
{
//    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"新浪首页.html" ofType:nil]];
    NSURL *url = [NSURL URLWithString:@"http://www.cocoachina.com/ios/20161021/17808.html"];
//    http://test.jr.letv.com/leplatform/finance-news-detail-app.html?id=1028
    NSError * error ;
//    UIWebView * webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, WINDOW_WIDTH, WINDOW_HEIGHT - 64)];
//    webview.scalesPageToFit = YES;
//    [webview loadRequest:[NSURLRequest requestWithURL:url]];
    
    NSTextStorage * strongtext = [[NSTextStorage alloc]initWithData:[NSData dataWithContentsOfURL:url] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}  documentAttributes:nil error:&error];
    UITextView * hemlTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 64, WINDOW_WIDTH, WINDOW_HEIGHT - 64) textContainer:nil];
    NSLog(@"error = %@",error);
    hemlTextView.editable = NO;
     [hemlTextView setAttributedText:strongtext];
    [self.view addSubview:hemlTextView];
    
//    NSTextContainer * textContainer_1 = [[NSTextContainer alloc]initWithSize:CGSizeMake(WINDOW_WIDTH, WINDOW_HEIGHT)];
//    [layoutManager addTextContainer:textContainer_1];
//    UITextView * hemlTextView_1 = [[UITextView alloc]initWithFrame:CGRectMake(0, WINDOW_HEIGHT -64, WINDOW_WIDTH, 100 )textContainer:textContainer_1];
//    NSLog(@"error = %@",error);
//    hemlTextView_1.editable = NO;
//    hemlTextView_1.scrollEnabled = YES;
//    //     [hemlTextView setAttributedText:strongtext];
//    [self.view addSubview:hemlTextView_1];
    
//    UIWebView * webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, WINDOW_WIDTH, WINDOW_HEIGHT - 64)];
//    webview.scalesPageToFit = YES;
//    [webview loadRequest:[NSURLRequest requestWithURL:url]];
//    [self.view addSubview:webview];
}
-(void)setAttributeStringLabel{
    NSString *str = @"bold，little color，hello";
    self.label.backgroundColor = [UIColor redColor];
    //NSMutableAttributedString的初始化
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]};
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:str attributes:attrs];
    
    //NSMutableAttributedString增加属性
    [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:36] range:[str rangeOfString:@"bold"]];
    
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:[str rangeOfString:@"little color"]];
    
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Papyrus" size:36] range:NSMakeRange(18,5)];
    
    [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18] range:[str rangeOfString:@"little"]];
    [attributedString addAttribute:NSUnderlineStyleAttributeName value:
     [NSNumber numberWithInteger:NSUnderlineStyleNone| NSUnderlinePatternDot] range:[str rangeOfString:@"little"]];
    //NSMutableAttributedString移除属性
    [attributedString removeAttribute:NSFontAttributeName range:[str rangeOfString:@"little"]];
    
    //NSMutableAttributedString设置属性
    NSDictionary *attrs2 = @{NSStrokeWidthAttributeName:@-3,
//                             NSStrokeColorAttributeName:[UIColor greenColor],
//                             NSFontAttributeName:[UIFont systemFontOfSize:36],
                             NSUnderlineStyleAttributeName:@(NSUnderlineStyleNone|NSUnderlinePatternDot)};
    [attributedString setAttributes:attrs2 range:NSMakeRange(0, 4)];
    
    self.label.attributedText = attributedString;
    [self.label sizeToFit];
}
-(void)chageTextView
{
    //OS提供了六种样式：标题，正文，副标题，脚注，标题1，标题2。例如：
    _textView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    NSString * text = @"Textkit是iOS7新推出的类库，其实是在之前推出的CoreText上的封装，有了这个TextKit，以后不用再拿着CoreText来做累活了，根据苹果的说法，他们开发了两年多才完成，而且他们在开发时候也将表情混排作为一个使用案例进行研究，所以要实现表情混排将会非常容易。 TextKit并没有新增的类，他是在原有的文本显示控件上的封装，可以使用平时我们最喜欢使用的UILabel，UITextField，UITextView里面就可以使用了。1.NSAtrributedString这是所有TextKit的载体，所有的信息都会输入到NSAttributedString里面，然后将这个String输入到Text控件里面就可以显示了。2.NSTextAttachmentiOS7新增的类，作为文本的附件，可以放文件，可以放数据，以 NSAttachmentAttributeName这个key放入NSAttributedString里面，在表情混排这里，我们将放入image。3.重载NSTextAttachment本来是可以直接使用NSTextAttachment，但是我们需要根据文字大小来改变表情图片的大小，于是我们需要重载NSTextAttachment，NSTextAttachment实现了NSTextAttachmentContainer，可以给我们改变返回的图像，图像的大小。重载NSTextAttachment代码：";
    CGRect ovalFrame = [self.textView convertRect:self.circleVie.bounds fromView:self.textView];
    NSTextStorage *sharedTextStorage = _textView.textStorage;
   
  [sharedTextStorage replaceCharactersInRange:NSMakeRange(0, 0) withString:text];
   [sharedTextStorage addAttributes:@{ NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(0, text.length)];
    // 将一个新的 Layout Manager 附加到上面的 Text Storage 上
    NSLayoutManager *otherLayoutManager = [NSLayoutManager new];
    
    [sharedTextStorage addLayoutManager: otherLayoutManager];
    
//    CircleTextContainer *textContainer = [[CircleTextContainer alloc] initWithSize:textViewFrame.size];
//    [textContainer setExclusionPaths:@[ [UIBezierPath bezierPathWithOvalInRect:CGRectMake(80, 120, 50, 50)]]];

    [self.textView.textContainer setExclusionPaths:@[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(10, 10, 50, 50)]]];

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
