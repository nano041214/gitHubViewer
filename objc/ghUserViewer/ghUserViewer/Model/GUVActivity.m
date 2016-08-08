#import "GUVActivity.h"

@implementation GUVActivity

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"name": @"type",
             @"repositoryName": @"repo.name",
    };
}

@end
