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
    static let URLTransformer = Transformer<String, NSURL> { URLString throws -> NSURL in
        guard let URL = NSURL(string: URLString) else {
            throw customError("Invalid URL string: \(URLString)")
        }
        return URL
    }

    static let dateTransformer = Transformer<String, NSDate> { dateString throws -> NSDate in
        let formatter: NSDateFormatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        guard let date = formatter.dateFromString(dateString) else {
            throw customError("Invalid Date String: \(dateString)")
        }
        return date
    }

    static func decode(extractor: Extractor) throws -> User {
        return try User(name: extractor <| "login",
                        iconURL: URLTransformer.apply(extractor <| "avatar_url"),
                        followersCount: extractor <| "followers",
                        followingCount: extractor <| "following",
                        blogURL: URLTransformer.apply(extractor <|? "blog"),
                        mailAddress: extractor <|? "email",
                        location: extractor <|? "location",
                        joinedDate: dateTransformer.apply(extractor <| "created_at"))
    }
}
