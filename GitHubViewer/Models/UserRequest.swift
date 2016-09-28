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
        switch URLResponse.statusCode {
        case 200..<300:
            return object
        case 404:
            throw GitHubViewerError.NoSuchUser
        default:
            if let message = object["message"] as? String {
                throw GitHubViewerError.UnExpectedResponce(message: message)
            } else {
                return object
            }
        }
    }
}
