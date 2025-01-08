//
//  Server.Listing.OrderBy.swift
//  Hydrazine
//
//  Created by Hugh on 6/1/2025.
//

extension Server.Listing {
    
    public enum OrderBy: String, Decodable, Hashable, Identifiable,
                         CaseIterable, Sendable {
        
        case clientsConnected = "clients_connected"
        case freeSlots = "free_slots"
        
        public var id: String { return self.rawValue }
        
    }
    
}
