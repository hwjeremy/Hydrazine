//
//  Region.Headling.swift
//  Hydrazine
//
//  Created by Hugh on 6/1/2025.
//


extension Region {
    
    public struct Headline: Hashable, Equatable, Identifiable, Sendable,
                            Codable {
        
        public let name: String
        public let abbreviation: String
        
        public var id: String { return self.abbreviation }
        
        public static func == (lhs: Self, rhs: Self) -> Bool {
            return lhs.id == rhs.id
        }
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(self.id)
            return
        }
        
    }
    
}
