import APIKit
import Himotoki

struct RepositoryRequest: GitHubAPIRequestType {
    typealias Response = [Repository]

    var method: HTTPMethod {
        return .GET
    }

    static let perPage = 10
    let userName: String
    var pageCount: Int? = nil

    init(userName: String, pageCount: Int? = nil) {
        self.userName = userName
        self.pageCount = pageCount
    }

    var path: String {
        return "/users/\(userName)/repos"
    }

    var queryParameters: [String : AnyObject]? {
        if let pageCount = self.pageCount {
            return [
                "per_page": RepositoryRequest.perPage,
                "page": pageCount,
            ]
        } else {
            return [
                "per_page": RepositoryRequest.perPage,
            ]
        }
    }

    func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> Response {
        return try decodeArray(object)
    }
}
