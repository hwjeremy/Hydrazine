//
//  Error.swift
//  HydrazineAPI
//
//  Created by Hugh on 2/1/2025.
//
#if canImport(os)
import os
fileprivate let fallbackLogger = Logger(
    subsystem: "com.khmcorp.Impulse",
    category: "Impulse"
)
#endif

public struct HydrazineError: Error {
    
    public let clientFacingFriendlyMessage: String
    
    public let technicalMessage: String?
    
    internal init(
        clientFacingFriendlyMessage: String
    ) {
        self.clientFacingFriendlyMessage = clientFacingFriendlyMessage
        self.technicalMessage = nil
    }

    internal init(
        clientFacingFriendlyMessage: String,
        technicalMessage: String
    ) {
        
        self.init(
            clientFacingFriendlyMessage: clientFacingFriendlyMessage,
            technicalMessage: technicalMessage,
            log: PlaceboLogType()
        )
        
    }
    
    internal init<L: MayLogHydrazineErrors>(
        clientFacingFriendlyMessage: String,
        technicalMessage: String,
        log: L
    ) {
        
        self.clientFacingFriendlyMessage = clientFacingFriendlyMessage
        self.technicalMessage = technicalMessage
        
        let logString = "[Hydrazine Swift \(VERSION)] \(technicalMessage)"

        Task {
            await log.log(logString)
        }
        
        return
    
    }
    
    static let notImplemented: Self = .init(
        clientFacingFriendlyMessage: """
The requested function is not yet implemented
"""
    )
    
    static let inconsistentState: Self = .init(
        clientFacingFriendlyMessage: """
The app has entered an inconsistent state, and may not function properly
"""
    )

    static let signatureFormationFailure: Self = .init(
        clientFacingFriendlyMessage: """
The app could not perform a cryptography operation, and has stopped as a \
precaution.
"""
    )
    
}

#if canImport(Foundation)
import Foundation

extension HydrazineError: LocalizedError {
    
    public var errorDescription: String? {
        return self.clientFacingFriendlyMessage
    }
    
}
#endif


public protocol MayLogHydrazineErrors: Sendable {
    
    func log(_ string: String) async -> Void

}


internal struct PlaceboLogType: MayLogHydrazineErrors {
    
    func log(_ string: String) async {
        #if canImport(os)
        fallbackLogger.log("\(string, privacy: .public)")
        #else
        print(string)
        #endif
        return
    }
    
}
