import XCTest
import Himotoki

// swiftlint:disable force_try
class UserTest: XCTestCase {

    func testDecodeUser() {
        guard let jsonPath = NSBundle(forClass: UserTest.self).pathForResource("user", ofType: "json") else {
            fatalError("There is no json file for user")
        }
        guard let userData = NSData.init(contentsOfFile: jsonPath) else {
            fatalError("Failed to load with json file")
        }

        let userJSONObject = try! NSJSONSerialization.JSONObjectWithData(userData, options: NSJSONReadingOptions(rawValue: 0))
        do {
            let user = try User.decodeValue(userJSONObject)
            XCTAssertEqual(user.name, "nano041214")
            XCTAssertEqual(user.iconURL, NSURL(string: "https://avatars.githubusercontent.com/u/19585777?v=3"))
            XCTAssertEqual(user.followersCount, 1)
            XCTAssertEqual(user.followingCount, 1)
            XCTAssertEqual(user.mailAddress, nil)
            XCTAssertEqual(user.location, nil)
            XCTAssertEqual(user.joinedDate, FormattedDate("2016-05-26T07:03:49Z"))
        } catch {
            XCTFail("Himotoki failed to decode user")
        }
    }

    func FormattedDate(dateString: String) -> NSDate {
        let formatter: NSDateFormatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        guard let date = formatter.dateFromString(dateString) else {
            fatalError("Undecodable date string")
        }
        return date
    }
}
