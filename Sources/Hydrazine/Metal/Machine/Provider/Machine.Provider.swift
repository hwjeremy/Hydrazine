//
//  Machine.Provider.swift
//  Hydrazine
//
//  Created by Hugh on 4/1/2025.
//

extension Machine {
    
    /// An entity that offers computing devices.
    ///
    /// Examples of provides include AWS, Azure, and KHM Corp. itself.
    public struct Provider: Identifiable, Hashable, Equatable, Decodable,
                            Sendable {
        
        internal static let path = Machine.path + "/provider"
        
        public static let maximumNameLength = 64
        
        public var id: Int { return self.indexid }
        
        public static func == (lhs: Self, rhs: Self) -> Bool {
            return lhs.indexid == rhs.indexid
        }
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(self.indexid)
            return
        }
        
        internal let indexid: Int

        public let name: String
        public let disposition: Disposition
        
    }
    
}
