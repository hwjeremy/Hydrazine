//
//  Server.Create.swift
//  Hydrazine
//
//  Created by Hugh on 6/1/2025.
//

extension Server {

    public static func create<O>(
        in context: O,
        ipv4Port: UInt16,
        ipv6Port: UInt16,
        machine: Machine
    ) async throws -> Self
    where O: ProvidesConfiguration, O: ProvidesSession {
        
        return try await Self.create(
            configuration: context,
            session: context,
            ipv4Port: ipv4Port,
            ipv6Port: ipv6Port,
            machine: machine
        )
        
    }
    
    public static func create<C: ProvidesConfiguration, S: ProvidesSession>(
        configuration: C,
        session: S,
        ipv4Port: UInt16,
        ipv6Port: UInt16,
        machine: Machine
    ) async throws -> Self {
        
        let payload = CreatePayload(
            ipv4Port: Int(ipv4Port),
            ipv6Port: Int(ipv6Port),
            machine: machine.id
        )
        
        let server: Server = try await Request.make(
            configuration: configuration,
            path: Self.path,
            method: .POST,
            requestBody: payload,
            session: session
        )
        
        return server
        
    }
    
    private struct CreatePayload: Encodable {
        let ipv4Port: Int
        let ipv6Port: Int
        let machine: String
    }
    
}

