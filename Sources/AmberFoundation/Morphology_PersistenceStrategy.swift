//
//  TYPEPersistenceStrategy.swift
//

import AmberBase
import Foundation

public class Morphology_PersistenceStrategy: PersistenceStrategy
{
    public var types: Types
    {
        return Types.type("Morphology")
    }

    public func save(_ object: Any) throws -> Data
    {
        guard let typedObject = object as? Morphology else
        {
            throw AmberError.wrongTypes(self.types, AmberBase.types(of: object))
        }

        let encoder = JSONEncoder()
        return try encoder.encode(typedObject)
    }

    public func load(_ data: Data) throws -> Any
    {
        let decoder = JSONDecoder()
        return try decoder.decode(Morphology.self, from: data)
    }
}