//
//  FavoritesNFTViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 30.06.2025.
//

import Foundation

@MainActor
final class FavoritesNFTViewModel: ObservableObject {
    @Published var allNFTs: [NFTModel] = []
    @Published var sortedNFTs: [NFTModel] = []

    @Published var selectedSortOption: SortStorage.SortOption {
        didSet {
            sortStorage.selectedSortOption = selectedSortOption
            sortAndUpdateNFTs()
        }
    }

    private let sortStorage = SortStorage()
    private let nftService: NFTServiceProtocol
    private let profileStorage: ProfileStorage
    private let favoritesStorage: FavoritesStorage

    init(
        nftService: NFTServiceProtocol = NFTService(),
        profileStorage: ProfileStorage = .shared,
        favoritesStorage: FavoritesStorage = .shared
    ) {
        self.nftService = nftService
        self.profileStorage = profileStorage
        self.favoritesStorage = favoritesStorage
        self.selectedSortOption = sortStorage.selectedSortOption

        Task {
            await loadNFTs()
        }
    }
    
    func toggleFavorite(for id: String) async {
        favoritesStorage.toggleFavorite(id: id)
        await loadNFTs()
    }

    func loadNFTs() async {
        guard let profile = profileStorage.load() else {
            print("⚠️ Профиль не найден в сторедже")
            return
        }

        do {
            let loadedNFTs = try await withThrowingTaskGroup(of: NFTModel.self) { group in
                for nftID in profile.likes {
                    group.addTask {
                        try await self.nftService.fetchNFT(by: nftID)
                    }
                }

                var results: [NFTModel] = []
                for try await nft in group {
                    results.append(nft)
                }
                return results
            }

            self.allNFTs = loadedNFTs
            sortAndUpdateNFTs()
        } catch {
            print("🚨 Ошибка загрузки избранных NFT: \(error)")
        }
    }

    func sortAndUpdateNFTs() {
        switch selectedSortOption {
        case .byName:
            sortedNFTs = allNFTs.sorted { $0.name < $1.name }
        case .byPrice:
            sortedNFTs = allNFTs.sorted { $0.price < $1.price }
        case .byRating:
            sortedNFTs = allNFTs.sorted { $0.rating > $1.rating }
        }
    }
}
