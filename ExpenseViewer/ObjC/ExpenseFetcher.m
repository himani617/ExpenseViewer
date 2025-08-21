
//
//  ExpenseFetcher.m
//  ExpenseViewer
//
//  Created by HIMANI VARU on 21/08/25.
//

#import "ExpenseFetcher.h"

@implementation ExpenseFetcher

- (void)fetchExpensesWithURLString:(NSString *)urlString
                        completion:(void (^)(NSArray<NSDictionary *> * _Nullable,
                                             NSError * _Nullable))completion
{
    NSURL *url = [NSURL URLWithString:urlString];
    if (!url) {
        NSError *err = [NSError errorWithDomain:@"ExpenseFetcher"
                                           code:-1
                                       userInfo:@{NSLocalizedDescriptionKey: @"Invalid URL"}];
        completion(nil, err);
        return;
    }

    NSURLSessionDataTask *task =
    [[NSURLSession sharedSession] dataTaskWithURL:url
                                completionHandler:^(NSData * _Nullable data,
                                                    NSURLResponse * _Nullable response,
                                                    NSError * _Nullable error) {

        if (error) { completion(nil, error); return; }

        if (!data) {
            NSError *err = [NSError errorWithDomain:@"ExpenseFetcher"
                                               code:-2
                                           userInfo:@{NSLocalizedDescriptionKey: @"Empty response"}];
            completion(nil, err);
            return;
        }

        NSError *jsonError = nil;
        id json = [NSJSONSerialization JSONObjectWithData:data
                                                  options:0
                                                    error:&jsonError];
        if (jsonError) { completion(nil, jsonError); return; }

        if (![json isKindOfClass:[NSArray class]]) {
            NSError *err = [NSError errorWithDomain:@"ExpenseFetcher"
                                               code:-3
                                           userInfo:@{NSLocalizedDescriptionKey: @"Unexpected JSON shape"}];
            completion(nil, err);
            return;
        }

        NSMutableArray<NSDictionary *> *items = [NSMutableArray array];

        for (id obj in (NSArray *)json) {
            if (![obj isKindOfClass:[NSDictionary class]]) { continue; }

            NSDictionary *d = (NSDictionary *)obj;

            NSString *eid = [d[@"id"] isKindOfClass:[NSString class]] ? d[@"id"] : [d[@"id"] description];
            NSString *title = [d[@"title"] isKindOfClass:[NSString class]] ? d[@"title"] : @"";
            NSNumber *amount = [d[@"amount"] isKindOfClass:[NSNumber class]] ? d[@"amount"] : @(0);
            NSString *date = [d[@"date"] isKindOfClass:[NSString class]] ? d[@"date"] : @"";

            NSDictionary *normalized = @{
                @"id": eid ?: @"",
                @"title": title ?: @"",
                @"amount": amount ?: @(0),
                @"date": date ?: @""
            };

            [items addObject:normalized];
        }

        completion(items, nil);
    }];

    [task resume];
}

@end
