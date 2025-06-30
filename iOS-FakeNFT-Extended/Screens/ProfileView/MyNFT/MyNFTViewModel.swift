//
//  MyNFTViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 30.06.2025.
//

import Foundation

final class MyNFTViewModel: ObservableObject {
    @Published var nfts: [NFTModel] = []
    @Published var sortOption: SortOption = .name

    var sortedNFTs: [NFTModel] {
        switch sortOption {
        case .name:
            return nfts.sorted { $0.name < $1.name }
        case .price:
            return nfts.sorted { $0.price < $1.price }
        case .rating:
            return nfts.sorted { $0.rating > $1.rating }
        }
    }
    
    func loadNFTs() {
        // пока мок
        self.nfts = MockData.nfts
    }
}

enum SortOption: CaseIterable {
    case name, price, rating

    var title: String {
        switch self {
        case .name: return "По названию"
        case .price: return "По цене"
        case .rating: return "По рейтингу"
        }
    }
}
