//
//  File.swift
//  
//
//  Created by Dr. Brandon Wiley on 3/27/22.
//

import Foundation
import Gardener

public class Generator
{
    static public func generate()
    {
        let outputPath = File.currentDirectory() + "/Sources/AmberFoundation"
        if !File.exists(outputPath)
        {
            guard File.makeDirectory(atPath: outputPath) else
            {
                print("Could not create output directory \(outputPath)")
                return
            }
        }

        let types: [String] = [
            "String"
        ]

        var registrations = ""

        for type in types
        {
            let filepath = "\(outputPath)/\(type)PersistenceStrategy.swift"
            print("Generating \(filepath)...")

            guard let contentURL = Bundle.module.url(forResource: "AmberTemplate", withExtension: "swift") else
            {
                print("Could not find template")
                return
            }

            do
            {
                let content = try String(contentsOf: contentURL)
                let typeContent = content.description.replacingOccurrences(of: "TYPE", with: type)
                do
                {
                    try typeContent.write(toFile: filepath, atomically: true, encoding: .utf8)
                }
                catch
                {
                    print("Could not write to output file \(filepath)")
                    return
                }
            }
            catch
            {
                print("Could not load template")
                return
            }

            let registration = """
                    AmberBase.register(\(type)PersistenceStrategy())
            """
            registrations.append(registration)
        }

        let filepath = "\(outputPath)/AmberFoundation.swift"
        print("Generating \(filepath)...")

        let content = """
        import AmberBase

        public class AmberFoundation
        {
            static public func register()
            {
        \(registrations)
            }
        }
        """

        do
        {
            try content.write(toFile: filepath, atomically: true, encoding: .utf8)
        }
        catch
        {
            print("Could not write to output file \(filepath)")
            return
        }


        print("Done!")
    }
}
