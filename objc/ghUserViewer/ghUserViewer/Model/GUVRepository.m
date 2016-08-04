#import "GUVRepository.h"

@implementation GUVRepository

+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    return dateFormatter;
}

// TODO: delete
//@property (nonatomic) NSString *name;
//@property (nonatomic, readonly, nullable) NSString *language;
//@property (nonatomic, readonly, nullable) NSString *descriptionString;
//@property (nonatomic, readonly) NSUInteger followingCount;
//@property (nonatomic, readonly) NSUInteger starredCount;
//@property (nonatomic, readonly) NSUInteger watcherCount;
//@property (nonatomic, readonly) NSUInteger contributerCount;
//@property (nonatomic, readonly) NSUInteger commitCount;
//@property (nonatomic, readonly) NSUInteger issueCount;
//@property (nonatomic, readonly) NSUInteger branchCount;
//@property (nonatomic, readonly) NSDate *createdAt;
//@property (nonatomic, readonly) NSDate *updatedAt;
//@property (nonatomic, readonly) NSURL *repositoryURL;

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"name": @"name",
//             @"iconURL": @"avatar_url",
//             @"followersCount": @"followers",
//             @"followingCount": @"following",
//             @"mailAddress": @"email",
//             @"location": @"location",
//             @"joinedDate": @"created_at",
//             @"blogURL": @"blog",
             };
}

//+ (NSValueTransformer *)iconURLJSONTransformer {
//    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
//}
//
//+ (NSValueTransformer *)blogURLJSONTransformer {
//    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
//}

+ (NSValueTransformer *)joinedDateJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter dateFromString:dateString];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

@end
