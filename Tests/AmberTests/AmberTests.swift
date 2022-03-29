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

    func testSaveLoadDictionaryStringInt() throws
    {
        let dictionary: [String: Int] = ["1": 1, "2": 2]

        let data = try Amber.save(dictionary)
        let result = try Amber.load(data)
        guard let typedResult = result as? [String: Int] else
        {
            XCTFail()
            return
        }

        XCTAssertEqual(typedResult, dictionary)
    }

    func testTypeParser1() throws
    {
        let object = "test"
        let type = type(of: object)
        guard let types = Types("\(type)") else
        {
            XCTFail()
            return
        }
        let description = types.description
        XCTAssertEqual(description, "String")
    }

    func testTypeParser2() throws
    {
        let object = ["test"]
        let type = type(of: object)
        guard let types = Types("\(type)") else
        {
            XCTFail()
            return
        }
        let description = types.description
        XCTAssertEqual(description, "Array<String>")
    }

    func testTypeParser3() throws
    {
        let object = ["test": 1]
        let type = type(of: object)
        guard let types = Types("\(type)") else
        {
            XCTFail()
            return
        }
        let description = types.description
        XCTAssertEqual(description, "Dictionary<String, Int>")
    }
}
