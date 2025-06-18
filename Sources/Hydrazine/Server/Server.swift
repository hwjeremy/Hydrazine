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
    
    public let tcpIpv4port: UInt16
    public let tcpIpv6port: UInt16
    public let udpIpv4port: UInt16
    public let udpIpv6port: UInt16
    
    /// An identifier for game client / game server communication
    ///
    /// This ID is guaranteed to be unique among active `Server` instances,
    /// but not among all `Server` instances over all time.
    public let networkOperationsId: UInt32
    
    internal let publicId: String

    public let ipv4: String?
    public let ipv6: String?
    public let disposition: Disposition
    
    public var id: String { return self.publicId }
    
    private enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
        case networkOperationsId = "network_operations_id"
        case ipv4
        case ipv6
        case tcpIpv4port = "tcp_ipv4_port"
        case tcpIpv6port = "tcp_ipv6_port"
        case udpIpv4port = "udp_ipv4_port"
        case udpIpv6port = "udp_ipv6_port"
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
