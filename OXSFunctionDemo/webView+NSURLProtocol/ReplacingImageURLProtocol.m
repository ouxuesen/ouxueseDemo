//
//  ReplacingImageURLProtocol.m
//  Pods
//
//  Created by ouxuesen on 2017/6/19.
//
//

#import "ReplacingImageURLProtocol.h"

static NSString* const FilteredKey = @"FilteredKey";

@implementation ReplacingImageURLProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    NSString* extension = request.URL.pathExtension;
    BOOL isImage = [@[@"png", @"jpeg", @"gif", @"jpg"]  indexOfObjectPassingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        return [extension compare:obj options:NSCaseInsensitiveSearch] == NSOrderedSame;
    }] != NSNotFound;
    return [NSURLProtocol propertyForKey:FilteredKey inRequest:request] == nil && isImage;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

- (void)startLoading {
    NSData *data = [self imageDataWithURL:self.request.URL];
    if (data) {
        //本地图片
        NSString *mimeType = @"image/png";
        NSMutableDictionary *header = [[NSMutableDictionary alloc] initWithCapacity:2];
        NSString *contentType = [mimeType stringByAppendingString:@";charset=UTF-8"];
        header[@"Content-Type"] = contentType;
        header[@"Content-Length"] = [NSString stringWithFormat:@"%lu", (unsigned long) data.length];
        
        NSHTTPURLResponse *httpResponse = [[NSHTTPURLResponse alloc] initWithURL:self.request.URL
                                                                      statusCode:200
                                                                     HTTPVersion:@"1.1"
                                                                    headerFields:header];
        
        [self.client URLProtocol:self didReceiveResponse:httpResponse cacheStoragePolicy:NSURLCacheStorageNotAllowed];
        [self.client URLProtocol:self didLoadData:data];
        [self.client URLProtocolDidFinishLoading:self];
    } else {
        //网络缓存
//        NSMutableURLRequest *newRequest = [self.request mutableCopy];
//        newRequest.allHTTPHeaderFields = self.request.allHTTPHeaderFields;
//        [NSURLProtocol setProperty:@YES forKey:WebviewImageProtocolHandledKey inRequest:newRequest];
//        
//        self.connection = [NSURLConnection connectionWithRequest:newRequest delegate:self];
    }
}

- (void)stopLoading {
//    [self.connection cancel];
}

- (NSData*)imageDataWithURL:(NSURL*)url {
    
    NSArray *imageUrlArray = [url.absoluteString componentsSeparatedByString:@"/"];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",@"icon-83.5.png"] ofType:nil];
        if (!filePath.length) {
            return nil;
        }
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        return  data;

}



@end
