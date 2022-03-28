//
//  FIRSTSECONDTHIRDPersistenceStrategy.swift
//

import AmberBase
import Foundation

public class FIRSTSECONDTHIRDPersistenceStrategy: PersistenceStrategy
{
    public var types: Types
    {
        return Types(["FIRST", "SECOND", "THIRD"])
    }

    public func save(_ object: Any) throws -> Data
    {
        guard let typedObject = object as? FIRST<SECOND,THIRD> else
        {
            throw AmberError.wrongTypes(self.types, AmberBase.types(of: object))
        }

        let encoder = JSONEncoder()
        return try encoder.encode(typedObject)
    }

    public func load(_ data: Data) throws -> Any
    {
        let decoder = JSONDecoder()
        return try decoder.decode(FIRST<SECOND,THIRD>.self, from: data)
    }
}
