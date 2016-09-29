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
    let repositoryURL: NSURL
    let createdDate: NSDate
    let updatedDate: NSDate

    var formattedRepositoryName: String {
        get {
            return "\(userName)/\n\(name)"
        }
    }

    var formattedCreatedAndUpdatedDateString: String {
        get {
            let dateFormatter = SimpleDateFormatter.dateFomatter()
            return "created at \(dateFormatter.stringFromDate(createdDate))\nupdated at \(dateFormatter.stringFromDate(updatedDate))"
        }
    }
}

extension Repository: Decodable {
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
                              repositoryURL: HimotokiTransformer.URLTransformer.apply(extractor <| "html_url"),
                              createdDate: HimotokiTransformer.dateTransformer.apply(extractor <| "created_at"),
                              updatedDate: HimotokiTransformer.dateTransformer.apply(extractor <| "updated_at"))
    }
}
