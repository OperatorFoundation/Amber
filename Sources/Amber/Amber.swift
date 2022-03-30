//
//  Amber.swift
//  
//
//  Created by Dr. Brandon Wiley on 3/27/22.
//

import AmberFoundation
import AmberGenerator
import Foundation

public class Amber
{
    static var foundationLoaded = false

    static public func register(_ strategy: PersistenceStrategy)
    {
        Amber.ensureFoundationLoaded()

        AmberBase.strategies[strategy.types] = strategy
    }

    static public func save(_ object: Any) throws -> Data
    {
        Amber.ensureFoundationLoaded()

        return try AmberBase.save(object)
    }

    static public func load(_ data: Data) throws -> Any
    {
        Amber.ensureFoundationLoaded()

        return try AmberBase.load(data)
    }

    static public func generate(typeNames: [String], registrationName: String, outputPath: String)
    {
        Generator.generate(typeNames: typeNames, registrationName: registrationName, outputPath: outputPath)
    }

    static func ensureFoundationLoaded()
    {
        if !foundationLoaded
        {
            AmberFoundationRegistration.register()
            foundationLoaded = true
        }
    }
}

