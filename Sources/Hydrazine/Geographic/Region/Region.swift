//
//  Region.swift
//  Hydrazine
//
//  Created by Hugh on 4/1/2025.
//

/// A geopolitical subdivision of a ``Country``
///
/// When deciding what ``Server`` instances to offer to a game client,
/// Hydrazine may use `Region` to filter for `Server` instances likely to
/// offer ideal latency characteristics.
///
/// A region might not necessarily be a formal political entity, such as
/// "Oregon". It might instead be a logical subdivision of a `Country`, such
/// as "West Coast".
public struct Region: Decodable, Identifiable, Sendable, Equatable, Hashable {
    
    public static let maximumNameLength = 64
    public static let minimumNameLength = 3
    
    public static let maximumAbbreviationLength = 5
    public static let minimumAbbreviationLength = 2
    
    public static let path = "/region"
    
    internal let indexid: Int

    public let name: String
    public let abbreviation: String
    public let country: Country
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
