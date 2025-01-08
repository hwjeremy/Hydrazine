//
//  Region.OrderBy.swift
//  Hydrazine
//
//  Created by Hugh on 4/1/2025.
//


extension Region {
    
    public enum OrderBy: String, Hashable, Equatable, CaseIterable,
                            Identifiable, Sendable {
        
        case name = "name"
    
        public var id: String { return self.rawValue }

    }
    
}
