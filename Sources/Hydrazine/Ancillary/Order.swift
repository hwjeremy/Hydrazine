//
//  Order.swift
//  HydrazineAPI
//
//  Created by Hugh on 2/1/2025.
//

import Foundation


public enum Order: String, Identifiable, Hashable, Equatable, CaseIterable,
                   Sendable {
    
    case ascending = "ascending"
    case descending = "descending"
    
    public var id: String { return self.rawValue }

}
