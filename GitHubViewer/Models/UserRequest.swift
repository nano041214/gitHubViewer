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

extension UserRequest {
    func interceptObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> AnyObject {
        guard (200..<300).contains(URLResponse.statusCode) else {
            if URLResponse.statusCode == 404 {
                throw GitHubViewerError.NoSuchUser
            }
            if let message = object["message"] as? String {
                throw GitHubViewerError.UnExpectedResponse(message: message)
            } else {
                throw GitHubViewerError.UnknownError
            }
        }
        return object
    }
}
