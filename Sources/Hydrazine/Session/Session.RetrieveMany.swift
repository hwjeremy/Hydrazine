//
//  Session.RetrieveMany.swift
//  Hydrazine
//
//  Created by Hugh on 19/6/2025.
//

extension Session {
    
    private static let retrieveManyPath = Self.path + "/many"
    
    public static func retrieveMany<O>(
        in context: O,
        order: Order = Order.descending,
        orderBy: Self.OrderBy = .created,
        limit: Int = 10,
        offset: Int = 0,
        id publicId: String? = nil,
        beneficiaryAgent agent: StandaloneAgent? = nil
    ) async throws(HydrazineError) -> Array<Self>
    where O: ProvidesSession, O: ProvidesConfiguration {
        
        return try await Self.retrieveMany(
            configuration: context,
            session: context,
            order: order,
            orderBy: orderBy,
            limit: limit,
            offset: offset,
            id: publicId,
            beneficiaryAgent: agent
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
        beneficiaryAgent agent: StandaloneAgent? = nil
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
        
        if let agent {
            queryItems.append(.init(
                name: "beneficiary_agent",
                value: "\(agent.agentId)"
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
