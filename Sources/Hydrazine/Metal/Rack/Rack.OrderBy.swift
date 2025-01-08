//
//  Rack.OrderBy.swift
//  Hydrazine
//
//  Created by Hugh on 4/1/2025.
//

extension Rack {
    
    public enum OrderBy: String, Hashable, CaseIterable, Identifiable,
                         Equatable, Sendable {
        
        case created = "created"
        
        public var id: String { return self.rawValue }
        
    }
    
}
