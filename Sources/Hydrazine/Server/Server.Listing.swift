//
//  Server.Listing.swift
//  Hydrazine
//
//  Created by Hugh on 6/1/2025.
//
import Foundation


extension Server {
    
    public struct Listing: Decodable, Identifiable, Hashable, Sendable,
                           Equatable {
        
        internal static let path = Server.path + "/listing"
        
        public let created: Date
        public let cutoff: Date
        public let region: Region.Headline
        public let country: Country.Headline
        public let tcpIpv4Port: UInt16
        public let tcpIpv6Port: UInt16 
        public let udpIpv4Port: UInt16
        public let udpIpv6Port: UInt16
        public let networkOperationsId: UInt32
        public let clientCapacity: Int
        public let clientsConnected: Int
        public let freeSlots: Int
        public let health: HealthStatus
        public let ipv4: String?
        public let ipv6: String?
        public let serverId: String
        public let name: String?
        public let map: MapID?
        public let disposition: Disposition

        private enum CodingKeys: String, CodingKey {
            
            case created
            case cutoff
            case region
            case country
            case tcpIpv4Port = "tcp_ipv4_port"
            case tcpIpv6Port = "tcp_ipv6_port"
            case udpIpv4Port = "udp_ipv4_port"
            case udpIpv6Port = "udp_ipv6_port"
            case networkOperationsId = "network_operations_id"
            case clientCapacity = "client_capacity"
            case clientsConnected = "clients_connected"
            case freeSlots = "free_slots"
            case health
            case ipv4
            case ipv6
            case serverId = "server_public_id"
            case name
            case map
            case disposition
            
        }
        
        public var id: String {
            return "\(self.serverId)_\(self.created)"
        }
        
        public static func == (lhs: Self, rhs: Self) -> Bool {
            return lhs.id == rhs.id
        }
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(self.id)
            return
        }
        
        public static let example = Self(
            created: Date(),
            cutoff: Date(),
            region: .init(name: "New South Wales", abbreviation: "NSW"),
            country: .init(name: "Australia", iso3166a2: "AU"),
            tcpIpv4Port: 2000,
            tcpIpv6Port: 2001,
            udpIpv4Port: 3000,
            udpIpv6Port: 3001,
            networkOperationsId: 400,
            clientCapacity: 32,
            clientsConnected: 6,
            freeSlots: 31 - 6,
            health: .good,
            ipv4: "154.22.219.121",
            ipv6: nil,
            serverId: "example",
            name: "24/7 Pine Gap | All Weapons | 100 Tick",
            map: .pineGap,
            disposition: .init(sequence: 1, count: 1, limit: 1, offset: 0)
        )
        
    }
    
}


extension Array<Server.Listing> {
    
    public func withNetworkOperationsId(_ nid: UInt32) -> Server.Listing? {
        
        for listing in self {
            if listing.networkOperationsId == nid {
                return listing
            }
            continue
        }
        
        return nil
        
    }
    
}
