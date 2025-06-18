//
//  Newsletter.Subscription.swift
//  Hydrazine
//
//  Created by Hugh on 6/2/2025.
//

extension Newsletter {
    
    public struct Subscription {
        
        public static func create<C: ProvidesConfiguration, S: ProvidesSession>(
            configuration: C,
            session: S,
            emailAddress: String
        ) async throws(HydrazineError) -> Self {
            
            throw HydrazineError.notImplemented
            
        }
        
    }
    
}
