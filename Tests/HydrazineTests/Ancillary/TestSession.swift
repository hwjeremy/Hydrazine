//
//  TestSession.swift
//  Hydrazine
//
//  Created by Hugh on 5/1/2025.
//
@testable import Hydrazine


/// This `Session` is guaranteed to exist if the Hydrazine API is started
/// in ephemeral test mode.
let EPHEMERAL_TEST_SESSION = Session(
    agentId: 100,
    sessionId: "SESSION_EPHEMERAL_TEST_ID",
    apiKey: "PLACEBO"
)


/// This `Session` is guaranteed to exist if the Hydrazine API is started
/// in ephemeral test mode.
let EPHEMERAL_FLEET_TEST_SESSION = Session(
    agentId: 2,
    sessionId: "SESSION_EPHEMERAL_FLEET_TEST_ID",
    apiKey: "PLACEBO"
)
