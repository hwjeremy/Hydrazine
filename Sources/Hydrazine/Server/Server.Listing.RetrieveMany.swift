//
//  Server.Listing.RetrieveMany.swift
//  Hydrazine
//
//  Created by Hugh on 6/1/2025.
//

extension Server.Listing {
    
    private static let retrieveManyPath = Server.Listing.path + "/many"

    public static func retrieveMany<O>(
        in context: O,
        order: Order = Order.descending,
        orderBy: Self.OrderBy = .freeSlots,
        limit: Int = 10,
        offset: Int = 0,
        country: Country? = nil,
        region: Region? = nil
    ) async throws(HydrazineError) -> Array<Self>
    where O: ProvidesConfiguration, O: ProvidesSession{
        
        return try await Self.retrieveMany(
            configuration: context,
            session: context,
            order: order,
            orderBy: orderBy,
            limit: limit,
            offset: offset,
            country: country,
            region: region
        )
        
    }
    
    public static func retrieveMany<C: ProvidesConfiguration, S: ProvidesSession>(
        configuration: C,
        session: S,
        order: Order = Order.descending,
        orderBy: Self.OrderBy = .freeSlots,
        limit: Int = 10,
        offset: Int = 0,
        country: Country? = nil,
        region: Region? = nil
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
        
        
        if let region {
            queryItems.append(.init(
                name: "region",
                value: "\(region.indexid)"
            ))
        }
        
        if let country {
            queryItems.append(.init(
                name: "country",
                value: "\(country.indexid)"
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
