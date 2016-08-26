import APIKit
import Himotoki

class UserRequest: GithubAPIRequestType {
    typealias Response = User

    var method: HTTPMethod {
        return .GET
    }

    var path: String {
        return "/users/nano041214"
    }

    func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> Response {
        return try decodeValue(object)
    }
}
