//
//  CatalogRequests.swift
//  iOS-FakeNFT-Extended
//
//  Created by Demain Petropavlov on 28.06.2025.
//

import Foundation

struct CollectionsRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/collections")
    }
}

struct NFTsRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/nfts")
    }
}

