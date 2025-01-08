//
//  Domain.Retrieve.swift
//  Hydrazine
//
//  Created by Hugh on 6/1/2025.
//

extension Domain {
    
    public static func retrieve<C: ProvidesConfiguration, S: ProvidesSession>(
        configuration: C,
        session: S,
        id: Int
    ) async throws-> Self? {
        
        return try await Self.retrieveMany(
            configuration: configuration,
            session: session,
            id: id
        ).first
        
    }
    
}
