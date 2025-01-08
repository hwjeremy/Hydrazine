//
//  Disposition.swift
//  HydrazineAPI
//
//  Created by Hugh on 2/1/2025.
//

/// Data describing the position of a retrieved object relative to its peers
public struct Disposition: Codable, Sendable, Hashable, Equatable {
    
    /// The position of the individual object of which this `Disposition` is
    /// a member
    public let sequence: Int

    /// The total number of objects retrieved in context
    public let count: Int
    
    /// The limit placed on the number of objects to be retrieved in context
    public let limit: Int
    
    /// The offset applied to the objects retrieved in context
    public let offset: Int

}
