//
//  Rack.swift
//  Hydrazine
//
//  Created by Hugh on 4/1/2025.
//

/// A logical grouping of ``Machine``
///
/// A `Rack` might be a physical collection of computers, or a virtual
/// grouping of virtual machines, or any combination thereof.
///
/// The grouping
/// should logically occur within a ``Region``, such that ``Server`` instances
/// running on `Machine` instances in the `Rack` can be offered collectively
/// to clients with a reasonable expectation of certain latency
/// characteristics.
public struct Rack: Identifiable, Hashable, Equatable, Decodable, Sendable {
    
    internal let publicId: String
    
    public let name: String
    public let region: Region
    public let disposition: Disposition
    public let provider: Machine.Provider
    
    public var id: String { return self.publicId }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.publicId)
        return
    }
    
    public static let minimumNameLength = 3
    public static let maximumNameLength = 128

    internal static let path = "/rack"
    
    private enum CodingKeys: String, CodingKey {
        
        case publicId = "public_id"
        case name
        case region
        case provider
        case disposition
        
    }
    
}
