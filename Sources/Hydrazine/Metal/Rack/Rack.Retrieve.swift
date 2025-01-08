//
//  Rack.Retrieve.swift
//  Hydrazine
//
//  Created by Hugh on 6/1/2025.
//

extension Rack {
    
    public static func retrieve<C: ProvidesConfiguration, S: ProvidesSession>(
        configuration: C,
        session: S,
        id: String
    ) async throws -> Self? {
        
        return try await Rack.retrieveMany(
            configuration: configuration,
            session: session,
            id: id
        ).first
        
    }
    
    public static func retrieve<C: ProvidesConfiguration, S: ProvidesSession>(
        configuration: C,
        session: S,
        name: String
    ) async throws -> Self? {
        
        return try await Rack.retrieveMany(
            configuration: configuration,
            session: session,
            name: name
        ).first
    
    }
    
}
