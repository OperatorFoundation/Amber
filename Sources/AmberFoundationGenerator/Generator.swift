//
//  File.swift
//  
//
//  Created by Dr. Brandon Wiley on 3/27/22.
//

import AmberBase
import AmberGenerator
import Foundation
import Gardener

public class FoundationGenerator
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
            //"StringStyle",

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
            //"MeasurementFormatUnitUsage",
            "PersonNameComponents",
            "Locale",
            //"FormatStyleCapitalizationContext",
            "StringStyle",
            "InflectionRule",
            "Morphology",
        ]

        var typeNames = [String](simpleTypes)

        for innerTypeName in simpleTypes
        {
            typeNames.append("Array<\(innerTypeName)>")
        }

        for innerTypeName in hashableTypes
        {
            typeNames.append("Set<\(innerTypeName)>")
        }

        for second in hashableTypes
        {
            for third in simpleTypes
            {
                typeNames.append("Dictionary<\(second), \(third)>")
            }
        }

        Generator.generate(typeNames: typeNames, registrationName: "AmberFoundation", outputPath: outputPath, useBase: true)
    }
}
