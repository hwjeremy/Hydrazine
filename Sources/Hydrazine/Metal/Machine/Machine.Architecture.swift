//
//  Machin.Architecture.swift
//  Hydrazine
//
//  Created by Hugh on 4/1/2025.
//

extension Machine {
    
    // A computing device instruction set architecture
    public enum Architecture: Int, Codable, Sendable, CaseIterable, Equatable,
                              Identifiable, Hashable, CustomStringConvertible {
        
        case arm64 = 1
        case x64 = 2
        
        public var id: Int { return self.rawValue }
        
        public var description: String {
            switch self {
            case .arm64:
                return "ARM64"
            case .x64:
                return "x64"
            }
        }
        
        
    }
    
}
