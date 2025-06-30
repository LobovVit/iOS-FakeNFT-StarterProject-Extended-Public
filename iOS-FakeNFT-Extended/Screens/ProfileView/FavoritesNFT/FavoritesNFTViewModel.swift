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

    init() {
        self.selectedSortOption = sortStorage.selectedSortOption
        loadNFTs()
    }

    func loadNFTs() {
        // Загружаем только избранные
        self.allNFTs = MockData.nfts.filter { $0.isFavorite }
        sortAndUpdateNFTs()
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
