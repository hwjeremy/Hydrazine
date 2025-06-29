//
//  Map.swift
//  Hydrazine
//
//  Created by Hugh on 26/3/2025.
//
import Synchronization

/// A First Company playground
public enum MapID: UInt8, Sendable, Hashable, Equatable, Identifiable,
                 CaseIterable, Codable, AtomicRepresentable {
    
    case none = 0
    case construct = 1
    case pineGap = 2
    
    public var id: UInt8 { return self.rawValue }
    
}
