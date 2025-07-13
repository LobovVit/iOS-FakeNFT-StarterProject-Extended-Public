//
//  CatalogService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 26.06.2025.
//

import Foundation

final class CatalogService {
    static let shared = CatalogService()
    private let client: NetworkClient

    private init(client: NetworkClient = DefaultNetworkClient()) {
        self.client = client
    }

    func fetchCollections() async throws -> [CollectionDTO] {
        try await client.send(request: CollectionsRequest())
    }

    func fetchNFTs() async throws -> [NFTItem] {
        try await client.send(request: NFTsRequest())
    }
}

