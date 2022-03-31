//
//  TYPEPersistenceStrategy.swift
//

import AmberBase
import Foundation

public class Dictionary_C_IndexSet_StringStyle_D_PersistenceStrategy: PersistenceStrategy
{
    public var types: Types
    {
        return Types.generic("Dictionary", [Types.type("IndexSet"), Types.type("StringStyle")])
    }

    public func save(_ object: Any) throws -> Data
    {
        guard let typedObject = object as? Dictionary<IndexSet, StringStyle> else
        {
            throw AmberError.wrongTypes(self.types, AmberBase.types(of: object))
        }

        let encoder = JSONEncoder()
        return try encoder.encode(typedObject)
    }

    public func load(_ data: Data) throws -> Any
    {
        let decoder = JSONDecoder()
        return try decoder.decode(Dictionary<IndexSet, StringStyle>.self, from: data)
    }
}