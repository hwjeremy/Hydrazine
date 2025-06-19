//
//  StandaloneAgent.swift
//  Hydrazine
//
//  Created by Hugh on 19/6/2025.
//

public struct StandaloneAgent: Agent {
    
    public let agentId: AgentID
    
}


extension Agent {
    
    public func toStandaloneAgent() -> StandaloneAgent {
        
        return StandaloneAgent(agentId: self.agentId)

    }
    
}
