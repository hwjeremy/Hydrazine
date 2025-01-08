//
//  Machine.OrderBy.swift
//  Hydrazine
//
//  Created by Hugh on 4/1/2025.
//

extension Machine {
    
    public enum OrderBy: String, Equatable, CaseIterable, Identifiable,
                         Hashable, Sendable {
        
        case created = "created"
        
        public var id: String { return self.rawValue }
        
    }
    
}
