//
//  Machine.Provider.Create.swift
//  Hydrazine
//
//  Created by Hugh on 4/1/2025.
//


extension Machine.Provider {

    public static func create<O>(
        in context: O,
        name: String
    ) async throws -> Machine.Provider
    where O: ProvidesSession, O: ProvidesConfiguration {
        
        return try await Self.create(
            configuration: context,
            session: context,
            name: name
        )

    }
    
    public static func create<C: ProvidesConfiguration, S: ProvidesSession>(
        configuration: C,
        session: S,
        name: String
    ) async throws -> Machine.Provider {
        
        guard name.count <= Self.maximumNameLength else {
            throw HydrazineError(clientFacingFriendlyMessage: """
Name exceeds maximum length (\(Self.maximumNameLength))
""")
        }
        
        let payload = CreatePayload(name: name)
        
        let provider: Machine.Provider = try await Request.make(
            configuration: configuration,
            path: Self.path,
            method: .POST,
            requestBody: payload,
            session: session
        )
        
        return provider

    }
    
    private struct CreatePayload: Encodable {
        
        let name: String
        
    }
    
}
