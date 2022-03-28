//
//  Amber.swift
//  
//
//  Created by Dr. Brandon Wiley on 3/27/22.
//

import AmberFoundation
import Foundation

public class Amber
{
    static var foundationLoaded = false

    static public func register(_ strategy: PersistenceStrategy)
    {
        Amber.ensureFoundationLoaded()

        AmberBase.strategies[strategy.name] = strategy
    }

    static public func save(_ object: Any) throws -> (String, Data)
    {
        let name = "\(type(of: object))"
        let result = try Amber.save(name, object)

        return (name, result)
    }

    static public func save(_ name: String, _ object: Any) throws -> Data
    {
        Amber.ensureFoundationLoaded()

        guard let strategy = AmberBase.strategies[name] else
        {
            throw AmberError.unknownStrategy(name)
        }

        return try strategy.save(object)
    }

    static public func load(_ name: String, _ data: Data) throws -> Any
    {
        Amber.ensureFoundationLoaded()

        guard let strategy = AmberBase.strategies[name] else
        {
            throw AmberError.unknownStrategy(name)
        }

        return try strategy.load(data)
    }

    static func ensureFoundationLoaded()
    {
        if !foundationLoaded
        {
            AmberFoundation.register()
            foundationLoaded = true
        }
    }
}

