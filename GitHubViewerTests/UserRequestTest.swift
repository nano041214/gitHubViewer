import XCTest
import OHHTTPStubs
import APIKit

class UserRequestTest: XCTestCase {
    override func tearDown() {
        super.tearDown()
        OHHTTPStubs.removeAllStubs()
    }

    func testUserRequestSuccess() {
        stub(isHost("api.github.com")) { request in
            if request.URL?.path == "/users/nano041214" {
                let stubPath = OHPathForFile("user.json", self.dynamicType)!
                return fixture(stubPath, headers: ["Content-Type":"application/json"])
            } else {
                XCTFail("Accessed \(request.URL) is not expected url")
                return OHHTTPStubsResponse(data: NSData(), statusCode: 400, headers: nil)
            }
        }
        let request = UserRequest(userName: "nano041214")
        let expectation = expectationWithDescription("Check user request")
        Session.sendRequest(request) { result in
            switch result {
            case .Success:
                expectation.fulfill()
            case .Failure:
                return
            }
        }
        waitForExpectationsWithTimeout(1.0, handler: nil)
    }

    func testUserRequestFailure() {
        stub(isHost("api.github.com")) { request in
            if request.URL?.path == "/users/unknownuser" {
                return OHHTTPStubsResponse(data: NSData(), statusCode: 404, headers: nil)
            } else {
                XCTFail("Accessed \(request.URL) is not expected url")
                return OHHTTPStubsResponse(data: NSData(), statusCode: 400, headers: nil)
            }
        }

        let request = UserRequest(userName: "unknownuser")
        let expectation = expectationWithDescription("Check user request")
        Session.sendRequest(request) { result in
            switch result {
            case .Success:
                return
            case .Failure:
                expectation.fulfill()
            }
        }
        waitForExpectationsWithTimeout(1.0, handler: nil)
    }
}
