//
//  Rack.RetrieveMany.swift
//  Hydrazine
//
//  Created by Hugh on 4/1/2025.
//

extension Rack {
    
    private static let retrieveManyPath = Self.path + "/many"
    
    public static func retrieveMany<O>(
        in context: O,
        order: Order = Order.descending,
        orderBy: Self.OrderBy = .created,
        limit: Int = 10,
        offset: Int = 0,
        id publicId: String? = nil,
        name: String? = nil,
        region: Region? = nil,
        country: Country? = nil,
        provider: Machine.Provider? = nil
    ) async throws(HydrazineError) -> Array<Self>
    where O: ProvidesConfiguration, O: ProvidesSession {
     
        return try await Rack.retrieveMany(
            configuration: context,
            session: context,
            order: order,
            orderBy: orderBy,
            limit: limit,
            offset: offset,
            id: publicId,
            name: name,
            region: region,
            country: country,
            provider: provider
        )
        
    }
    
    public static func retrieveMany<C: ProvidesConfiguration, S: ProvidesSession>(
        configuration: C,
        session: S,
        order: Order = Order.descending,
        orderBy: Self.OrderBy = .created,
        limit: Int = 10,
        offset: Int = 0,
        id publicId: String? = nil,
        name: String? = nil,
        region: Region? = nil,
        country: Country? = nil,
        provider: Machine.Provider? = nil
    ) async throws(HydrazineError) -> Array<Self> {
        
        guard limit > 0 else {
            throw HydrazineError(
                clientFacingFriendlyMessage: "Limit must be > 0"
            )
        }
        
        guard offset >= 0 else {
            throw HydrazineError(clientFacingFriendlyMessage: """
Offset must be >= 0
""")
        }
        
        var queryItems: Array<QueryItem> = [
            .init(name: "limit", value: "\(limit)"),
            .init(name: "offset", value: "\(offset)"),
            .init(name: "order", value: order.rawValue),
            .init(name: "order_by", value: orderBy.rawValue)
        ]
        
        if let publicId {
            queryItems.append(.init(
                name: "public_id",
                value: publicId
            ))
        }
        
        if let name {
            queryItems.append(.init(
                name: "name",
                value: name
            ))
        }
        
        if let region {
            queryItems.append(.init(
                name: "region",
                value: "\(region.indexid)"
            ))
        }
        
        if let provider {
            queryItems.append(.init(
                name: "provider",
                value: "\(provider.indexid)"
            ))
        }

        let results: Array<Self> = try await Request.make(
            configuration: configuration,
            path: Self.retrieveManyPath,
            method: .GET,
            queryItems: queryItems,
            session: session
        )
        
        return results
        
    }
    
}
