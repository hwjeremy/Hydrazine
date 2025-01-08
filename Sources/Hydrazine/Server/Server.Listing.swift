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
        public let ipv4port: Int
        public let ipv6port: Int
        public let clientCapacity: Int
        public let clientsConnected: Int
        public let freeSlots: Int
        public let health: HealthStatus
        public let ipv4: String?
        public let ipv6: String?
        public let serverId: String
        public let name: String?
        public let disposition: Disposition
        
        private enum CodingKeys: String, CodingKey {
            
            case created
            case cutoff
            case region
            case country
            case ipv4port
            case ipv6port
            case clientCapacity = "client_capacity"
            case clientsConnected = "clients_connected"
            case freeSlots = "free_slots"
            case health
            case ipv4
            case ipv6
            case serverId = "server_public_id"
            case name
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
        
    }
    
}
