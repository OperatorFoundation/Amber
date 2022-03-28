//
//  TypeFillers.swift
//  
//
//  Created by Dr. Brandon Wiley on 3/27/22.
//

import Foundation

public struct Types: Codable, Hashable
{
    public let types: [String]

    public init(_ type: String)
    {
        self.types = [type]
    }

    public init(_ types: [String])
    {
        self.types = types
    }

    public func hash(into hasher: inout Hasher)
    {
        hasher.combine(self.types)
    }
}
