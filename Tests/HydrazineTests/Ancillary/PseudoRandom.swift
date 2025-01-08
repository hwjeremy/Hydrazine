//
//  PseudoRandom.swift
//  Hydrazine
//
//  Created by Hugh on 5/1/2025.
//
import Foundation


func pseudoRandomId(_ length: Int = 6) -> String {
    return String(UUID().uuidString.prefix(length))
}

