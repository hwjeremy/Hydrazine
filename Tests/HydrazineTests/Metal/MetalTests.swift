//
//  MetalTests.swift
//  Hydrazine
//
//  Created by Hugh on 6/1/2025.
//
import Testing
@testable import Hydrazine
import Foundation


@Suite("Metal Tests")
struct MetalTests {
    
    @Test("Create & retrieve Domain")
    func testCreateRetrieveDomain() async throws -> Void {
        
        let configuration = TestConfiguration.fromCommandLine()
        
        let k = pseudoRandomId()
        
        let d1 = try await Domain.create(
            configuration: configuration,
            session: EPHEMERAL_TEST_SESSION,
            name: "\(k).1coy.net"
        )
        
        let d1_r = try await Domain.retrieve(
            configuration: configuration,
            session: EPHEMERAL_TEST_SESSION,
            id: d1.id
        )
        
        #expect(d1_r?.id == d1.id)
        
        return
        
    }
    
    @Test("Create & retrieve Provider")
    func testCreateAndRetrieveProvider() async throws -> Void {
        
        let configuration = TestConfiguration.fromCommandLine()
        
        let k = pseudoRandomId()
        
        let _ = try await Machine.Provider.create(
            configuration: configuration,
            session: EPHEMERAL_TEST_SESSION,
            name: "Provider_\(k)_"
        )
        
        let p1 = try await Machine.Provider.create(
            configuration: configuration,
            session: EPHEMERAL_TEST_SESSION,
            name: "Provider_\(k)"
        )
        
        let p1_r_i = try await Machine.Provider.retrieve(
            configuration: configuration,
            session: EPHEMERAL_TEST_SESSION,
            id: p1.id
        )
        
        let p1_r_n = try await Machine.Provider.retrieve(
            configuration: configuration,
            session: EPHEMERAL_TEST_SESSION,
            name: p1.name
        )
        
        #expect(p1_r_i?.id == p1.id)
        #expect(p1_r_n?.id == p1.id)
        
        return

    }
    
    @Test("Create & retrieve Rack")
    func testCreateAndRetrieveRack() async throws -> Void {
        
        let configuration = TestConfiguration.fromCommandLine()
        let geography = try await createTestGeography(
            configuration: configuration,
            session: EPHEMERAL_TEST_SESSION
        )
        
        let k = pseudoRandomId()
        
        let _ = try await Machine.Provider.create(
            configuration: configuration,
            session: EPHEMERAL_TEST_SESSION,
            name: "Provider_\(k)_"
        )
        
        let p = try await Machine.Provider.create(
            configuration: configuration,
            session: EPHEMERAL_TEST_SESSION,
            name: "Provider_\(k)"
        )

        let _ = try await Rack.create(
            configuration: configuration,
            session: EPHEMERAL_TEST_SESSION,
            name: "Rack_\(k)_",
            region: geography.region,
            provider: p
        )
        
        
        let r1 = try await Rack.create(
            configuration: configuration,
            session: EPHEMERAL_TEST_SESSION,
            name: "Rack_\(k)",
            region: geography.region,
            provider: p
        )
        
        let r1_r_i = try await Rack.retrieve(
            configuration: configuration,
            session: EPHEMERAL_TEST_SESSION,
            id: r1.id
        )
        
        let r1_r_n = try await Rack.retrieve(
            configuration: configuration,
            session: EPHEMERAL_TEST_SESSION,
            name: r1.name
        )
        
        #expect(r1_r_i?.id == r1.id)
        #expect(r1_r_n?.id == r1.id)
        
        return
        
    }
    
    @Test("Create & retrieve Machine")
    func testCreateAndRetrieveMachine() async throws -> Void {
        
        let configuration = TestConfiguration.fromCommandLine()
        let geography = try await createTestGeography(
            configuration: configuration,
            session: EPHEMERAL_TEST_SESSION
        )
        
        let k = pseudoRandomId()
        
        let p = try await Machine.Provider.create(
            configuration: configuration,
            session: EPHEMERAL_TEST_SESSION,
            name: "Provider_\(k)"
        )
        
        let r1 = try await Rack.create(
            configuration: configuration,
            session: EPHEMERAL_TEST_SESSION,
            name: "Rack_\(k)",
            region: geography.region,
            provider: p
        )

        let _ = try await Machine.create(
            configuration: configuration,
            session: EPHEMERAL_TEST_SESSION,
            ramMegabytes: 2048,
            cpuCoreCount: 1,
            diskSpaceMegabytes: 2048,
            ipv4: "10.20.30.40",
            ipv6: nil,
            rack: r1,
            architecture: .arm64,
            operatingSystem: .linux
        )
        
        let m1 = try await Machine.create(
            configuration: configuration,
            session: EPHEMERAL_TEST_SESSION,
            ramMegabytes: 2048,
            cpuCoreCount: 1,
            diskSpaceMegabytes: 2048,
            ipv4: "10.20.30.41",
            ipv6: nil,
            rack: r1,
            architecture: .arm64,
            operatingSystem: .linux
        )
        
        let m1_r = try await Machine.retrieve(
            configuration: configuration,
            session: EPHEMERAL_TEST_SESSION,
            id: m1.id
        )
        
        #expect(m1.id == m1_r?.publicId)
        
        return
        
    }
    
    
}
