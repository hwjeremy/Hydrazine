//
//  Server.Create.swift
//  Hydrazine
//
//  Created by Hugh on 6/1/2025.
//

extension Server {

    public static func create<O>(
        in context: O,
        tcpIpv4Port: UInt16,
        tcpIpv6Port: UInt16,
        udpIpv4Port: UInt16,
        udpIpv6Port: UInt16,
        machine: Machine
    ) async throws(HydrazineError) -> Self
    where O: ProvidesConfiguration, O: ProvidesSession {
        
        return try await Self.create(
            configuration: context,
            session: context,
            tcpIpv4Port: tcpIpv4Port,
            tcpIpv6Port: tcpIpv6Port,
            udpIpv4Port: udpIpv4Port,
            udpIpv6Port: udpIpv6Port,
            machine: machine
        )
        
    }
    
    public static func create<C: ProvidesConfiguration, S: ProvidesSession>(
        configuration: C,
        session: S,
        tcpIpv4Port: UInt16,
        tcpIpv6Port: UInt16,
        udpIpv4Port: UInt16,
        udpIpv6Port: UInt16,
        machine: Machine
    ) async throws(HydrazineError) -> Self {
        
        let payload = CreatePayload(
            tcpIpv4Port: Int(tcpIpv4Port),
            tcpIpv6Port: Int(tcpIpv6Port),
            udpIpv4Port: Int(udpIpv4Port),
            udpIpv6Port: Int(udpIpv6Port),
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
        let tcpIpv4Port: Int
        let tcpIpv6Port: Int
        let udpIpv4Port: Int
        let udpIpv6Port: Int
        let machine: String
    }
    
}
