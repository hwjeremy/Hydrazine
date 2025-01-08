//
//  Configuration.swift
//  HydrazineAPI
//
//  Created by Hugh on 2/1/2025.
//

import Foundation

/// Requirements for a type providing Hydrazine configuration data
public protocol ProvidesConfiguration {
    
    var apiEndpoint: String { get }

}
