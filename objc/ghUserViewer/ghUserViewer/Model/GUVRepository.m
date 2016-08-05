#import "GUVRepository.h"

@implementation GUVRepository

+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    return dateFormatter;
}

// TODO: convert followersArray to followerCount
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
                @"name": @"name",
                @"language": @"language",
                @"descriptionString": @"followers",
//                @"followerCount": @"following",
                @"starredCount": @"stargazers_count",
                @"watcherCount": @"watchers_count",
//                @"contributerCount": @"created_at",
//                @"commitCount": @"blog",
                @"issueCount": @"open_issues_count",
//                @"branchCount": @"blog",
                @"createdDate": @"created_at",
                @"updatedDate": @"updated_at",
                @"repositoryURL": @"git_url",
            };
}

+ (NSValueTransformer *)repositoryURLJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)createdDateJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter dateFromString:dateString];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

+ (NSValueTransformer *)updatedDateJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter dateFromString:dateString];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

@end
