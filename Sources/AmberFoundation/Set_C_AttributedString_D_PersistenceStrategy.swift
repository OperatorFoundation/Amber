//
//  TYPEPersistenceStrategy.swift
//

import AmberBase
import Foundation

public class Set_C_AttributedString_D_PersistenceStrategy: PersistenceStrategy
{
    public var types: Types
    {
        return Types.generic("Set", [Types.type("AttributedString")])
    }

    public func save(_ object: Any) throws -> Data
    {
        guard let typedObject = object as? Set<AttributedString> else
        {
            throw AmberError.wrongTypes(self.types, AmberBase.types(of: object))
        }

        let encoder = JSONEncoder()
        return try encoder.encode(typedObject)
    }

    public func load(_ data: Data) throws -> Any
    {
        let decoder = JSONDecoder()
        return try decoder.decode(Set<AttributedString>.self, from: data)
    }
}