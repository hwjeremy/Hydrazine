//
//  Machine.OperatingSystem.swift
//  Hydrazine
//
//  Created by Hugh on 4/1/2025.
//


extension Machine {
    
    /// A computing device operating system
    public enum OperatingSystem: Int, Codable, Sendable, CaseIterable,
                                 Equatable, CustomStringConvertible,
                                 Identifiable {
        
        case mac = 1
        case linux = 2
        case windows = 3
        
        public var description: String {
            switch self {
            case .linux:
                return "Linux"
            case .mac:
                return "Mac"
            case .windows:
                return "Windows"
            }
        }
        
        public var id: Int { return self.rawValue }
        
    }
    
}
