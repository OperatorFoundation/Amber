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

        let content = """
        //
        //  TYPEPersistenceStrategy.swift
        //

        import AmberBase
        import Foundation

        public class NAME_PersistenceStrategy: PersistenceStrategy
        {
            public var types: Types
            {
                return CONSTRUCTOR
            }

            public func save(_ object: Any) throws -> Data
            {
                guard let typedObject = object as? DESCRIPTION else
                {
                    throw AmberError.wrongTypes(self.types, AmberBase.types(of: object))
                }

                let encoder = JSONEncoder()
                return try encoder.encode(typedObject)
            }

            public func load(_ data: Data) throws -> Any
            {
                let decoder = JSONDecoder()
                return try decoder.decode(DESCRIPTION.self, from: data)
            }
        }
        """
        
        let typeContent = content.description.replacingOccurrences(of: "CONSTRUCTOR", with: types.constructorString).replacingOccurrences(of: "DESCRIPTION", with: types.description).replacingOccurrences(of: "NAME", with: types.typename)
        do
        {
            try typeContent.write(toFile: filepath, atomically: true, encoding: .utf8)
        }
        catch
        {
            print("Could not write to output file \(filepath) \(error)")
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


        let content = """
        //
        //  NAMERegistration.swift
        //

        import AmberBase

        public class NAMERegistration
        {
            static public func register()
            {
        REGISTRATIONS
            }
        }
        """

        let registrationContent = content.description.replacingOccurrences(of: "NAME", with: name).replacingOccurrences(of: "REGISTRATIONS", with: registrations)

        do
        {
            try registrationContent.write(toFile: filepath, atomically: true, encoding: .utf8)
        }
        catch
        {
            print("Could not write to output file \(filepath) \(error)")
            return
        }
    }
}
