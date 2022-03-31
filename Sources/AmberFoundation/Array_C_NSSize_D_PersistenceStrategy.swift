//
//  TYPEPersistenceStrategy.swift
//

import AmberBase
import Foundation

public class Array_C_NSSize_D_PersistenceStrategy: PersistenceStrategy
{
    public var types: Types
    {
        return Types.generic("Array", [Types.type("NSSize")])
    }

    public func save(_ object: Any) throws -> Data
    {
        guard let typedObject = object as? Array<NSSize> else
        {
            throw AmberError.wrongTypes(self.types, AmberBase.types(of: object))
        }

        let encoder = JSONEncoder()
        return try encoder.encode(typedObject)
    }

    public func load(_ data: Data) throws -> Any
    {
        let decoder = JSONDecoder()
        return try decoder.decode(Array<NSSize>.self, from: data)
    }
}