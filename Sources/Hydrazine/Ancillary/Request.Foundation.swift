//
//  Request.Foundation.swift
//  HydrazineAPI
//
//  Created by Hugh on 2/1/2025.
//

import Foundation
#if !os(macOS) && canImport(FoundationNetworking)
import FoundationNetworking
#endif



fileprivate struct Placebo: Decodable {
    let placebo: String?
}

extension Request {
    
    static func make<C: ProvidesConfiguration, D: Decodable>(
        configuration: C,
        path: String,
        method: Self.Method,
        queryItems: Array<QueryItem> = []
    ) async throws(HydrazineError) -> D {
        
        return try await Self.make(
            configuration: configuration,
            path: path,
            method: method,
            queryItems: queryItems,
            session: nil as Session?
        )
        
    }
    
    static func make<C: ProvidesConfiguration, S: ProvidesSession, D: Decodable>(
        configuration: C,
        path: String,
        method: Self.Method,
        queryItems: Array<QueryItem> = [],
        session: S?
    ) async throws(HydrazineError) -> D {
        
        let result: D = try await Self.make(
            configuration: configuration,
            path: path,
            method: method,
            queryItems: queryItems,
            requestBody: nil as PlaceboEncodable?,
            session: session
        )
        
        return result
        
    }
    
    static func make<C: ProvidesConfiguration, E: Encodable>(
        configuration: C,
        path: String,
        method: Self.Method,
        requestBody: E
    ) async throws(HydrazineError) -> Void {
     
        return try await Self.make(
            configuration: configuration,
            path: path,
            method: method,
            requestBody: requestBody,
            session: nil as Session?
        )
        
    }
    
    static func make<C: ProvidesConfiguration, S: ProvidesSession, E: Encodable>(
        configuration: C,
        path: String,
        method: Self.Method,
        requestBody: E,
        session: S?
    ) async throws(HydrazineError) -> Void {
     
        let _: Placebo = try await Self.make(
            configuration: configuration,
            path: path,
            method: method,
            requestBody: requestBody,
            session: session
        )
        
        return
        
    }
    
    static func make<C: ProvidesConfiguration, S: ProvidesSession>(
        configuration: C,
        path: String,
        method: Self.Method,
        queryItems: Array<QueryItem> = [],
        session: S?
    ) async throws(HydrazineError) -> Void {
     
        let _: Placebo = try await Self.make(
            configuration: configuration,
            path: path,
            method: method,
            queryItems: queryItems,
            session: session
        )
        
        return
        
    }
    
    static func make<C: ProvidesConfiguration, S: ProvidesSession, E: Encodable, D: Decodable>(
        configuration: C,
        path: String,
        method: Self.Method,
        queryItems: Array<QueryItem> = [],
        requestBody: E?,
        session: S?
    ) async throws(HydrazineError) -> D {
        
        guard var urlComponents = URLComponents(
            string: configuration.apiEndpoint
        ) else {
            throw HydrazineError(clientFacingFriendlyMessage: """
The application failed to initialise components of a URL for communicating \
with the Hydrazine API
""")
        }

        urlComponents.path += path
        if queryItems.count > 0 {
            urlComponents.queryItems = queryItems.toUrlQueryItems()
        }
        
        guard let url = urlComponents.url else {
            throw HydrazineError(clientFacingFriendlyMessage: """
The application failed to initialise a URL for communicating with the Hydrazine \
API
""")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Hydrazine Swift", forHTTPHeaderField: "User-Agent")
        
        if let session = session {
            
            guard let apiKeyData = session.apiKey.data(using: .utf8) else {
                throw HydrazineError.signatureFormationFailure
            }
            
            let signature = try Signature.make(
                path: path,
                apiKey: apiKeyData
            )
            
            request.addValue(
                signature,
                forHTTPHeaderField: Signature.headerName
            )
            
            request.addValue(
                session.sessionId,
                forHTTPHeaderField: Session.headerIdName
            )
            
        }
    
        if let body = requestBody {
    
            let jsonData: Data
            do {
                jsonData = try Self.jsonEncoder.encode(body)
            } catch {
                throw HydrazineError(
                    clientFacingFriendlyMessage: """
Hydrazine was unable to encode data for transmission to the API.
"""
                )
            }

            request.httpBody = jsonData
            
            request.addValue(
                "application/json; charset=utf-8",
                forHTTPHeaderField: "Content-Type"
            )
            request.addValue(
                "\(jsonData.count)",
                forHTTPHeaderField: "Content-Length"
            )
        
        }
        
        let data: Data
        let response: URLResponse
    
        do {
            (data, response) = try await URLSession.shared.data(
                for: request,
                delegate: nil
            )
        } catch {
            throw HydrazineError(
                clientFacingFriendlyMessage: """
Hydrazine was unable to initialise a URLSession to transmit data to the API
""",
                technicalMessage: """
Failed to initialise URLSession: \(error)
"""
            )
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw HydrazineError(clientFacingFriendlyMessage: """
An HTTP request response could not be cast as an `HTTPURLResponse`
""")
        }
        
        guard httpResponse.statusCode == 200 else {
            
            let code = httpResponse.statusCode
            
            #if DEBUG
            
            var bodyData: String = "<nil>"
            
            if let body = requestBody,
               let jsonData = try? JSONEncoder().encode(body),
               let stringBody = String(data: jsonData, encoding: .utf8) {

                bodyData = stringBody
                
            }

            print("A request to Hydrazine API failed.")
            print("Request to: \(url.absoluteString)")
            print("Request method: \(method.rawValue)")
            print("Request headers:")
            print(request.allHTTPHeaderFields ?? "<nil>")
            print("Request body: \(bodyData)")
            print("Response code: \(code)")
            print("Response body:")
            
            if let bodyData = String(data: data, encoding: .utf8) {
                print(bodyData)
            } else {
                print("<unavailable>")
            }
    
            #endif
            
            var m: String = ""
            if let response = try? Self.jsonDecoder.decode(
                ErrorResponse.self,
                from: data
            ) {
                m = ". Message: \(response.technicalMessage)"
            }
            
            throw HydrazineError(clientFacingFriendlyMessage: """
The Hydrazine API responded to a request with a \(code) code\(m)
""")
        }

        let decoded: D
        do {
            decoded = try Self.jsonDecoder.decode(D.self, from: data)
        } catch {
            #if DEBUG
            print(String(bytes: data, encoding: .utf8)!)
            print(error)
            #endif
            throw HydrazineError(clientFacingFriendlyMessage: """
Hydrazine was unable to decode data returned by the API
""")
        }

        return decoded
    
    }
    
    struct ErrorResponse: Decodable {
        let technicalMessage: String
        private enum CodingKeys: String, CodingKey {
            case technicalMessage = "technical_message"
        }
    }
    
}

fileprivate extension Array<QueryItem> {
    
    func toUrlQueryItems() -> Array<URLQueryItem> {
        return self.map { return URLQueryItem(
            name: $0.name,
            value: $0.value
        )}
    }
    
}

