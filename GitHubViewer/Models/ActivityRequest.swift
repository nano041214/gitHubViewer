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
        if let pageCount = self.pageCount {
            return "/users/\(userName)/events?page=\(pageCount)"
        } else {
            return "/users/\(userName)/events"
        }
    }

    func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> Response {
        return try decodeArray(object)
    }
}
