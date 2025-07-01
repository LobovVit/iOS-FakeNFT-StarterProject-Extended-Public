//
//  CollectionDetailViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Demain Petropavlov on 01.07.2025.
//

import Foundation

final class CollectionDetailViewModel: ObservableObject {
    @Published var displayedNFTs: [NFTItem]

    private let favoritesStorage = FavoritesStorage()
    private var cartItems: Set<String> = []

    init(nfts: [NFTItem]) {
        self.displayedNFTs = nfts
    }

    func isFavorite(for id: String) -> Bool {
        favoritesStorage.favoriteNFTIDs.contains(id)
    }

    func toggleFavorite(for id: String) {
        favoritesStorage.toggleFavorite(id: id)
        objectWillChange.send()
        
        if isFavorite(for: id) {
            print("✅ NFT добавлено в избранное: \(id)")
        } else {
            print("❌ NFT удалено из избранного: \(id)")
        }
    }

    func isInCart(for id: String) -> Bool {
        cartItems.contains(id)
    }

    func toggleCart(for id: String) {
        if cartItems.contains(id) {
            cartItems.remove(id)
            print("🛒 NFT удалено из корзины: \(id)")
        } else {
            cartItems.insert(id)
            print("🛒 NFT добавлено в корзину: \(id)")
        }
        objectWillChange.send()
    }
}
