//
//  FavoritesNFTViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 30.06.2025.
//

import Foundation

final class FavoritesNFTViewModel: ObservableObject {
    @Published var nfts: [NFTModel] = []

    func loadFavorites() {
        // пока мок
        self.nfts = MockData.nfts.filter { $0.isFavorite }
    }
}
