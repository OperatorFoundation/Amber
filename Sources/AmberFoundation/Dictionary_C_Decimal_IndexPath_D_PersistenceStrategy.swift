//
//  TYPEPersistenceStrategy.swift
//

import AmberBase
import Foundation

public class Dictionary_C_Decimal_IndexPath_D_PersistenceStrategy: PersistenceStrategy
{
    public var types: Types
    {
        return Types.generic("Dictionary", [Types.type("Decimal"), Types.type("IndexPath")])
    }

    public func save(_ object: Any) throws -> Data
    {
        guard let typedObject = object as? Dictionary<Decimal, IndexPath> else
        {
            throw AmberError.wrongTypes(self.types, AmberBase.types(of: object))
        }

        let encoder = JSONEncoder()
        return try encoder.encode(typedObject)
    }

    public func load(_ data: Data) throws -> Any
    {
        let decoder = JSONDecoder()
        return try decoder.decode(Dictionary<Decimal, IndexPath>.self, from: data)
    }
}