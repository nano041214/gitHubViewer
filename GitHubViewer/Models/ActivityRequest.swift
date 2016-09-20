import APIKit
import Himotoki

struct ActivityRequest: GitHubAPIRequestType {
    typealias Response = [Activity]

    var method: HTTPMethod {
        return .GET
    }

    let userName: String

    var path: String {
        return "/users/\(userName)/events"
    }

    func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> Response {
        return try decodeArray(object)
    }
}
