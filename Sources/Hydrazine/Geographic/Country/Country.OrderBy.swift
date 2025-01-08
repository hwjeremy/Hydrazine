//
//  Country.OrderBy.swift
//  HydrazineAPI
//
//  Created by Hugh on 2/1/2025.
//


extension Country {
    
    public enum OrderBy: String, Hashable, Equatable, CaseIterable,
                            Identifiable, Sendable {
        
        case name = "name"
    
        public var id: String { return self.rawValue }

    }
    
}
