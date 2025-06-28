//
//  CatalogService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 26.06.2025.
//

import Foundation

class CatalogService {
    static let shared = CatalogService()

    private let baseURL = RequestConstants.baseURL
    private let token = RequestConstants.token

    func fetchCollections() async throws -> [CollectionDTO] {
        let url = URL(string: "\(baseURL)/collections")!
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode([CollectionDTO].self, from: data)
    }

    func fetchNFTs() async throws -> [NFTItem] {
        let url = URL(string: "\(baseURL)/nfts")!
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode([NFTItem].self, from: data)
    }
}
