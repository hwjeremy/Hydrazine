//
//  CountryTests.swift
//  Hydrazine
//
//  Created by Hugh on 3/1/2025.
//
import Testing
@testable import Hydrazine
import Foundation


@Suite("Geographic")
struct GeographicTests {
    
    @Test("Create & retrieve Country")
    func testCreateRetrieveCountry() async throws -> Void {
        
        let configuration = TestConfiguration.fromCommandLine()
        
        let _ = try await Country.retrieveMany(
            configuration: configuration,
            session: EPHEMERAL_TEST_SESSION
        )

        let k = pseudoRandomId()
        
        let c1 = try await Country.create(
            configuration: configuration,
            session: EPHEMERAL_TEST_SESSION,
            name: "AusTest_\(k)",
            iso3166a2: pseudoRandomId(2)
        )
        
        let c1_r = try await Country.retrieveMany(
            configuration: configuration,
            session: EPHEMERAL_TEST_SESSION,
            id: c1.id
        )
        
        #expect(c1_r.first?.id == c1.id)
        
        return
        
    }
    
    @Test("Create & retrieve Region")
    func testCreateRetrieveRegion() async throws -> Void {
        
        let configuration = TestConfiguration.fromCommandLine()
        
        let _ = try await Region.retrieveMany(
            configuration: configuration,
            session: EPHEMERAL_TEST_SESSION
        )
        
        let k = pseudoRandomId()
        
        let australia = try await Country.create(
            configuration: configuration,
            session: EPHEMERAL_TEST_SESSION,
            name: "AusTest_\(k)",
            iso3166a2: pseudoRandomId(2)
        )
        
        let _ = try await Region.create(
            configuration: configuration,
            session: EPHEMERAL_TEST_SESSION,
            name: "AusTest_(\(k)_",
            abbreviation: pseudoRandomId(3),
            country: australia
        )
        
        let r1_c = try await Region.create(
            configuration: configuration,
            session: EPHEMERAL_TEST_SESSION,
            name: "AusTest_(\(k)",
            abbreviation: pseudoRandomId(3),
            country: australia
        )
        
        let r1 = try await Region.retrieveMany(
            configuration: configuration,
            session: EPHEMERAL_TEST_SESSION,
            id: r1_c.id
        ).first
        
        #expect(r1_c.id == r1?.id)
        
        return

    }
    
}
