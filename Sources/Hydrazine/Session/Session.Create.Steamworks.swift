//
//  Session.Create.swift
//  Hydrazine
//
//  Created by Hugh on 19/6/2025.
//

extension Session {
    
    private static let ticketPath = Self.path + "/steam-ticket"
    
    private struct CreatePayload: Encodable {
        let steam_ticket_hex_string: String
    }
    
    public static func create<C: ProvidesConfiguration>(
        configuration: borrowing C,
        steamTicketHexString: String,
        name: String? = nil
    ) async throws(HydrazineError) -> Self {
        
        let payload = CreatePayload(
            steam_ticket_hex_string: steamTicketHexString
        )
        
        let result: Self = try await Request.make(
            configuration: configuration,
            path: Self.ticketPath,
            method: .POST,
            requestBody: payload,
            session: nil as Session?
        )
        
        return result
        
    }
    
}
