//
//  Configuration.swift
//  Hydrazine
//
//  Created by Hugh on 3/1/2025.
//
@testable import Hydrazine


struct TestConfiguration: ProvidesConfiguration {
    
    let apiEndpoint: String
    
    static func fromCommandLine() -> Self {
        
        guard let apiEndpoint = CommandLine.valueFor(
            key: "hydrazine-api-endpoint"
        ) else {
            fatalError("Supply --hydrazine-api-endpoint")
        }
        
        return TestConfiguration(apiEndpoint: apiEndpoint)
        
    }
    
}
