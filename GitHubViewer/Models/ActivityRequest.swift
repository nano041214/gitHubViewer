import APIKit
import Himotoki

struct ActivityRequest: GitHubAPIRequestType {
    typealias Response = [Activity]

    var method: HTTPMethod {
        return .GET
    }

    let userName: String
    var pageCount: Int? = nil

    init(userName: String, pageCount: Int? = nil) {
        self.userName = userName
        self.pageCount = pageCount
    }

    var path: String {
        return "/users/\(userName)/events"
    }

    var queryParameters: [String : AnyObject]? {
        if let pageCount = self.pageCount {
            return [
                "per_page": 5,
                "page": pageCount,
            ]
        } else {
            return [
                "per_page": 5,
            ]
        }
    }

    func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> Response {
        return try decodeArray(object)
    }
}
