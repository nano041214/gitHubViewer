import Foundation

struct User {
    let name: String
    let iconURL: NSURL
    let followersCount: Int
    let followingCount: Int
    let blogURL: NSURL?
    let mailAddress: String?
    let location: String?
    let joinedDate: NSDate
}
