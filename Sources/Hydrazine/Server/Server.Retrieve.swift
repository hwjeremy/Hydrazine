//
//  Server.Retrieve.swift
//  Hydrazine
//
//  Created by Hugh on 6/1/2025.
//

extension Server {
    
    public static func retrieve<C: ProvidesConfiguration, S: ProvidesSession>(
        configuration: C,
        session: S,
        id: String
    ) async throws -> Self? {
        
        return try await Self.retrieveMany(
            configuration: configuration,
            session: session,
            id: id
        ).first

    }
    
}
