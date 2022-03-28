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

        let simpleTypes: [String] = [
            // Numbers, Data, and Basic Values
            // Numbers
            "Int",
            "Double",
            "Decimal",
            //"NumberFormatter",

            // Binary Data
            "Data",

            // URLs
            "URL",
            "URLComponents",
            //"URLQueryItem",

            // Unique Identifiers
            "UUID",

            // Geometry
            "CGFloat",
            "NSPoint",
            "NSSize",
            "NSRect",
            "AffineTransform",
            //"NSEdgeInsets",

            // Ranges
            "NSRange",

            // Strings and Text
            // Strings
            "String",

            // Strings with Metadata
            "AttributedString",
            //"AttributedSubstring",
            //"NSAttributedString",
            //"NSMutableAttributedString",

            // Characters
            "CharacterSet",
            //"UnicodeScalar",

            // Pattern Matching
            //"Scanner",
            //"NSRegularExpression",
            //"NSDataDetector",
            //"NSTextCheckingResult",

            // Spelling and Grammar
            //"NSSpellServer",
            //"NSSpellServerDelegate",

            // Localization
            "Locale",
            //"NSOrthography",
            //"NSLocalizedString",

            //Collections
            // Indexes
            "IndexPath",
            "IndexSet",

            // Specialized Sets
            //"NSCountedSet",
            //"NSOrderedSet",
            //"NSMutableOrderedSet",

            // Purgeable Collections
            //"NSCache",
            //"NSPurgeableData",

            // Pointer Collections
            //"NSPointerArray",
            //"NSMapTable",
            //"NSHashTable",

            // Iteration
            //"NSEnumerator",
            //"NSFastEnumeration",
            //"NSFastEnumerationIterator",
            //"NSIndexSetIterator",
            //"NSEnumerationOptions",
            //"NSSortOptions",

            // Special Semantic Values
            //"NSNull",

            // Date and Times
            // Date Representations
            "Date",
            "DateInterval",
            "TimeInterval",

            // Calendrical Calculations
            "DateComponents",
            "Calendar",
            "TimeZone",

            // Date Formatting
            //"DateFormatter",
            //"DateComponentsFormatter",
            //"DateIntervalFormatter",
            //"ISO8601DateFormatter",

            // Internationalization
            "Locale",

            // Units and Measurement
            // Essentials
            //"Measurement",
            //"Unit",
            //"Dimension",

            // Conversion
            //"UnitConverter",
            //"UnitConverterLinear",

            // Physical Dimensions
            //"UnitArea",
            //"UnitLength",
            //"UnitVolume",
            //"UnitAngle",

            // Mass, Weight, and Force
            //"UnitMass",
            //"UnitPressure",

            // Time and Motion
            //"UnitAcceleration",
            //"UnitDuration",
            //"UnitFrequency",
            //"UnitSpeed",

            // Energy, Heat, and Light
            //"UnitEnergy",
            //"UnitPower",
            //"UnitTemperature",
            //"UnitIlluminance",

            // Electricity
            //"UnitElectricCharge",
            //"UnitElectricCurrent",
            //"UnitElectricPotentialDifference",
            //"UnitElectricResistance",

            // Concentration and Dispersion
            //"UnitConcentraionMass",
            //"UnitDispersion",

            // Fuel Efficiency
            //"UnitFuelEfficiency",

            // Data Storage
            //"UnitInformationStorage",

            // Formatting Meausrements
            "MeasurementFormatUnitUsage",

            // Data Formatting
            // Numbers and Currency
            //"NumberFormatter",

            // Names
            //"PersonNameComponentsFormatter",
            "PersonNameComponents",

            // Dates and Times
            //"DateFormatter",
            //"DateComponentsFormatter",
            //"RelativeDateTimeFormatter",
            //"DateIntervalFormatter",
            //"ISO8601DateFormatter",

            // Data Sizes
            //"ByteCountFormatter",

            // Measurements
            //"MeasurementFormatter",

            // Lists
            //"ListFormatter",

            // Internationalization
            "Locale",

            // Custom Formatters
            //"Formatter",

            // Data Formatting in Swift
            "FormatStyleCapitalizationContext",
            //"IntegerFormatStyle", // FIXME - needs generics support
            //"FloatingPointFormatStyle", // FIXME - needs generics support
            //"ListFormatStyle", // FIXME - needs generics support
            "StringStyle",

            // Data Parsing in Swift
            //"ParseableFormatStyle",
            //"FloatingPointParseStrategy", // FIXME - needs generics support

            // Automatic Grammar Agreement
            "InflectionRule",
            "Morphology",

            // Filters and Sorting
            // Filtering
            //"NSPredicate",
            //"NSExpression",
            //"NSComparisonPredicate",
            //"NSCompoundPredicate",

            // Sorting
            //"NSSortDescriptor",
            //"ComparisonResult",
            //"SortDescriptor",
            //"SortComparator",
            //"ComparableComparator",
            //"KeyPathComparator",
            //"SortOrder",

            // App Support
            // skipped

            // Files and Data Persistence
            // skipped

            // Networking
            // skipped

            // Low-Level Utilities
            // skipped

            // Structures
            // skipped
        ]

        let hashableTypes: [String] = [
            "Int",
            "Double",
            "Decimal",
            "Data",
            "URL",
            "URLComponents",
            "UUID",
            "CGFloat",
            "AffineTransform",
            "NSRange",
            "String",
            "AttributedString",
            "CharacterSet",
            "Locale",
            "IndexPath",
            "IndexSet",
            "Date",
            "DateInterval",
            "TimeInterval",
            "DateComponents",
            "Calendar",
            "TimeZone",
            "Locale",
            "MeasurementFormatUnitUsage",
            "PersonNameComponents",
            "Locale",
            "FormatStyleCapitalizationContext",
            "StringStyle",
            "InflectionRule",
            "Morphology",
        ]

        var registrations = ""

        for type in simpleTypes
        {
            let filepath = "\(outputPath)/\(type)PersistenceStrategy.swift"
            print("Generating \(filepath)...")

            guard let contentURL = Bundle.module.url(forResource: "SimpleTemplate", withExtension: "swift") else
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
                    AmberBase.register(\(type)PersistenceStrategy())\n
            """
            registrations.append(registration)
        }

        for innerType in simpleTypes
        {
            let filepath = "\(outputPath)/Array\(innerType)PersistenceStrategy.swift"
            print("Generating \(filepath)...")

            guard let contentURL = Bundle.module.url(forResource: "OneGapTemplate", withExtension: "swift") else
            {
                print("Could not find template")
                return
            }

            do
            {
                let content = try String(contentsOf: contentURL)
                let typeContent = content.description.replacingOccurrences(of: "INNER", with: innerType).replacingOccurrences(of: "OUTER", with: "Array")
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
                    AmberBase.register(Array\(innerType)PersistenceStrategy())\n
            """
            registrations.append(registration)
        }

        for innerType in hashableTypes
        {
            let filepath = "\(outputPath)/Set\(innerType)PersistenceStrategy.swift"
            print("Generating \(filepath)...")

            guard let contentURL = Bundle.module.url(forResource: "OneGapTemplate", withExtension: "swift") else
            {
                print("Could not find template")
                return
            }

            do
            {
                let content = try String(contentsOf: contentURL)
                let typeContent = content.description.replacingOccurrences(of: "INNER", with: innerType).replacingOccurrences(of: "OUTER", with: "Set")
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
                    AmberBase.register(Set\(innerType)PersistenceStrategy())\n
            """
            registrations.append(registration)
        }

        for second in hashableTypes
        {
            for third in simpleTypes
            {
                let filepath = "\(outputPath)/Dictionary\(second)\(third)PersistenceStrategy.swift"
                print("Generating \(filepath)...")

                guard let contentURL = Bundle.module.url(forResource: "TwoGapTemplate", withExtension: "swift") else
                {
                    print("Could not find template")
                    return
                }

                do
                {
                    let content = try String(contentsOf: contentURL)
                    let typeContent = content.description.replacingOccurrences(of: "FIRST", with: "Dictionary").replacingOccurrences(of: "SECOND", with: second).replacingOccurrences(of: "THIRD", with: third)
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
                        AmberBase.register(Dictionary\(second)\(third)PersistenceStrategy())\n
                """
                registrations.append(registration)
            }
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
