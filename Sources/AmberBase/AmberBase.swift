//
//  Amber.swift
//  
//
//  Created by Dr. Brandon Wiley on 3/27/22.
//

import Foundation

public class AmberBase
{
    public static var strategies: [String: PersistenceStrategy] = [:]

    static public func register(_ strategy: PersistenceStrategy)
    {
        AmberBase.strategies[strategy.name] = strategy
    }

    static public func save(_ name: String, _ object: Any) throws -> Data
    {
        guard let strategy = AmberBase.strategies[name] else
        {
            throw AmberError.unknownStrategy(name)
        }

        return try strategy.save(object)
    }

    static public func load(_ name: String, _ data: Data) throws -> Any
    {
        guard let strategy = AmberBase.strategies[name] else
        {
            throw AmberError.unknownStrategy(name)
        }

        return try strategy.load(data)
    }
}

public enum AmberError: Error
{
    case unknownStrategy(String)
    case wrongType(String, String) // expected, actual
}
