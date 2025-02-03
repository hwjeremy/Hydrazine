//
//  Domain.Create.swift
//  Hydrazine
//
//  Created by Hugh on 5/1/2025.
//

extension Domain {
    
    public static func create<C: ProvidesConfiguration, S: ProvidesSession>(
        configuration: C,
        session: S,
        name: String
    ) async throws(HydrazineError) -> Domain {
        
        guard name.count <= Self.maximumNameLength else {
            throw HydrazineError(clientFacingFriendlyMessage: """
Domain name exceeds maximimum length (\(Self.maximumNameLength))
""")
        }
        
        guard name.count >= Self.minimumNameLength else {
            throw HydrazineError(clientFacingFriendlyMessage: """
Domain name exceeds minimum length (\(Self.minimumNameLength))
""")
        }
        
        let payload = CreatePayload(domain: name)
        
        let domain: Domain = try await Request.make(
            configuration: configuration,
            path: Self.path,
            method: .POST,
            requestBody: payload,
            session: session
        )
        
        return domain

    }
    
    private struct CreatePayload: Encodable {
        
        let domain: String
        
    }
    
}
