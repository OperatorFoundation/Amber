//
//  Types.swift
//  
//
//  Created by Dr. Brandon Wiley on 3/27/22.
//

import AST
import Foundation
import Parser
import Source

public indirect enum Types: Codable, Hashable, CustomStringConvertible, LosslessStringConvertible
{
    case type(String)
    case generic(String, [Types])

    // CustomStringConvertible, LosslessStringConvertible
    public var description: String
    {
        // This converts to Swift type syntax representation

        switch self
        {
            case .type(let type):
                return type

            case .generic(let base, let parameters):
                let strings = parameters.map
                {
                    type in

                    return type.description
                }

                let inner = strings.joined(separator: ", ")

                return "\(base)<\(inner)>"
        }
    }

    public var constructorString: String
    {
        // This converts to Types constructor syntax representation

        switch self
        {
            case .type(let type):
                return "Types.type(\"\(type)\")"

            case .generic(let base, let parameters):
                let strings = parameters.map
                {
                    type in

                    return type.constructorString
                }

                let inner = strings.joined(separator: ", ")

                return "Types.generic(\"\(base)\", [\(inner)])"
        }
    }

    public var typename: String
    {
        switch self
        {
            case .type(let type):
                return type

            case .generic(let base, let parameters):
                let strings = parameters.map
                {
                    type in

                    return type.typename
                }

                let inner = strings.joined(separator: "_")

                return "\(base)_C_\(inner)_D"
        }
    }

    // LosslessStringConvertible
    public init?(_ string: String)
    {
        // This converts from Swift type syntax representation

        let content = "let x: \(string)"
        let source = SourceFile(content: content)
        let parser = Parser(source: source)

        guard let topLevelDecl = try? parser.parse() else
        {
            return nil
        }

        guard topLevelDecl.statements.count == 1 else
        {
            return nil
        }

        let statement = topLevelDecl.statements[0]

        guard let constant = statement as? ConstantDeclaration else
        {
            return nil
        }

        guard constant.initializerList.count == 1 else
        {
            return nil
        }

        let initializer = constant.initializerList[0]

        guard let patternInitializer = initializer as? PatternInitializer else
        {
            return nil
        }

        guard let pattern = patternInitializer.pattern as? IdentifierPattern else
        {
            return nil
        }

        guard let annotation = pattern.typeAnnotation else
        {
            return nil
        }

        self.init(type: annotation.type)
    }

    init?(type: Type)
    {
        guard let identifier = type as? TypeIdentifier else
        {
            return nil
        }

        guard identifier.names.count > 0 else
        {
            return nil
        }

        let typename = identifier.names[0]

        let nameIdentifier = typename.name

        switch nameIdentifier
        {
            case .name(let name):
                if let genericClause = typename.genericArgumentClause
                {
                    let arguments = genericClause.argumentList

                    let parameters: [Types] = arguments.compactMap
                    {
                        (parameter: Type) -> Types? in

                        return Types(type: parameter)
                    }
                    guard parameters.count == arguments.count else
                    {
                        return nil
                    }

                    self = .generic(name, parameters)
                }
                else
                {
                    self = .type(name)
                    return
                }

            default:
                return nil
        }
    }

    // Hashable
    public func hash(into hasher: inout Hasher)
    {
        switch self
        {
            case .type(let type):
                hasher.combine(type)
            case .generic(let base, let parameters):
                hasher.combine(base)
                parameters.hash(into: &hasher)
        }
    }
}
