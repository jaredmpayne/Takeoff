import XCTest
@testable import Takeoff

final class TakeoffTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Takeoff().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
