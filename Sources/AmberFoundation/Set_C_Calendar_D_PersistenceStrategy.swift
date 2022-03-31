//
//  TYPEPersistenceStrategy.swift
//

import AmberBase
import Foundation

public class Set_C_Calendar_D_PersistenceStrategy: PersistenceStrategy
{
    public var types: Types
    {
        return Types.generic("Set", [Types.type("Calendar")])
    }

    public func save(_ object: Any) throws -> Data
    {
        guard let typedObject = object as? Set<Calendar> else
        {
            throw AmberError.wrongTypes(self.types, AmberBase.types(of: object))
        }

        let encoder = JSONEncoder()
        return try encoder.encode(typedObject)
    }

    public func load(_ data: Data) throws -> Any
    {
        let decoder = JSONDecoder()
        return try decoder.decode(Set<Calendar>.self, from: data)
    }
}