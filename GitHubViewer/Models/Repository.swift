import Foundation

struct Repository {
    let name: String
    let descriptionString: String?
    let language: String?
    let followersCount: Int
    let followingCount: Int
    let watchersCount: Int
    let contributersCount: Int
    let commitsCount: Int
    let issuesCount: Int
    let branchesCount: Int
    let repositoryURL: NSURL?
    let location: String?
    let createdDate: NSDate
    let updatedDate: NSDate
}
