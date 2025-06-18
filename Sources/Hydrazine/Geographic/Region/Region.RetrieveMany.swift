//
//  Region.RetrieveMany.swift
//  Hydrazine
//
//  Created by Hugh on 4/1/2025.
//

extension Region {
    
    private static let retrieveManyPath = Self.path + "/many"
    
    public static func retrieveMany<O>(
        in context: O,
        order: Order = Order.descending,
        orderBy: Self.OrderBy = .name,
        limit: Int = 10,
        offset: Int = 0,
        country: Country? = nil,
        id indexid: Int? = nil,
        name: String? = nil,
        abbreviation: String? = nil
    ) async throws(HydrazineError) -> Array<Self>
    where O: ProvidesSession, O: ProvidesConfiguration {
        
        return try await Self.retrieveMany(
            configuration: context,
            session: context,
            order: order,
            orderBy: orderBy,
            limit: limit,
            offset: offset,
            country: country,
            id: indexid,
            abbreviation: abbreviation
        )
        
    }
        
    public static func retrieveMany<C: ProvidesConfiguration, S: ProvidesSession>(
        configuration: C,
        session: S,
        order: Order = Order.descending,
        orderBy: Self.OrderBy = .name,
        limit: Int = 10,
        offset: Int = 0,
        country: Country? = nil,
        id indexid: Int? = nil,
        name: String? = nil,
        abbreviation: String? = nil
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
        
        if let country {
            queryItems.append(.init(
                name: "country",
                value: "\(country.indexid)"
            ))
        }
        
        if let indexid {
            queryItems.append(.init(
                name: "indexid",
                value: "\(indexid)"
            ))
        }
        
        if let name {
            queryItems.append(.init(
                name: "name",
                value: "\(name)"
            ))
        }
        
        if let abbreviation {
            queryItems.append(.init(
                name: "abbreviation",
                value: "\(abbreviation)"
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
