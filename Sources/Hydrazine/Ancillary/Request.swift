//
//  Request.swift
//  HydrazineAPI
//
//  Created by Hugh on 2/1/2025.
//

import Foundation
import Crypto


internal struct Request {
    
    internal struct PlaceboEncodable: Encodable { let p: Int }
    
    internal static let jsonEncoder: JSONEncoder = {
        
        let encoder = JSONEncoder()
        
        encoder.dateEncodingStrategy = .custom({ date, encoder in
            let doubleValue = date.timeIntervalSince1970
            try doubleValue.encode(to: encoder)
            return
        })
        
        return encoder
        
    }()

    internal static let jsonDecoder: JSONDecoder = {

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom({ decoder in
            let container = try decoder.singleValueContainer()
            let timeIntervalSinceEpoch = try container.decode(Double.self)
            return Date(timeIntervalSince1970: timeIntervalSinceEpoch)
        })
        
        return decoder
        
    }()
    
    internal struct Signature {
        
        internal static let headerName: String = "X-Signature"
        
        private static let timestampResolution = 900
        
        internal static func make(
            path: borrowing String,
            apiKey: Data
        ) throws(HydrazineError) -> String {
            
            let timestamp = Int(Date().timeIntervalSince1970)
            let timekey = timestamp - (timestamp % Self.timestampResolution)
            let stringToHash = String(describing: timekey) + path

            guard let stringData = stringToHash.data(using: .utf8) else {
                throw HydrazineError.signatureFormationFailure
            }
            
            let hmac = HMAC<SHA256>.authenticationCode(
                for: stringData,
                using: SymmetricKey(data: apiKey)
            )

            let hmacData = Data(hmac)
            let base64 = hmacData.base64EncodedString()

            return base64

        }
        
    }

    internal enum Method: String {
        
        case GET = "GET"
        case POST = "POST"
        case DELETE = "DELETE"
        
    }
    
}
