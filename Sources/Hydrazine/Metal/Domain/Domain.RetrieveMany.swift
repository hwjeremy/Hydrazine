//
//  Domain.RetrieveMany.swift
//  Hydrazine
//
//  Created by Hugh on 5/1/2025.
//

extension Domain {
    
    private static let retrieveManyPath = Self.path + "/many"
    
    public static func retrieveMany<C: ProvidesConfiguration, S: ProvidesSession>(
        configuration: C,
        session: S,
        order: Order = Order.descending,
        orderBy: Self.OrderBy = .created,
        limit: Int = 10,
        offset: Int = 0,
        id indexid: Int? = nil
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
        
        if let indexid {
            queryItems.append(.init(
                name: "indexid",
                value: "\(indexid)"
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
