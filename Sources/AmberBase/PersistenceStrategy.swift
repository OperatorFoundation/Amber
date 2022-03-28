//
//  PersistenceStrategy.swift
//  
//
//  Created by Dr. Brandon Wiley on 3/27/22.
//

import Foundation

public protocol PersistenceStrategy
{
    var types: Types {get}
    func save(_ object: Any) throws -> Data
    func load(_ data: Data) throws -> Any
}
