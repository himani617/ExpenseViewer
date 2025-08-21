
//
//  ExpenseFetcher.h
//  ExpenseViewer
//
//  Created by HIMANI VARU on 21/08/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExpenseFetcher : NSObject
- (void)fetchExpensesWithURLString:(NSString *)urlString
                        completion:(void (^)(NSArray<NSDictionary *> * _Nullable items,
                                             NSError * _Nullable error))completion;
@end

NS_ASSUME_NONNULL_END
