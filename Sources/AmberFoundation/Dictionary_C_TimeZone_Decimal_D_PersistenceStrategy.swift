//
//  TYPEPersistenceStrategy.swift
//  

import AmberBase
import Foundation

public class Dictionary_C_TimeZone_Decimal_D_PersistenceStrategy: PersistenceStrategy
{
    public var types: Types
    {
        return Types.generic("Dictionary", [Types.type("TimeZone"), Types.type("Decimal")])
    }

    public func save(_ object: Any) throws -> Data
    {
        guard let typedObject = object as? Dictionary<TimeZone, Decimal> else
        {
            throw AmberError.wrongTypes(self.types, AmberBase.types(of: object))
        }

        let encoder = JSONEncoder()
        return try encoder.encode(typedObject)
    }

    public func load(_ data: Data) throws -> Any
    {
        let decoder = JSONDecoder()
        return try decoder.decode(Dictionary<TimeZone, Decimal>.self, from: data)
    }
}
