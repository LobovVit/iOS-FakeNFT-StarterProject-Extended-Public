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
    private let cartStorage = CartStorage.shared
    private let cartService = CartService.shared
    
    init(nfts: [NFTItem]) {
        self.displayedNFTs = nfts
    }
    
    func isFavorite(for id: String) -> Bool {
        favoritesStorage.favoriteNFTIDs.contains(id)
    }
    
    func toggleFavorite(for id: String) {
        favoritesStorage.toggleFavorite(id: id)
        objectWillChange.send()
        print(isFavorite(for: id)
              ? "✅ NFT добавлено в избранное: \(id)"
              : "❌ NFT удалено из избранного: \(id)")
    }
    
    func isInCart(for id: String) -> Bool {
        cartStorage.isInCart(id: id)
    }
    
    func toggleCart(for id: String) {
        cartStorage.toggleCart(id: id)
        objectWillChange.send()
        print(isInCart(for: id)
              ? "🛒 NFT добавлено в корзину: \(id)"
              : "🛒 NFT удалено из корзины: \(id)")
        
        Task {
            do {
                let updatedIds = cartStorage.cartNFTIDs
                try await cartService.updateOrder(nftIds: updatedIds)
            } catch {
                print("Ошибка при обновлении корзины на сервере: \(error)")
            }
        }
    }
}
