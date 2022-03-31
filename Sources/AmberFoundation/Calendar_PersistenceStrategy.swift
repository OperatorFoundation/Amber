//
//  TYPEPersistenceStrategy.swift
//  

import AmberBase
import Foundation

public class Calendar_PersistenceStrategy: PersistenceStrategy
{
    public var types: Types
    {
        return Types.type("Calendar")
    }

    public func save(_ object: Any) throws -> Data
    {
        guard let typedObject = object as? Calendar else
        {
            throw AmberError.wrongTypes(self.types, AmberBase.types(of: object))
        }

        let encoder = JSONEncoder()
        return try encoder.encode(typedObject)
    }

    public func load(_ data: Data) throws -> Any
    {
        let decoder = JSONDecoder()
        return try decoder.decode(Calendar.self, from: data)
    }
}
