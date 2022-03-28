//
//  OUTERINNERPersistenceStrategy.swift
//

import AmberBase
import Foundation

public class OUTERINNERPersistenceStrategy: PersistenceStrategy
{
    public var types: Types
    {
        return Types(["OUTER", "INNER"])
    }

    public func save(_ object: Any) throws -> Data
    {
        guard let typedObject = object as? OUTER<INNER> else
        {
            throw AmberError.wrongTypes(self.types, AmberBase.types(of: object))
        }

        let encoder = JSONEncoder()
        return try encoder.encode(typedObject)
    }

    public func load(_ data: Data) throws -> Any
    {
        let decoder = JSONDecoder()
        return try decoder.decode(OUTER<INNER>.self, from: data)
    }
}
