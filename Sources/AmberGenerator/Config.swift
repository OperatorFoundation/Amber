//
//  Config.swift
//  
//
//  Created by Dr. Brandon Wiley on 3/30/22.
//

import Foundation

public struct Config: Codable
{
    let outputPath: String
    let registrationName: String
    let types: [String]
}
