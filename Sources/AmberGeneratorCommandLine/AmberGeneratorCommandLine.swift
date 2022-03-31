//
//  AmberGeneratorCommandLine.swift
//  
//
//  Created by Dr. Brandon Wiley on 3/30/22.
//

import ArgumentParser
import AmberGenerator
import Foundation

@main
struct AmberGeneratorCommandLine: ParsableCommand
{
    @Argument(help: "The path to the Amber config file")
    var configPath: String

    public func run()
    {
        do
        {
            try Generator.generate(configPath: configPath)
        }
        catch
        {
            print("Generation failed \(error)")
        }
    }
}
