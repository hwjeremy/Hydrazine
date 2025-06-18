//
//  Machine.Provider.RetrieveMany.swift
//  Hydrazine
//
//  Created by Hugh on 4/1/2025.
//

extension Machine.Provider {
    
    private static let retrieveManyPath = Self.path + "/many"
    
    public static func retrieveMany<O>(
        in context: O,
        order: Order = Order.descending,
        orderBy: Self.OrderBy = .name,
        limit: Int = 10,
        offset: Int = 0,
        id indexid: Int? = nil,
        name: String? = nil
    ) async throws -> Array<Self>
    where O: ProvidesConfiguration, O: ProvidesSession {
     
        return try await Self.retrieveMany(
            configuration: context,
            session: context,
            order: order,
            orderBy: orderBy,
            limit: limit,
            offset: offset,
            id: indexid,
            name: name
        )
        
    }
    
    public static func retrieveMany<C: ProvidesConfiguration, S: ProvidesSession>(
        configuration: C,
        session: S,
        order: Order = Order.descending,
        orderBy: Self.OrderBy = .name,
        limit: Int = 10,
        offset: Int = 0,
        id indexid: Int? = nil,
        name: String? = nil
    ) async throws -> Array<Self> {
        
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
        
        if let indexid {
            queryItems.append(.init(
                name: "indexid",
                value: "\(indexid)"
            ))
        }
        
        if let name {
            queryItems.append(.init(
                name: "name",
                value: name
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
