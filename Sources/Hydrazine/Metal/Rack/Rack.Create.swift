//
//  Rack.Create.swift
//  Hydrazine
//
//  Created by Hugh on 4/1/2025.
//

/// A physical collection of ``Machine``
extension Rack {

    public static func create<O>(
        in context: O,
        name: String,
        region: Region,
        provider: Machine.Provider
    ) async throws(HydrazineError) -> Rack
    where O: ProvidesSession, O: ProvidesConfiguration {
     
        return try await Self.create(
            configuration: context,
            session: context,
            name: name,
            region: region,
            provider: provider
        )
        
    }
        
    
    public static func create<C: ProvidesConfiguration, S: ProvidesSession>(
        configuration: C,
        session: S,
        name: String,
        region: Region,
        provider: Machine.Provider
    ) async throws(HydrazineError) -> Rack {
        
        guard name.count <= Self.maximumNameLength else {
            throw HydrazineError(clientFacingFriendlyMessage: """
Name exceeds maximum length (\(Self.maximumNameLength))
""")
        }
        
        guard name.count >= Self.minimumNameLength else {
            throw HydrazineError(clientFacingFriendlyMessage: """
Name exceeds maximum length (\(Self.minimumNameLength))
""")
        }
        
        let payload = CreatePayload(
            name: name,
            region: region.indexid,
            provider: provider.indexid
        )
        
        let rack: Rack = try await Request.make(
            configuration: configuration,
            path: Self.path,
            method: .POST,
            requestBody: payload,
            session: session
        )
        
        return rack
        
    }
    
    private struct CreatePayload: Encodable {
        let name: String
        let region: Int
        let provider: Int
    }

}
