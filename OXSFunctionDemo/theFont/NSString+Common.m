//  Created by chen ying on 12-11-6.

#import "NSString+Common.h"

//引入IOS自带密码库
#import <CommonCrypto/CommonCryptor.h>


@implementation NSObject (Common)
- (NSString *)json
{
    NSString *jsonStr = @"";
    @try {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
        jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    @catch (NSException *exception) {
        NSLog(@"%s [Line %d] 对象转换成JSON字符串出错了-->\n%@",__PRETTY_FUNCTION__, __LINE__,exception);
    }
    @finally {
    }
    return jsonStr;
}
@end

//产品标
@implementation NSString (ProductPropertiesType)
//1、产品标（第一位：新手专享，第二位：内部员工专享，第三位:一般理财，第四位：Ios专享测试，第五位：冠军理财包, 第六位：中超包, 第七位：限购包, 第八位：预约包, 第九位：9要理财，10：乐迷秒翻天，11：爵迹，12：无属性 ,13:1102发布会，14：加息包，15：续投包，16：就要爱，17：闪闪惹人爱一轮，18：闪闪惹人爱二轮，19：活期新手理财，20：盲筹包）
-(BOOL)isStaff {
    return [self getIndex:self index:2];
}

-(BOOL)isNewUser {
    return [self getIndex:self index:1];
}

-(BOOL)isTransfer {
    return [self getIndex:self index:6];
}

- (BOOL)isNewCurrent {
    return [self getIndex:self index:19];
}

-(BOOL)getIndex:(NSString*)tempStr index:(NSInteger)index
{
    if (tempStr.length >= index) {
        return [[self substringWithRange:NSMakeRange(tempStr.length - index, 1)] boolValue];
    }else{
        return NO;
    }
}
@end

@implementation NSString (Common)

// 验证邮箱格式
-(BOOL)isValidateEmail
{
    BOOL stricterFilter = YES;   //规定是否严格判断格式
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9-]+[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter?stricterFilterString:laxString;
    NSPredicate *emailCheck = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailCheck evaluateWithObject:self];
}

// 验证身份证号码
- (BOOL)isValidateIDCard
{
    if (self.length != 18) {
        return  NO;
    }
    NSArray* codeArray = [NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2", nil];
    NSDictionary* checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2", nil]  forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil]];
    NSScanner* scan = [NSScanner scannerWithString:[self substringToIndex:17]];
    
    int val;
    BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
    if (!isNum) {
        return NO;
    }
    int sumValue = 0;
    
    for (int i =0; i<17; i++) {
        sumValue+=[[self substringWithRange:NSMakeRange(i , 1) ] intValue]* [[codeArray objectAtIndex:i] intValue];
    }
    
    NSString* strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d",sumValue%11]];
    
    if ([strlast isEqualToString: [[self substringWithRange:NSMakeRange(17, 1)]uppercaseString]]) {
        return YES;
    }
    return  NO;
}

// 验证手机号码
- (BOOL)isValidateMobileNumber
{
    NSString *phoneRegex = @"^(1)\\d{10}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}


// 正则判断手机号码地址格式
- (BOOL)isMobileNumber {
    NSString *str = self;
    if ([str length] == 0) {
        return NO;
    }
    
    //1[0-9]{10}
    
    //^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$
    
    //    NSString *regex = @"[0-9]{11}";
    
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    if (!isMatch) {
        return NO;
        
    }
    return YES;

}


- (BOOL)isOverseasValidateMobileNumber
{
    NSString *phoneRegex = @"^\\d{6,15}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}
//是否含有系统表情
- (BOOL)isContainEmoji
{
    __block BOOL returnValue = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}

- (BOOL)isWebURL {
    NSString *compare = [self lowercaseString];
    if ([compare hasPrefix:@"http://"] || [compare hasPrefix:@"https://"]) {
        return YES;
    }
    
    return NO;
}

// 剔除卡号里的非法字符
- (NSString *)getDigitsOnly
{
    NSString *digitsOnly = @"";
    char c;
    for (int i = 0; i < self.length; i++){
        c = [self characterAtIndex:i];
        if (isdigit(c)){
            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
        }
    }
    return digitsOnly;
}

// 验证银行卡 (模10“隔位乘2加”校验数算法)
- (BOOL)isValidCardNumber
{
    NSString *cardNo = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (13 > cardNo.length || 19 < cardNo.length) {//卡号长度为13-19位
        return NO;
    }
    
    int sum = 0;
    int cardCRC = [cardNo characterAtIndex:cardNo.length - 1] - '0';
    int count = 0;
    int calCRC = 0;
    for (NSInteger i = cardNo.length - 2; i >= 0; i--) {
        if (0 == count % 2) {
            int product = ([cardNo characterAtIndex:i] - '0') * 2;
            sum += (product / 10 + product % 10);
        } else {
            sum += ([cardNo characterAtIndex:i] - '0');
        }
        
        count++;
    }
    
    int mod = sum % 10;
    if (0 != mod) {
        calCRC = 10 - mod;
    }
    
    return cardCRC == calCRC;
}


- (float)stringWidthWithFont:(UIFont *)font height:(float)height
{
    if (self == nil || self.length == 0) {
        return 0;
    }
    
    NSString *copyString = [NSString stringWithFormat:@"%@", self];
    
    CGSize constrainedSize = CGSizeMake(999999, height);
    CGSize size  = CGSizeZero;
     size = [copyString boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil].size;
    return size.width+1.0;
}

- (float)stringHeightWithFont:(UIFont *)font width:(float)width
{
    if (self == nil || self.length == 0) {
        return 0;
    }
    
    NSString *copyString = [NSString stringWithFormat:@"%@", self];
    
    CGSize constrainedSize = CGSizeMake(width, 999999);
    CGSize size  = CGSizeZero;
 
    size = [copyString boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil].size;
    return size.height+1.0;
    
  
}

//装换星座 只适合 2014-05-12格式
-(NSString*)getAstor
{
    NSArray * arrayTime = [self componentsSeparatedByString:@"-"];
    if ([arrayTime count]!=3) {
        return self;
    }
    return [self getAstroWithMonth:[arrayTime[1] intValue] day:[arrayTime[2] intValue]];
}
-(NSString *)getAstroWithMonth:(int)m day:(int)d{
    
    NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    NSString *astroFormat = @"102123444543";
    NSString *result;
    if (m<1||m>12||d<1||d>31){
        return @"错误日期格式!";
    }
    if(m==2 && d>29)
    {
        return @"错误日期格式!!";
        
    }else if(m==4 || m==6 || m==9 || m==11) {
        if (d>30) {
            return @"错误日期格式!!!";
        }
    }
    
    result=[NSString stringWithFormat:@"%@",[astroString substringWithRange:NSMakeRange(m*2-(d < [[astroFormat substringWithRange:NSMakeRange((m-1), 1)] intValue] - (-19))*2,2)]];
    
    return [NSString stringWithFormat:@"%@座",result];
    
}

- (NSString *)md5
{
    if (self == nil || self.length == 0)
    {
        return nil;
    }
    
    const char *cstr = self.UTF8String;
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cstr, (CC_LONG)strlen(cstr), digest);
    
    NSMutableString *outputString = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [outputString appendFormat:@"%02x", digest[i]];
    }
    
    return outputString;
}

- (NSString *)sha1
{
    if (self == nil || self.length == 0)
    {
        return nil;
    }
    
    const char *cstr = self.UTF8String;
    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(cstr, (CC_LONG)strlen(cstr), digest);
    
    NSMutableString *outputString = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
    {
        [outputString appendFormat:@"%02x", digest[i]];
    }
    
    return outputString;
}

- (NSString *)sha512
{
    if (self == nil || self.length == 0)
    {
        return nil;
    }
    
    const char *cstr = self.UTF8String;
    unsigned char digest[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(cstr, (CC_LONG)strlen(cstr), digest);
    
    NSMutableString* outputString = [NSMutableString stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++)
    {
        [outputString appendFormat:@"%02x", digest[i]];
    }
    
    return outputString;
}

- (NSString *)encode
{
    NSString *outputStr = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                              (CFStringRef)self,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&amp;=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    outputStr = [outputStr stringByReplacingOccurrencesOfString:@"<null>" withString:@""];
    return outputStr;
}

- (NSString *)decode
{
    NSString *outputStr = (NSString *)
    CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(
                                                                              kCFAllocatorDefault,
                                                                              (__bridge CFStringRef)self,
                                                                              CFSTR(""),
                                                                              kCFStringEncodingUTF8));
    return outputStr;
}

- (id)object
{
    id object = nil;
    @try {
        NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];;
        object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    }
    @catch (NSException *exception) {
        NSLog(@"%s [Line %d] JSON字符串转换成对象出错了-->\n%@",__PRETTY_FUNCTION__, __LINE__,exception);
    }
    @finally {
    }
    return object;
}
//图片文件 NSsting - file 文件
-(UIImage*)base64ImageFromData
{
    UIImage * image = [[UIImage alloc]initWithData:[self JosnChangeDataFile]];
    return image;
}
-(NSData*)JosnChangeDataFile
{
    NSData *fileData =  [self dataUsingEncoding:NSUTF8StringEncoding];
    return [[NSData alloc]initWithBase64EncodedData:fileData options:0];
}
- (NSString*)scoreFormat
{
    if ([self hasSuffix:@"%"]) {
        return self;
    }
    
    return [NSString stringWithFormat:@"%@%@",self, @"%"];
}

- (NSString *)scoreFormatForCurrentList {
    NSString *temp = self;
    if ([temp hasSuffix:@"%@"]) {
        temp = [temp substringWithRange:NSMakeRange(0, temp.length - 1)];
    }
    
    NSArray *splits = [temp componentsSeparatedByString:@"."];
    if (1 == splits.count) {
        return [NSString stringWithFormat:@"%@%@", temp, @"%"];
    }
    
    return [NSString stringWithFormat:@"%@.%@%@", splits[0], [splits[1] substringWithRange:NSMakeRange(0, 1)], @"%"];
}

- (NSString*)sexDayFromIDcard

{
    if (![self isValidateIDCard]&&self.length!=18) {
        return @"";
    }
    NSString * sextStr = [self substringWithRange:NSMakeRange(16, 1)];
    // 男是1  nv是2
    return ([sextStr integerValue]%2)?@"1":@"2";
    
}
- (NSString*)brithDayFromIDCard
{
    if (![self isValidateIDCard]&&self.length!=18) {
        return @"";
    }
    return [self substringWithRange:NSMakeRange(6, 8)];
}

- (NSString *)getDateFromDateTime {
    if (nil == self || 0 == self.length) {
        return self;
    }
    
    NSArray<NSString *> *components = [self componentsSeparatedByString:@" "];
    return components[0];
}

- (NSString *)getCardNumberBySpacke {
    if (nil == self || 0 == self.length) {
        return self;
    }
    
    NSMutableString *result = [NSMutableString string];
    NSString *temp = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    for (NSUInteger i = 0; i < temp.length; i++) {
        if (0 != i && 0 == i % 4) {
            [result appendString:@" "];
        }
        
        [result appendString:[temp substringWithRange:NSMakeRange(i, 1)]];
    }
    
    return result;
}

- (NSString *)getMaskCardNumber {
    if (nil == self || 0 == self.length) {
        return nil;
    }
    
    NSString *no = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSInteger length = no.length;
    NSInteger times = length / 4;
    NSInteger mod = length % 4;
    
    if (0 != mod) {
        times++;
    }
    
    NSMutableString *result = [NSMutableString string];
    for (NSUInteger i = 0; i < times; i++) {
        if (0 != i) {
            [result appendString:@" "];
        }
        
        NSString *temp = nil;
        if (i < times - 2) {
            temp = [no substringWithRange:NSMakeRange(i * 4, 4)];
        } else if (i == times - 2) {
            temp = @"****";
        } else {
            temp = [no substringFromIndex:i * 4];
        }
        
        [result appendString:temp];
    }
    
    return result;
}

- (NSInteger)getSpaceNumber {
    NSInteger numbers = 0;
    if (nil == self || 0 == self.length) {
        return numbers;
    }
    
    for (NSUInteger i = 0; i < self.length; i++) {
        unichar character = [self characterAtIndex:i];
        if (' ' == character) {
            numbers++;
        }
    }
    
    return numbers;
}

- (NSString *)strWithOutSub:(NSString *)sub {
    NSArray *items = [self componentsSeparatedByString:@" "];
    return [items componentsJoinedByString:@""];
}


- (CGSize)sizeWithFontSize:(CGFloat)fontSize width:(CGFloat)width {
    return [self sizeWithFontSize:fontSize maxSize:CGSizeMake(width, WINDOW_HEIGHT - 100)];
}


- (CGSize)sizeWithFontSize:(CGFloat)fontSize maxSize:(CGSize)maxSize {
    // 设置Label的字体 HelveticaNeue  Courier
    UIFont *fnt = [UIFont systemFontOfSize:fontSize];
    // 根据字体得到NSString的尺寸
    CGSize size = [self boundingRectWithSize:CGSizeMake(maxSize.width, maxSize.height) options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName : fnt} context:nil].size;
    
    size.width = ceilf(size.width);
    size.height = ceilf(size.height);
    
    return size;
}

-(NSMutableAttributedString*)getTimeArrrinbutedFont:(UIFont*)lableFont nomalColor:(UIColor*)nomalColor heightColor:(UIColor*)heightColor
{
    lableFont = lableFont ?: [UIFont systemFontOfSize:16];
    nomalColor = nomalColor ?: HexColor(0x4A4A4A);
    heightColor = heightColor?: [UIColor redColor];
    
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc]initWithString:self attributes:@{NSFontAttributeName:lableFont,NSForegroundColorAttributeName:nomalColor}];
    NSRegularExpression*regular=[[NSRegularExpression alloc]initWithPattern:@"\\d{2}" options:NSRegularExpressionDotMatchesLineSeparators|NSRegularExpressionCaseInsensitive error:nil];
    NSArray* array=[regular matchesInString:self options:0 range:NSMakeRange(0, [self length])];
    for( NSTextCheckingResult * result in array){
        NSRange range = NSMakeRange(result.range.location,result.range.length);
        [attributedString addAttributes:@{NSFontAttributeName:lableFont,NSForegroundColorAttributeName:heightColor} range:range];
    }
    return attributedString;
}
//获取格式化的剩余募集时间
+ (NSString*)getRemainingFormateDayHourScoreSeconds:(NSInteger)interval prefixStr:(NSString*)prefixStr
{
    interval = MAX(0, interval);
    
    NSInteger day = interval/(24 * 60 * 60);
    NSInteger tempHour = interval%(24 * 60 * 60);
    NSInteger hour = tempHour/(60 * 60 );
    NSInteger tempScore= interval%(60 * 60 );
    NSInteger score = tempScore/60;
    NSInteger seconds = tempScore%60;
    
    return [NSString stringWithFormat:@"%@%02ld天%02ld时%02ld分%02ld秒",prefixStr,(long)day,(long)hour,(long)score,(long)seconds];
}
//判断时间间隔
- (BOOL)isPoorOneMinutesWithTheDataStr:(NSString*)otherTime{
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d=[date dateFromString:otherTime];
    
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    
    NSDate* dat = [date dateFromString:self];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    
    NSTimeInterval cha=now-late;
    //NSLog(@"cha = %f",cha);
    return cha/1000 > 1;
}

- (NSString *)prepareURLString {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)parseQueryComponentValue:(NSString *)key {
    if (![self containsString:key] || ![self containsString:@"?"]) {
        return @"";
    }
    NSRange range = [self rangeOfString:@"?"];
    NSString *query = [self substringFromIndex:range.location+1];

    NSArray <NSString *>*components = [query componentsSeparatedByString:@"&"];
    for (NSString *component in components) {
        NSArray <NSString *>*keyvalue = [component componentsSeparatedByString:@"="];
        if ((keyvalue.count == 2) && ([keyvalue[0] compare:key] == NSOrderedSame)) {
            return [keyvalue[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
    }
    
    return @"";
}

@end
