//
//  Server.swift
//  Hydrazine
//
//  Created by Hugh on 6/1/2025.
//

/// An instance of a the game server process running on a ``Machine``.
///
/// One or more `Server` might run on a `Machine`. Each `Server` runs on a
/// unique IPv4 and/or IPv6 port. It is the responsibility of the game server
/// process to create a `Server` on startup, and then periodically inform
/// Hydrazine of its state with ``PeriodicUpdate``.
public struct Server: Hashable, Equatable, Identifiable, Sendable, Decodable {
    
    internal static let path = "/server"
    
    internal let publicId: String

    public let ipv4: String?
    public let ipv6: String?
    public let ipv4port: UInt16
    public let ipv6port: UInt16
    public let disposition: Disposition
    
    public var id: String { return self.publicId }
    
    private enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
        case ipv4
        case ipv6
        case ipv4port
        case ipv6port
        case disposition
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
        return
    }
    
}
