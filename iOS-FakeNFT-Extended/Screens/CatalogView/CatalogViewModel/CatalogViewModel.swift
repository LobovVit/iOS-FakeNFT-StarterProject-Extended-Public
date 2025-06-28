//
//  CatalogViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Demain Petropavlov on 28.06.2025.
//

import SwiftUI

@MainActor
class CatalogViewModel: ObservableObject {
    @Published var collections: [CollectionDTO] = []
    @Published var nfts: [NFTItem] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service = CatalogService.shared

    func loadData() async {
        isLoading = true
        defer { isLoading = false }

        do {
            collections = try await service.fetchCollections()
            nfts = try await service.fetchNFTs()
            errorMessage = nil
        } catch {
            errorMessage = "Ошибка загрузки данных: \(error.localizedDescription)"
        }
    }

    func nfts(for collectionId: String) -> [NFTItem] {
        guard let collection = collections.first(where: { $0.id == collectionId }) else {
            return []
        }
        return nfts.filter { collection.nfts.contains($0.id) }
    }

    enum SortOption {
        case name
        case nftCount
    }

    func sortCollections(by option: SortOption) {
        switch option {
        case .name:
            collections.sort { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
        case .nftCount:
            collections.sort { $0.nfts.count > $1.nfts.count }
        }
    }
}
