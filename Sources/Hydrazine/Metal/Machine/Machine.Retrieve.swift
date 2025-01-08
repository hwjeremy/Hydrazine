//
//  Machine.Retrieve.swift
//  Hydrazine
//
//  Created by Hugh on 6/1/2025.
//


extension Machine {

    public static func retrieve<O>(
        in context: O,
        id: String
    ) async throws -> Self?
    where O: ProvidesSession, O: ProvidesConfiguration {
        
        return try await Self.retrieve(
            configuration: context,
            session: context,
            id: id
        )
        
    }
    
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
