//
//  Machine.swift
//  Hydrazine
//
//  Created by Hugh on 4/1/2025.
//

/// A computing device, physical or virtual
///
/// One or more ``Server`` might run on a `Machine`.
public struct Machine: Decodable, Identifiable, Equatable, Hashable,
                       Sendable {
    
    internal static let path = "/machine"
    
    public static let maximumRamMegabytes = 1_024_000
    public static let maximumCpuCoreCount = 256
    public static let maximumDiskSpaceMegabytes = 1_000_000_000
    
    public static let minimumRamMegabytes = 512
    public static let minimumCpuCoreCount = 1
    public static let minimumDiskSpaceMegabytes = 1_024
    
    internal let publicId: String

    public let ramMegabytes: Int
    public let cpuCoreCount: Int
    public let diskMegabytes: Int
    public let architecture: Architecture
    public let operatingSystem: OperatingSystem
    public let ipv4: String?
    public let ipv6: String?
    public let disposition: Disposition
    
    public var id: String { return self.publicId }
    
    private enum CodingKeys: String, CodingKey {
        
        case publicId = "public_id"
        case ramMegabytes = "ram_megabytes"
        case cpuCoreCount = "cpu_core_count"
        case diskMegabytes = "disk_megabytes"
        case architecture
        case operatingSystem = "operating_system"
        case ipv4
        case ipv6
        case disposition
        
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.publicId == rhs.publicId
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.publicId)
        return
    }
    
}
