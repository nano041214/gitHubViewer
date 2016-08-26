import APIKit

protocol GithubAPIRequestType: RequestType {}

extension GithubAPIRequestType {
    var baseURL: NSURL {
        return NSURL(string: "api.github.com/")!
    }
}
