import Foundation
import Himotoki

struct User {
    let name: String
    let iconURL: NSURL
    let followersCount: Int
    let followingCount: Int
    let blogURL: NSURL?
    let mailAddress: String?
    let location: String?
    let joinedDate: NSDate
}

extension User: Decodable {
    static func decode(extractor: Extractor) throws -> User {
        return try User(name: extractor <| "login",
                        iconURL: DecodeHelper.URLTransformer.apply(extractor <| "avatar_url"),
                        followersCount: extractor <| "followers",
                        followingCount: extractor <| "following",
                        blogURL: DecodeHelper.URLTransformer.apply(extractor <|? "blog"),
                        mailAddress: extractor <|? "email",
                        location: extractor <|? "location",
                        joinedDate: DecodeHelper.dateTransformer.apply(extractor <| "created_at"))
    }
}
