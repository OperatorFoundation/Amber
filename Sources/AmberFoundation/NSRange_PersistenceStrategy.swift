//
//  TYPEPersistenceStrategy.swift
//  

import AmberBase
import Foundation

public class NSRange_PersistenceStrategy: PersistenceStrategy
{
    public var types: Types
    {
        return Types.type("NSRange")
    }

    public func save(_ object: Any) throws -> Data
    {
        guard let typedObject = object as? NSRange else
        {
            throw AmberError.wrongTypes(self.types, AmberBase.types(of: object))
        }

        let encoder = JSONEncoder()
        return try encoder.encode(typedObject)
    }

    public func load(_ data: Data) throws -> Any
    {
        let decoder = JSONDecoder()
        return try decoder.decode(NSRange.self, from: data)
    }
}
