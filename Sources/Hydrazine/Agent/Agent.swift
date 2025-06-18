//
//  Agent.swift
//  HydrazineAPI
//
//  Created by Hugh on 2/1/2025.
//

import Foundation


/// An entity operating within the Hydrazine system
public protocol Agent {
    
    var agentId: AgentID { get }
    
}


public typealias AgentID = Int

public struct UnauthenticatedAgent {
    
    public let agentId: AgentID
    
    public init(agentId: AgentID) {
        self.agentId = agentId
    }
    
}
