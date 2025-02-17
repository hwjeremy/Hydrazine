//
//  CommandLine.swift
//  HydrazineAPI
//
//  Created by Hugh on 2/1/2025.
//

import Foundation

/// An abstraction of arguments passed to the command line, for easy parsing
internal struct CommandLine {
    
    internal static func valueFor(key: String) -> String? {
        
        let arguments = Swift.CommandLine.arguments
        
        for (index, argument) in arguments.enumerated() {
            
            if argument.replacingOccurrences(of: "--", with: "") != key {
                continue
            }
            
            let valueIndex = index + 1
            
            if !arguments.indices.contains(valueIndex) { continue }
            
            return arguments[valueIndex]

        }

        return nil

    }

}
