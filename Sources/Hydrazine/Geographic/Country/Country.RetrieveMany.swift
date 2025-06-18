//
//  Country.Retrieveman.swift
//  HydrazineAPI
//
//  Created by Hugh on 2/1/2025.
//

extension Country {
    
    private static let retrieveManyPath = Self.path + "/many"
    
    public static func retrieveMany<O>(
        in context: O,
        order: Order = Order.descending,
        orderBy: Self.OrderBy = .name,
        limit: Int = 10,
        offset: Int = 0,
        iso3166a2: String? = nil,
        id: Int? = nil
    ) async throws(HydrazineError) -> Array<Self>
    where O: ProvidesSession, O: ProvidesConfiguration {
                                            
        return try await Self.retrieveMany(
            configuration: context,
            session: context,
            order: order,
            orderBy: orderBy,
            limit: limit,
            offset: offset,
            iso3166a2: iso3166a2,
            id: id
        )
                                            
    }
    
    public static func retrieveMany<C: ProvidesConfiguration, S: ProvidesSession>(
        configuration: C,
        session: S,
        order: Order = Order.descending,
        orderBy: Self.OrderBy = .name,
        limit: Int = 10,
        offset: Int = 0,
        iso3166a2: String? = nil,
        id: Int? = nil
    ) async throws(HydrazineError) -> Array<Self> {
        
        guard limit > 0 else {
            throw HydrazineError(clientFacingFriendlyMessage: "Limit must be > 0")
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
        
        if let iso3166a2 {
            queryItems.append(.init(
                name: "iso_3166_a2",
                value: "\(iso3166a2)"
            ))
        }
        
        if let id {
            queryItems.append(.init(
                name: "indexid",
                value: "\(id)"
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

