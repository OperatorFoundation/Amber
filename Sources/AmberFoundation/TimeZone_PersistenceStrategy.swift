//
//  TYPEPersistenceStrategy.swift
//

import AmberBase
import Foundation

public class TimeZone_PersistenceStrategy: PersistenceStrategy
{
    public var types: Types
    {
        return Types.type("TimeZone")
    }

    public func save(_ object: Any) throws -> Data
    {
        guard let typedObject = object as? TimeZone else
        {
            throw AmberError.wrongTypes(self.types, AmberBase.types(of: object))
        }

        let encoder = JSONEncoder()
        return try encoder.encode(typedObject)
    }

    public func load(_ data: Data) throws -> Any
    {
        let decoder = JSONDecoder()
        return try decoder.decode(TimeZone.self, from: data)
    }
}