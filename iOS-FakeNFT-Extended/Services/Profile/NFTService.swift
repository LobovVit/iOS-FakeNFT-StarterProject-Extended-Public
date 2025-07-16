//
//  NFTService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 02.07.2025.
//

protocol NFTServiceProtocol {
    func fetchNFT(by id: String) async throws -> NFTModel
}

// MARK: - NFTService

final class NFTService: NFTServiceProtocol {
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient = DefaultNetworkClient.shared) {
        self.networkClient = networkClient
    }
    
    func fetchNFT(by id: String) async throws -> NFTModel {
        let request = BasicRequest<NFTModel>(
            endpoint: ProfileRequestConstants.nftBase + "/\(id)",
            httpMethod: .get
        )
        return try await networkClient.send(request: request)
    }
}
