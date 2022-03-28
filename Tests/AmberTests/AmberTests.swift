import XCTest
@testable import Amber

final class AmberTests: XCTestCase
{
    func testSaveLoadString() throws
    {
        let string = "test"

        let data = try Amber.save(string)
        let result = try Amber.load(data)
        guard let typedResult = result as? String else
        {
            XCTFail()
            return
        }

        XCTAssertEqual(typedResult, string)
    }

    func testSaveLoadArrayString() throws
    {
        let array = ["1", "2"]

        let data = try Amber.save(array)
        let result = try Amber.load(data)
        guard let typedResult = result as? Array<String> else
        {
            XCTFail()
            return
        }

        XCTAssertEqual(typedResult, array)
    }
}
