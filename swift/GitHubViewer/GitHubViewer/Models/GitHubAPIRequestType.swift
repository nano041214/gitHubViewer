import APIKit

protocol GitHubAPIRequestType: RequestType {}

extension GitHubAPIRequestType {
    var baseURL: NSURL {
        return NSURL(string: "https://api.github.com")!
    }
}
