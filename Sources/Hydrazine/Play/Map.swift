//
//  Map.swift
//  Hydrazine
//
//  Created by Hugh on 26/3/2025.
//

/// A First Company playground
public enum Map: UInt8, Sendable, Hashable, Equatable, Identifiable,
                 CaseIterable, Codable {
    
    case construct = 0
    case pineGap = 1
    
    public var id: UInt8 { return self.rawValue }
    
}
