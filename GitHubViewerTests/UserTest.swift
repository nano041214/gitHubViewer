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
            // TODO: check property
        } catch {
            XCTFail("Himotoki failed to decode user")
        }
    }
}
