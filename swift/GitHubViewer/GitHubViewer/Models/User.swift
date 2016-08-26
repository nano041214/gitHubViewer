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

    static let DateTransformer = Transformer<String, NSDate> { DateString throws -> NSDate in
        let formatter: NSDateFormatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "ja")
        formatter.dateFormat = "yyyy/MM/dd"
        guard let Date = formatter.dateFromString(DateString) else
        {
            throw customError("Invalid Date String: \(DateString)")
        }
        return Date
    }

    static func decode(e: Extractor) throws -> User {
        return try User(name: e <| "name",
                        iconURL: URLTransformer.apply(e <| "image_url"),
                        followersCount: e <| "followersCount",
                        followingCount: e <| "followingCount",
                        blogURL: URLTransformer.apply(e <|? "image_url"),
                        mailAddress: e <|? "mail",
                        location: e <|? "location",
                        joinedDate: DateTransformer.apply(e <| "date"))
    }
}
