import XCTest
@testable import Amber

final class AmberTests: XCTestCase
{
    func testSaveLoadString() throws
    {
        let string = "test"

        let (type, data) = try Amber.save(string)
        let result = try Amber.load(type, data)
        guard let typedResult = result as? String else
        {
            XCTFail()
            return
        }

        XCTAssertEqual(typedResult, string)
    }
}
