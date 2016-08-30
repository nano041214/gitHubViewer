import APIKit
import Himotoki

struct UserRequest: GitHubAPIRequestType {
    typealias Response = User

    var method: HTTPMethod {
        return .GET
    }

    let userName: String

    var path: String {
        return "/users/\(userName)"
    }

    func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> Response {
        return try decodeValue(object)
    }
}
