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
        guard let date = formatter.dateFromString(dateString) else
        {
            throw customError("Invalid Date String: \(dateString)")
        }
        return date
    }

    static func decode(e: Extractor) throws -> User {
        return try User(name: e <| "login",
                        iconURL: URLTransformer.apply(e <| "avatar_url"),
                        followersCount: e <| "followers",
                        followingCount: e <| "following",
                        blogURL: URLTransformer.apply(e <|? "blog"),
                        mailAddress: e <|? "email",
                        location: e <|? "location",
                        joinedDate: dateTransformer.apply(e <| "created_at"))
    }
}
