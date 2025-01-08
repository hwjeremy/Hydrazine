//
//  Domain.swift
//  Hydrazine
//
//  Created by Hugh on 5/1/2025.
//

/// An RFC 1035 domain name
public struct Domain: Decodable, Identifiable, Hashable, Equatable {
    
    public static let maximumNameLength = 256
    public static let minimumNameLength = 3
    
    internal static let path = "/domain"
    
    internal let indexid: Int

    public let domain: String
    public let disposition: Disposition
    
    public var id: Int { return self.indexid }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.indexid == rhs.indexid
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.indexid)
    }
    
}
