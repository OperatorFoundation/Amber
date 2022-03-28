//
//  TYPEPersistenceStrategy.swift
//  

import AmberBase
import Foundation

public class TYPEPersistenceStrategy: PersistenceStrategy
{
    public var name: String
    {
        return "TYPE"
    }

    public func save(_ object: Any) throws -> Data
    {
        guard let typedObject = object as? TYPE else
        {
            throw AmberError.wrongType(self.name, "\(type(of: object))")
        }

        let encoder = JSONEncoder()
        return try encoder.encode(typedObject)
    }

    public func load(_ data: Data) throws -> Any
    {
        let decoder = JSONDecoder()
        return try decoder.decode(TYPE.self, from: data)
    }
}
