//
//  ServerTests.swift
//  Hydrazine
//
//  Created by Hugh on 6/1/2025.
//

import Testing
@testable import Hydrazine
import Foundation

@Suite("Server Tests")
struct ServerTests {
    
    @Test("Create & retrieve Server")
    func createAndRetrieveServer() async throws -> Void {
        
        let configuration = TestConfiguration.fromCommandLine()
        
        let testData: TestMachine = try await createTestMachine(
            configuration: configuration,
            session: EPHEMERAL_TEST_SESSION
        )
        
        let s1 = try await Server.create(
            configuration: configuration,
            session: EPHEMERAL_FLEET_TEST_SESSION,
            ipv4Port: 4001,
            ipv6Port: 6001,
            machine: testData.machine
        )
        
        let s1_r = try await Server.retrieve(
            configuration: configuration,
            session: EPHEMERAL_TEST_SESSION,
            id: s1.id
        )
        
        #expect(s1.id == s1_r?.id)
        
        return
        
    }
    
    @Test("Create Server.PeriodicUpdate")
    func createServerPeriodicUpdate() async throws -> Void {
        
        let configuration = TestConfiguration.fromCommandLine()
        
        let testData: TestMachine = try await createTestMachine(
            configuration: configuration,
            session: EPHEMERAL_TEST_SESSION
        )
        
        let s1 = try await Server.create(
            configuration: configuration,
            session: EPHEMERAL_FLEET_TEST_SESSION,
            ipv4Port: 4001,
            ipv6Port: 6001,
            machine: testData.machine
        )
        
        try await Server.PeriodicUpdate.create(
            configuration: configuration,
            session: EPHEMERAL_FLEET_TEST_SESSION,
            server: s1,
            clientCapacity: 10,
            clientsConnected: 3,
            health: .good
        )
        
        try await Task.sleep(for: .milliseconds(100))

        try await Server.PeriodicUpdate.create(
            configuration: configuration,
            session: EPHEMERAL_FLEET_TEST_SESSION,
            server: s1,
            clientCapacity: 10,
            clientsConnected: 3,
            health: .good
        )
        
        return
        
    }
    
    @Test("Retrieve Server.Listing")
    func retrieveServerListing() async throws -> Void {
        
        let configuration = TestConfiguration.fromCommandLine()
        
        let testData: TestMachine = try await createTestMachine(
            configuration: configuration,
            session: EPHEMERAL_TEST_SESSION
        )
        
        let s1 = try await Server.create(
            configuration: configuration,
            session: EPHEMERAL_FLEET_TEST_SESSION,
            ipv4Port: 4001,
            ipv6Port: 6001,
            machine: testData.machine
        )
        
        try await Server.PeriodicUpdate.create(
            configuration: configuration,
            session: EPHEMERAL_FLEET_TEST_SESSION,
            server: s1,
            clientCapacity: 10,
            clientsConnected: 3,
            health: .good
        )
        
        // Wait for Hydrazine to have time to updating listings
        try await Task.sleep(for: .milliseconds(1500))
        
        let listings = try await Server.Listing.retrieveMany(
            configuration: configuration,
            session: EPHEMERAL_TEST_SESSION,
            limit: 100
        )
        
        #expect(listings.count > 0)
        #expect(listings.count <= 100)
        
        let foundS1 = listings.reduce(false) { partialResult, listing in
            if listing.serverId == s1.id { return true }
            return false
        }
        
        #expect(foundS1 == true)
        
        return
        
    }
    
    @Test("Observer Server.Listing appearance / falloff")
    func serverListingAppearAndFallOff() async throws -> Void {
        
        let configuration = TestConfiguration.fromCommandLine()
        
        let testData: TestMachine = try await createTestMachine(
            configuration: configuration,
            session: EPHEMERAL_TEST_SESSION
        )
        
        let s1 = try await Server.create(
            configuration: configuration,
            session: EPHEMERAL_FLEET_TEST_SESSION,
            ipv4Port: 4001,
            ipv6Port: 6001,
            machine: testData.machine
        )
        
        try await Server.PeriodicUpdate.create(
            configuration: configuration,
            session: EPHEMERAL_FLEET_TEST_SESSION,
            server: s1,
            clientCapacity: 10,
            clientsConnected: 3,
            health: .good
        )
        
        // Wait so long that the listing should fall off
        try await Task.sleep(for: .milliseconds(3500))
        
        let listings = try await Server.Listing.retrieveMany(
            configuration: configuration,
            session: EPHEMERAL_TEST_SESSION,
            limit: 100
        )
        
        #expect(listings.count <= 100)
        
        let foundS1 = listings.reduce(false) { partialResult, listing in
            if listing.serverId == s1.id { return true }
            return false
        }
        
        #expect(foundS1 == false)
        
        try await Server.PeriodicUpdate.create(
            configuration: configuration,
            session: EPHEMERAL_FLEET_TEST_SESSION,
            server: s1,
            clientCapacity: 10,
            clientsConnected: 3,
            health: .good
        )
        
        // Wait for the new update to be picked up
        try await Task.sleep(for: .milliseconds(1500))
        
        let listings_b = try await Server.Listing.retrieveMany(
            configuration: configuration,
            session: EPHEMERAL_TEST_SESSION,
            limit: 100
        )
        
        let foundS1_b = listings_b.reduce(false) { partialResult, listing in
            if listing.serverId == s1.id { return true }
            return false
        }
        
        #expect(foundS1_b == true)
        
        return
        
    }
    
}
