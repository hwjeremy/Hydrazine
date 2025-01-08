//
//  Ancillary.swift
//  Hydrazine
//
//  Created by Hugh on 6/1/2025.
//
import Hydrazine

struct TestGeography {
    
    let country: Country
    let region: Region
    
}

func createTestGeography<C: ProvidesConfiguration, S: ProvidesSession>(
    configuration: C,
    session: S
) async throws -> TestGeography {
    
    let k = pseudoRandomId()
    
    let c1 = try await Country.create(
        configuration: configuration,
        session: EPHEMERAL_TEST_SESSION,
        name: "AusTest_\(k)",
        iso3166a2: pseudoRandomId(2)
    )
    
    
    let r1_c = try await Region.create(
        configuration: configuration,
        session: EPHEMERAL_TEST_SESSION,
        name: "AusTest_(\(k)",
        abbreviation: pseudoRandomId(3),
        country: c1
    )
    
    return TestGeography(country: c1, region: r1_c)
    
}

struct TestMachine {
    
    let geography: TestGeography
    
    let domain: Domain
    let provider: Machine.Provider
    let rack: Rack
    let machine: Machine
    
}

func createTestMachine<C: ProvidesConfiguration, S: ProvidesSession>(
    configuration: C,
    session: S
) async throws -> TestMachine {
    
    let geography: TestGeography = try await createTestGeography(
        configuration: configuration,
        session: session
    )
    
    let k = pseudoRandomId()
    
    let p = try await Machine.Provider.create(
        configuration: configuration,
        session: EPHEMERAL_TEST_SESSION,
        name: "Provider_\(k)"
    )
    
    let d1 = try await Domain.create(
        configuration: configuration,
        session: EPHEMERAL_TEST_SESSION,
        name: "\(k).1coy.net"
    )
    
    let r1 = try await Rack.create(
        configuration: configuration,
        session: EPHEMERAL_TEST_SESSION,
        name: "Rack_\(k)",
        region: geography.region,
        provider: p
    )
    
    let m1 = try await Machine.create(
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
    
    return TestMachine(
        geography: geography,
        domain: d1,
        provider: p,
        rack: r1,
        machine: m1
    )

}
