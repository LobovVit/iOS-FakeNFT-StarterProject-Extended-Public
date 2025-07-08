//
//  CatalogViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Demain Petropavlov on 28.06.2025.
//

import SwiftUI

@MainActor
final class CatalogViewModel: ObservableObject {
    @Published var collections: [CollectionDTO] = []
    @Published var nfts: [NFTItem] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service = CatalogService.shared
    private let sortStorage = SortStorage()

    func loadData() async {
        isLoading = true
        defer { isLoading = false }

        do {
            async let collectionsTask = service.fetchCollections()
            async let nftsTask = service.fetchNFTs()

            let (fetchedCollections, fetchedNFTs) = try await (collectionsTask, nftsTask)

            self.collections = fetchedCollections
            self.nfts = fetchedNFTs
            sortCollections()
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

    func sortCollections(by option: SortStorage.SortOption) {
        sortStorage.selectedSortOption = option
        sortCollections()
    }

    func sortCollections() {
        switch sortStorage.selectedSortOption {
        case .byName:
            collections.sort { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
        case .byCount:
            collections.sort { $0.nfts.count > $1.nfts.count }
        default:
            break
        }
    }
}
