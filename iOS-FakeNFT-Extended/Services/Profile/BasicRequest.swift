//
//  BasicRequest.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 01.07.2025.
//

import Foundation

struct BasicRequest<Response: Decodable>: NetworkRequest, Sendable {
    let endpoint: URL?
    let httpMethod: HttpMethod
    let dto: (any Encodable & Sendable)?
    let rawBody: Data?
    let queryItems: [URLQueryItem]
    let headers: [String: String]
    
    init(
        endpoint: String,
        httpMethod: HttpMethod,
        dto: (any Encodable & Sendable)? = nil,
        rawBody: Data? = nil,
        queryItems: [URLQueryItem] = [],
        headers: [String: String] = [:]
    ) {
        self.endpoint = URL(string: endpoint)!
        self.httpMethod = httpMethod
        self.dto = dto
        self.rawBody = rawBody
        self.queryItems = queryItems
        self.headers = headers
    }
}
