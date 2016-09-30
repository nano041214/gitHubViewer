import APIKit
import Himotoki

struct ActivityRequest: GitHubAPIRequestType {
    typealias Response = [Activity]

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
        return "/users/\(userName)/events"
    }

    var queryParameters: [String : AnyObject]? {
        return [
            "per_page": ActivityRequest.perPage,
            "page": pageCount,
        ]
    }

    func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> Response {
        return try decodeArray(object)
    }
}
