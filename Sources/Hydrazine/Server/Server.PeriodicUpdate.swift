//
//  Server.PeriodicUpdate.swift
//  Hydrazine
//
//  Created by Hugh on 6/1/2025.
//


extension Server {
    
    /// Data describing the state of a running ``Server``
    ///
    /// After creating a `Server`, the game server process should send a steady
    /// stream of `PeriodicUpdate` to Hydrazine. Hydrazine expects an update
    /// at least once every three seconds, or the `Server` will no longer
    /// appear as a ``Listing`` to clients.
    ///
    /// Failing to send `PeriodicUpdate` will not cause a game server to
    /// shutdown, or disconnect clients. However, new clients will not be
    /// able to connect, because they will not be able to discover the game
    /// server via `Listing`.
    public struct PeriodicUpdate {
        
        internal static let path = Server.path + "/periodic-update"

        public static func create<O>(
            in context: O,
            server: Server,
            clientCapacity: Int,
            clientsConnected: Int,
            health: Server.HealthStatus
        ) async throws -> Void
        where O: ProvidesSession, O: ProvidesConfiguration {
            
            return try await Self.create(
                configuration: context,
                session: context,
                server: server,
                clientCapacity: clientCapacity,
                clientsConnected: clientsConnected,
                health: health
            )
    
        }
        
        public static func create<C: ProvidesConfiguration, S: ProvidesSession>(
            configuration: C,
            session: S,
            server: Server,
            clientCapacity: Int,
            clientsConnected: Int,
            health: Server.HealthStatus
        ) async throws -> Void {
            
            let payload = CreatePayload(
                server: server.id,
                client_capacity: clientCapacity,
                clients_connected: clientsConnected,
                health_status: health.rawValue
            )
            
            try await Request.make(
                configuration: configuration,
                path: Self.path,
                method: .POST,
                requestBody: payload,
                session: session
            )
            
            return
            
        }
        
        private struct CreatePayload: Encodable {
            
            let server: String
            let client_capacity: Int
            let clients_connected: Int
            let health_status: Int
            
        }
        
    }
    
}
