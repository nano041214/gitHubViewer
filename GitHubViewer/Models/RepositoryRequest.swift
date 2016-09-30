import APIKit
import Himotoki

struct RepositoryRequest: GitHubAPIRequestType {
    typealias Response = [Repository]

    var method: HTTPMethod {
        return .GET
    }

    static let perPage = 10
    let userName: String
    let pageCount: Int

    init(userName: String, pageCount: Int? = nil) {
        self.userName = userName
        if let pageCount = pageCount {
            self.pageCount = pageCount
        } else {
            self.pageCount = 1
        }
    }

    var path: String {
        return "/users/\(userName)/repos"
    }

    var queryParameters: [String : AnyObject]? {
        return [
            "per_page": RepositoryRequest.perPage,
            "page": pageCount,
        ]
    }

    func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> Response {
        return try decodeArray(object)
    }
}
