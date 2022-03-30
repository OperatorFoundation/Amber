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

    func testUserDefinedType() throws
    {
        struct TestStruct: Codable, Equatable
        {
            var name: String = "test"
        }

        struct TestStructPersistenceStrategy: PersistenceStrategy
        {
            var types: Types = Types.type("TestStruct")

            func save(_ object: Any) throws -> Data
            {
                guard let typedObject = object as? TestStruct else
                {
                    throw AmberError.wrongTypes(self.types, AmberBase.types(of: object))
                }

                let encoder = JSONEncoder()
                return try encoder.encode(typedObject)
            }

            func load(_ data: Data) throws -> Any
            {
                let decoder = JSONDecoder()
                return try decoder.decode(TestStruct.self, from: data)
            }
        }

        Amber.register(TestStructPersistenceStrategy())

        let object = TestStruct()
        var data = try Amber.save(object)
        var result = try Amber.load(data)
        guard let typedResult = result as? TestStruct else
        {
            XCTFail()
            return
        }
        XCTAssertEqual(typedResult, object)

        struct Array_C_TestStruct_D_PersistenceStrategy: PersistenceStrategy
        {
            var types: Types = Types.generic("Array", [.type("TestStruct")])

            func save(_ object: Any) throws -> Data
            {
                guard let typedObject = object as? Array<TestStruct> else
                {
                    throw AmberError.wrongTypes(self.types, AmberBase.types(of: object))
                }

                let encoder = JSONEncoder()
                return try encoder.encode(typedObject)
            }

            func load(_ data: Data) throws -> Any
            {
                let decoder = JSONDecoder()
                return try decoder.decode(Array<TestStruct>.self, from: data)
            }
        }

        Amber.register(Array_C_TestStruct_D_PersistenceStrategy())

        let array = [object]
        data = try Amber.save(array)
        result = try Amber.load(data)
        guard let arrayResult = result as? Array<TestStruct> else
        {
            XCTFail()
            return
        }
        XCTAssertEqual(arrayResult, array)
    }
}
