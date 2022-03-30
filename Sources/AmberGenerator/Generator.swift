//
//  File.swift
//  
//
//  Created by Dr. Brandon Wiley on 3/27/22.
//

import AmberBase
import Foundation
import Gardener

public class Generator
{
    static public func generate(typeNames: [String], registrationName: String, outputPath: String)
    {
        if !File.exists(outputPath)
        {
            guard File.makeDirectory(atPath: outputPath) else
            {
                print("Could not create output directory \(outputPath)")
                return
            }
        }

        let typesArray = typeNames.compactMap
        {
            Types($0)
        }

        for types in typesArray
        {
            Generator.writeType(outputPath, types)
        }

        Generator.writeRegistration(name: registrationName, typesArray: typesArray, outputPath: outputPath)

        print("Done!")
    }

    static func writeType(_ outputPath: String, _ types: Types)
    {
        let filepath = "\(outputPath)/\(types.typename)_PersistenceStrategy.swift"
        print("Generating \(filepath)...")

        guard let contentURL = Bundle.module.url(forResource: "TypeTemplate", withExtension: "swift") else
        {
            print("Could not find type template")
            return
        }

        do
        {
            let content = try String(contentsOf: contentURL)
            let typeContent = content.description.replacingOccurrences(of: "CONSTRUCTOR", with: types.constructorString).replacingOccurrences(of: "DESCRIPTION", with: types.description).replacingOccurrences(of: "NAME", with: types.typename)
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
            print("Could not load type template")
            return
        }
    }


    static func writeRegistration(name: String, typesArray: [Types], outputPath: String)
    {
        let filepath = "\(outputPath)/\(name).swift"
        print("Generating \(filepath)...")

        var registrations = ""

        for types in typesArray
        {
            let registration = """
                    AmberBase.register(\(types.typename)_PersistenceStrategy())\n
            """

            registrations.append(registration)
        }

        guard let contentURL = Bundle.module.url(forResource: "RegistrationTemplate", withExtension: "swift") else
        {
            print("Could not find registration template")
            return
        }

        let registrationContent: String
        do
        {
            let content = try String(contentsOf: contentURL)
            registrationContent = content.description.replacingOccurrences(of: "NAME", with: name).replacingOccurrences(of: "REGISTRATIONS", with: registrations)
        }
        catch
        {
            print("Could not load registration template")
            return
        }

        do
        {
            try registrationContent.write(toFile: filepath, atomically: true, encoding: .utf8)
        }
        catch
        {
            print("Could not write to output file \(filepath)")
            return
        }
    }
}
