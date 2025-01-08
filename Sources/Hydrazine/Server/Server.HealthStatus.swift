//
//  Server.HealthStatus.swift
//  Hydrazine
//
//  Created by Hugh on 6/1/2025.
//


extension Server {
    
    public enum HealthStatus: Int, CaseIterable, Hashable, Sendable,
                              Identifiable, Equatable, Codable {
        
        case unknown = 0
        case good = 1
        case causeForConcern = 2
        case poorDoNotConnect = 3
        
        public var id: Int { return self.rawValue }
        
    }
    
    
}
