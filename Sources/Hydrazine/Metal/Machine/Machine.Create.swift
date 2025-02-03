//
//  Machine.Create.swift
//  Hydrazine
//
//  Created by Hugh on 4/1/2025.
//

extension Machine {
    
    public static func create<O>(
        in context: O,
        ramMegabytes: UInt32,
        cpuCoreCount: UInt8,
        diskSpaceMegabytes: UInt32,
        ipv4: String?,
        ipv6: String?,
        rack: Rack,
        architecture: Machine.Architecture,
        operatingSystem: Machine.OperatingSystem
    ) async throws(HydrazineError) -> Self
    where O: ProvidesConfiguration, O: ProvidesSession {
     
        return try await Machine.create(
            configuration: context,
            session: context,
            ramMegabytes: ramMegabytes,
            cpuCoreCount: cpuCoreCount,
            diskSpaceMegabytes: diskSpaceMegabytes,
            ipv4: ipv4,
            ipv6: ipv6,
            rack: rack,
            architecture: architecture,
            operatingSystem: operatingSystem
        )
        
    }
    
    public static func create<C: ProvidesConfiguration, S: ProvidesSession>(
        configuration: C,
        session: S,
        ramMegabytes: UInt32,
        cpuCoreCount: UInt8,
        diskSpaceMegabytes: UInt32,
        ipv4: String?,
        ipv6: String?,
        rack: Rack,
        architecture: Machine.Architecture,
        operatingSystem: Machine.OperatingSystem
    ) async throws(HydrazineError) -> Self {
        
        guard ramMegabytes <= Self.maximumRamMegabytes else {
            throw HydrazineError(clientFacingFriendlyMessage: """
Ram megabytes exceeds maximum (\(Self.maximumRamMegabytes))
""")
        }
        
        guard ramMegabytes >= Self.minimumRamMegabytes else {
            throw HydrazineError(clientFacingFriendlyMessage: """
Ram megabytes below minimum (\(Self.minimumRamMegabytes))
""")
        }

        guard cpuCoreCount <= Self.maximumCpuCoreCount else {
            throw HydrazineError(clientFacingFriendlyMessage: """
CPU core count exceeds maximum (\(Self.maximumCpuCoreCount))
""")
        }
        
        guard cpuCoreCount >= Self.minimumCpuCoreCount else {
            throw HydrazineError(clientFacingFriendlyMessage: """
CPU core count below minimum (\(Self.minimumCpuCoreCount))
""")
        }

        guard diskSpaceMegabytes <= Self.maximumDiskSpaceMegabytes else {
            throw HydrazineError(clientFacingFriendlyMessage: """
Disk space megabytes exceeds maximum (\(Self.maximumDiskSpaceMegabytes))
""")
        }
        
        guard diskSpaceMegabytes >= Self.minimumDiskSpaceMegabytes else {
            throw HydrazineError(clientFacingFriendlyMessage: """
Disk space megabytes below minimum (\(Self.minimumDiskSpaceMegabytes))
""")
        }
        
        guard ipv4 != nil || ipv6 != nil else {
            throw HydrazineError(clientFacingFriendlyMessage: """
Supply at least one of ipv4 or ipv6
""")
        }

        let payload = CreatePayload(
            ram_megabytes: Int(ramMegabytes),
            cpu_core_count: Int(cpuCoreCount),
            disk_space_megabytes: Int(diskSpaceMegabytes),
            ipv4: ipv4,
            ipv6: ipv6,
            rack: rack.publicId,
            architecture: architecture.rawValue,
            operating_system: operatingSystem.rawValue
        )
        
        let machine: Machine = try await Request.make(
            configuration: configuration,
            path: Self.path,
            method: .POST,
            requestBody: payload,
            session: session
        )
        
        return machine
        
    }
    
    private struct CreatePayload: Encodable {
        
        let ram_megabytes: Int
        let cpu_core_count: Int
        let disk_space_megabytes: Int
        let ipv4: String?
        let ipv6: String?
        let rack: String
        let architecture: Int
        let operating_system: Int
        
    }
    
}
