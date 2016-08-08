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
                @"ownerName": @"owner.login",
                @"language": @"language",
                @"descriptionString": @"description",
//                @"followerCount": @"following",
                @"starredCount": @"stargazers_count",
                @"watcherCount": @"watchers_count",
//                @"contributerCount": @"created_at",
//                @"commitCount": @"blog",
                @"issueCount": @"open_issues_count",
//                @"branchCount": @"blog",
                @"createdDate": @"created_at",
                @"updatedDate": @"updated_at",
                @"repositoryURL": @"svn_url",
            };
}

+ (NSValueTransformer *)repositoryURLJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)createdDateJSONTransformer {
    return [GUVRepository transformStringToDate];
}

+ (NSValueTransformer *)updatedDateJSONTransformer {
    return [GUVRepository transformStringToDate];
}

+ (NSValueTransformer *)transformStringToDate {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter dateFromString:dateString];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

- (NSString *)formatedRepositoryNameString {
    return [NSString stringWithFormat:@"%@/\n%@", self.ownerName, self.name];
}

- (NSString *)formatedCreatedAndUpdatedDateString {
    return [NSString stringWithFormat: @"created at %@    updated at %@",
            self.createdDate,
            self.updatedDate];
}

@end
