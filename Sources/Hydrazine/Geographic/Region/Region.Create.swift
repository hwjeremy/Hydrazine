//
//  Region.Create.swift
//  Hydrazine
//
//  Created by Hugh on 4/1/2025.
//

extension Region {

    public static func create<O>(
        in context: O,
        name: String,
        abbreviation: String,
        country: Country
    ) async throws -> Region
    where O: ProvidesSession, O: ProvidesConfiguration {
        
        return try await Self.create(
            configuration: context,
            session: context,
            name: name,
            abbreviation: abbreviation,
            country: country
        )
        
    }
    
    public static func create<C: ProvidesConfiguration, S: ProvidesSession>(
        configuration: C,
        session: S,
        name: String,
        abbreviation: String,
        country: Country
    ) async throws -> Region {
        
        guard name.count <= Self.maximumNameLength else {
            throw HydrazineError(clientFacingFriendlyMessage: """
Name exceeds maximum length (\(Self.maximumNameLength))
""")
        }
        
        guard name.count >= Self.minimumNameLength else {
            throw HydrazineError(clientFacingFriendlyMessage: """
Name below minimum length (\(Self.minimumNameLength))
""")
        }
        
        guard abbreviation.count <= Self.maximumAbbreviationLength else {
            throw HydrazineError(clientFacingFriendlyMessage: """
Name exceeds maximum length (\(Self.maximumAbbreviationLength))
""")
        }
        
        guard abbreviation.count >= Self.minimumAbbreviationLength else {
            throw HydrazineError(clientFacingFriendlyMessage: """
Name below minimum length (\(Self.minimumAbbreviationLength))
""")
        }
        
        let payload = CreatePayload(
            name: name,
            abbreviation: abbreviation,
            country: country.indexid
        )
        
        let region: Region = try await Request.make(
            configuration: configuration,
            path: Self.path,
            method: .POST,
            requestBody: payload,
            session: session
        )
        
        return region
        
    }
    
    private struct CreatePayload: Encodable {
        
        let name: String
        let abbreviation: String
        let country: Int
        
    }
    
}
