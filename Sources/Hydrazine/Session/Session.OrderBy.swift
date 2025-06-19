//
//  Session.OrderBy.swift
//  Hydrazine
//
//  Created by Hugh on 19/6/2025.
//

extension Session {
    
    public enum OrderBy: String, CaseIterable, Hashable, Identifiable,
                         Sendable {
        
        case created = "created"
        
        public var id: String { return self.rawValue }
        
    }
    
}
