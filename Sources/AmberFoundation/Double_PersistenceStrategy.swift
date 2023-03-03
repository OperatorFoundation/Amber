//
//  TYPEPersistenceStrategy.swift
//  

import AmberBase
import Foundation

public class Double_PersistenceStrategy: PersistenceStrategy
{
    public var types: Types
    {
        return Types.type("Double")
    }

    public func save(_ object: Any) throws -> Data
    {
        guard let typedObject = object as? Double else
        {
            throw AmberError.wrongTypes(self.types, AmberBase.types(of: object))
        }

        let encoder = JSONEncoder()
        return try encoder.encode(typedObject)
    }

    public func load(_ data: Data) throws -> Any
    {
        let decoder = JSONDecoder()
        return try decoder.decode(Double.self, from: data)
    }
}
