import APIKit
import Himotoki

class UserRequest: GithubAPIRequestType {
    typealias Response = User

    var method: HTTPMethod {
        return .GET
    }

    var userName: String

    var path: String {
        return String(format:"/users/%@", userName)
    }

    init(userName: String) {
        self.userName = userName
    }

    func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> Response {
        return try decodeValue(object)
    }
}
