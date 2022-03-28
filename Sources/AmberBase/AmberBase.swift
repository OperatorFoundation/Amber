//
//  AmberBase.swift
//  
//
//  Created by Dr. Brandon Wiley on 3/27/22.
//

import Datable
import Foundation

public class AmberBase
{
    public static var strategies: [Types: PersistenceStrategy] = [:]

    static public func register(_ strategy: PersistenceStrategy)
    {
        AmberBase.strategies[strategy.types] = strategy
    }

    static public func types(of object: Any) -> Types
    {
        let typeString = "\(type(of: object))"
        if typeString.contains("<")
        {
            let startIndex = typeString.firstIndex(of: "<")!
            let endIndex = typeString.lastIndex(of: ">")!

            let base = String(typeString[typeString.startIndex..<startIndex])
            let parameters = String(typeString[typeString.index(after: startIndex)..<endIndex])

            // FIXME - handle nested <>
            // FIXME - handle multiple ,
            if parameters.contains(",") // two gaps
            {
                let splitIndex = parameters.firstIndex(of: ",")!

                let first = String(parameters[parameters.startIndex..<splitIndex])
                let second = String(parameters[parameters.index(after: splitIndex)..<parameters.endIndex])

                return Types([base, first, second])
            }
            else // one gap
            {
                return Types([base, parameters])
            }
        }
        else // no gaps
        {
            return Types(typeString)
        }
    }

    static public func save(_ persistable: Persistable) throws -> Data
    {
        let types = persistable.types()

        return try AmberBase.save(types, persistable)
    }

    static public func save(_ types: Types, _ object: Any) throws -> Data
    {
        guard let strategy = AmberBase.strategies[types] else
        {
            throw AmberError.unknownStrategy(types)
        }

        let encoder = JSONEncoder()
        let typeData = try encoder.encode(types)
        let byteCount = UInt8(typeData.count)
        let countData = byteCount.maybeNetworkData!

        let data = try strategy.save(object)

        var result = Data()
        result.append(countData)
        result.append(typeData)
        result.append(data)

        return data
    }

    static public func load(_ data: Data) throws -> Any
    {
        guard data.count > 1 else
        {
            throw AmberError.notAmberFormat
        }

        let countData = Data(data[0..<1])
        var rest = Data(data[1...])

        let byteCount = countData.maybeNetworkUint8!
        let count = Int(byteCount)

        guard rest.count > count else
        {
            throw AmberError.notAmberFormat
        }

        let typeData = Data(data[0..<count])
        rest = Data(data[count...])

        let decoder = JSONDecoder()
        let types = try decoder.decode(Types.self, from: typeData)

        return try AmberBase.load(types, rest)
    }

    static public func load(_ types: Types, _ data: Data) throws -> Any
    {
        guard let strategy = AmberBase.strategies[types] else
        {
            throw AmberError.unknownStrategy(types)
        }

        return try strategy.load(data)
    }
}

public enum AmberError: Error
{
    case unknownStrategy(Types)
    case wrongTypes(Types, Types) // expected, actual
    case notAmberFormat
}
