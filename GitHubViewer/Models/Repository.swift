import Foundation
import Himotoki

struct Repository {
    let name: String
    let userName: String
    let descriptionString: String?
    let language: String?
    let followersCount: Int
    let followingCount: Int
    let watchersCount: Int
    let forksCount: Int
    let commitsCount: Int
    let issuesCount: Int
    let starredCount: Int
    let repositoryURL: NSURL?
    let createdDate: NSDate
    let updatedDate: NSDate
}

extension Repository: Decodable {
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

    static func decode(extractor: Extractor) throws -> Repository {
        return try Repository(name: extractor <| "name",
                              userName: extractor <| ["owner", "login"],
                              descriptionString: extractor <|? "description",
                              language: extractor <|? "language",
                              followersCount: 0,
                              followingCount: 0,
                              watchersCount: extractor <| "watchers_count",
                              forksCount: extractor <| "forks",
                              commitsCount: 0,
                              issuesCount: extractor <| "open_issues_count",
                              starredCount: extractor <| "stargazers_count",
                              repositoryURL: URLTransformer.apply(extractor <| "html_url"),
                              createdDate: dateTransformer.apply(extractor <| "created_at"),
                              updatedDate: dateTransformer.apply(extractor <| "updated_at"))
    }
}
