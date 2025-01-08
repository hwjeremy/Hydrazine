//
//  Server.OrderBy.swift
//  Hydrazine
//
//  Created by Hugh on 6/1/2025.
//

extension Server {
    
    public enum OrderBy: String, CaseIterable, Hashable, Identifiable,
                         Sendable {
        
        case created = "created"
        
        public var id: String { return self.rawValue }
        
    }
    
}
