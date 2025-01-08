//
//  Country.Hea.swift
//  Hydrazine
//
//  Created by Hugh on 6/1/2025.
//

extension Country {
    
    public struct Headline: Hashable, Equatable, Identifiable, Sendable,
                            Codable {
        
        public let name: String
        public let iso3166a2: String
        
        public var id: String { return self.iso3166a2 }
        
        public static func == (lhs: Self, rhs: Self) -> Bool {
            return lhs.id == rhs.id
        }
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(self.id)
            return
        }
        
    }
    
}

