//
//  TYPEPersistenceStrategy.swift
//  

import AmberBase
import Foundation

public class Locale_PersistenceStrategy: PersistenceStrategy
{
    public var types: Types
    {
        return Types.type("Locale")
    }

    public func save(_ object: Any) throws -> Data
    {
        guard let typedObject = object as? Locale else
        {
            throw AmberError.wrongTypes(self.types, AmberBase.types(of: object))
        }

        let encoder = JSONEncoder()
        return try encoder.encode(typedObject)
    }

    public func load(_ data: Data) throws -> Any
    {
        let decoder = JSONDecoder()
        return try decoder.decode(Locale.self, from: data)
    }
}
