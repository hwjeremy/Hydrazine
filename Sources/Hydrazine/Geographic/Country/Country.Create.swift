//
//  Country.Create.swift
//  HydrazineAPI
//
//  Created by Hugh on 2/1/2025.
//

extension Country {
    
    public static func create<O>(
        in context: O,
        name: String,
        iso3166a2: String
    ) async throws -> Country
    where O: ProvidesSession, O: ProvidesConfiguration {
        
        return try await Self.create(
            configuration: context,
            session: context,
            name: name,
            iso3166a2: iso3166a2
        )
    }
    
    public static func create<C: ProvidesConfiguration, S: ProvidesSession>(
        configuration: C,
        session: S,
        name: String,
        iso3166a2: String
    ) async throws -> Country {
        
        guard name.count <= Self.maximumNameLength else {
            throw HydrazineError(clientFacingFriendlyMessage: """
Name exceeds maximum length (\(Country.maximumNameLength))
""")
        }
        
        guard iso3166a2.count == 2 else {
            throw HydrazineError(clientFacingFriendlyMessage: """
iso3166a2 must be two characters
""")
        }
        
        let payload = CreatePayload(name: name, iso_3166_a2: iso3166a2)
        
        let country: Country = try await Request.make(
            configuration: configuration,
            path: Self.path,
            method: .POST,
            requestBody: payload,
            session: session
        )
        
        return country
        
    }
    
    private struct CreatePayload: Encodable {
        
        let name: String
        let iso_3166_a2: String
        
    }
    
}
