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
//                @"followerCount": @"followerCount",
                @"starredCount": @"stargazers_count",
                @"watchersCount": @"watchers_count",
//                @"contributerCount": @"contribuerCount",
//                @"commitCount": @"commitCount",
                @"issuesCount": @"open_issues_count",
//                @"branchCount": @"branchCount",
                @"createdDate": @"created_at",
                @"updatedDate": @"updated_at",
                @"repositoryURL": @"html_url",
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

- (NSString *)formattedRepositoryNameString {
    return [NSString stringWithFormat:@"%@/\n%@", self.ownerName, self.name];
}

- (NSString *)formattedCreatedAndUpdatedDateString {
    return [NSString stringWithFormat: @"created at %@    updated at %@",
            self.createdDate,
            self.updatedDate];
}

@end
