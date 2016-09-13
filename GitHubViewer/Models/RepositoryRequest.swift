import APIKit
import Himotoki

struct RepositoryRequest: GitHubAPIRequestType {
    typealias Response = [Repository]

    var method: HTTPMethod {
        return .GET
    }

    let userName: String

    var path: String {
        return "/users/\(userName)/repos"
    }

    func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> Response {
        return try decodeArray(object)
    }
}
