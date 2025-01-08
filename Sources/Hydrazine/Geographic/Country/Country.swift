//
//  Country.swift
//  HydrazineAPI
//
//  Created by Hugh on 2/1/2025.
//

/// A broad-scale geopolitical entity
///
/// When deciding what ``Server`` instances to offer to clients, Hydrazine
/// will start by filtering at the level of `Country`, or collections of
/// `Country`. It will then consider ``Region`` to further refine a collection
/// of `Server` that are likely to exhibit ideal latency characteristics for
/// the client.
public struct Country: Decodable, Identifiable, Sendable, Equatable, Hashable {
    
    internal static let path = "/country"

    public static let maximumNameLength = 64
    
    /// The unique, stable identifier of this `Country`
    public let indexid: Int
    public let name: String
    public let iso3166a2: String
    public let disposition: Disposition
    
    /// An alias for `indexid`
    public var id: Int { return self.indexid }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.indexid == rhs.indexid
    }

    public func hash(into hasher: inout Hasher) -> Void {
        hasher.combine(self.indexid)
        return
    }

}
