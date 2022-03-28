//
//  Persistable.swift
//  
//
//  Created by Dr. Brandon Wiley on 3/27/22.
//

import Foundation

public protocol Persistable: Codable
{
    func types() -> Types
}
